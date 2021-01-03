//
//  ContentView.swift
//  CalculatorApp
//
//  Created by RyoNishimura on 2020/08/28.
//  Copyright © 2020 RyoNishimura. All rights reserved.
//  Modified by @taisukef 2021-01-01

import SwiftUI

struct ContentView: View {
    @State var result = "0"
    let btn = [
        ["7", "8", "9", "÷"],
        ["4", "5", "6", "×"],
        ["1", "2", "3", "-"],
        ["0", "C", "=", "+"]
    ]
    var body: some View {
        VStack {
            Spacer()
            Text(result)
                .font(.largeTitle)
                .padding(10)
            Spacer()
            ForEach(0...3, id: \.self) { row in
                HStack {
                    ForEach(0...3, id: \.self) { col in
                        Button(action: {
                            let s = self.btn[row][col]
                            if Double(s) != nil { // 数
                                if self.result != "0" {
                                    self.result += s
                                } else {
                                    self.result = s
                                }
                            } else {
                                if s == "C" {
                                    self.result = "0"
                                } else if s == "=" {
                                    self.result = self.calc(self.result)
                                } else { // 演算子
                                    let ss = self.result.components(separatedBy: " ")
                                    if ss.count == 3 { // 計算
                                        self.result = self.calc(self.result)
                                    }
                                    self.result += " " + s + " "
                                }
                            }
                        }) {
                            Spacer()
                            Text(self.btn[row][col])
                            Spacer()
                        }
                        
                    }
                }
                .padding(10)
            }
            Spacer()
        }
    }
    func calc(_ s: String) -> String {
        let ss = s.components(separatedBy: " ")
        let a = Double(ss[0])!
        let op = ss[1]
        let b = Double(ss[2])!
        var res = 0.0
        switch op {
        case "+":
            res = a + b
        case "-":
            res = a - b
        case "×":
            res = a * b
        case "÷":
            res = a / b
        default:
            break
        }
        return String(res)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
