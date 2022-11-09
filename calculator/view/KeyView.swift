//
//  KeyView.swift
//  calculator
//
//  Created by Zimmy Changela on 07/11/22.
//

import SwiftUI

struct KeyView: View {
    
    //check this new comit
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation : Operation = .none
    @State private var changeColor = false
    
    let buttons:[[keys]] = [
        [.clear,.negative,.percent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.nine,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]
    ]
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(changeColor ?
                        Color("num").opacity(0.4):Color.pink.opacity(0.2))
                    .scaleEffect(changeColor ?  1.5 : 1.0)
                    .frame(width: 350,height: 280)
                    .animation(Animation.easeInOut.speed(0.17).repeatForever(),value:changeColor)
                    .onAppear(perform: {
                        self.changeColor.toggle()
                    })
                    .overlay(Text(value)
                        .bold()
                        .font(.system(size: 100))
                    .foregroundColor(.black))
            }.padding()
            ForEach(buttons, id: \.self){ row in
                HStack(spacing: 10){
                    ForEach(row, id:\.self){ element in
                        Button{
                            self.didTap(button:element)
                        } label: {
                            Text(element.rawValue)
                                .font(.system(size: 30))
                                .frame(width:self.getWidth(element: element),height:self.getHeight(element: element))
                                .background(element.buttonColor)
                                .foregroundColor(.black)
                                .cornerRadius(self.getWidth(element: element)/2)
                                .shadow(color: .purple.opacity(0.8),
                                radius: 30)
                        }
                    }
                }.padding(.bottom,4)
            }
        }
    }
    
    func getWidth(element:keys)-> CGFloat{
        if(element == .zero){
            return (UIScreen.main.bounds.width - 5*10)/2
        }
        return (UIScreen.main.bounds.width - 5*10)/4
    }
    
    func getHeight(element:keys) -> CGFloat {
        return (UIScreen.main.bounds.width - 5*10)/5
    }
    
    func didTap(button:keys){
        switch button{
        case .add,.subtract,.divide,.multiply,.equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            } else {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                    
                case .subtract: self.value = "\(runningValue - currentValue)"
                    
                case .divide: self.value = "\(runningValue/currentValue)"
                    
                case .multiply: self.value = "\(runningValue*currentValue)"
                    
                case .none:
                    break
                case .equal:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value="0"
        case .decimal,.negative,.percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
