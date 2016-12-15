//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Timothy Mak on 12/8/16.
//  Copyright © 2016 Timothy Mak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var roundedTipLabel: UILabel!
    @IBOutlet weak var roundedTotalLabel: UILabel!
    @IBOutlet weak var roundedTipValue: UILabel!
    @IBOutlet weak var roundedTotalValue: UILabel!
    
    
    
    let tipPercentages = [0.1, 0.15, 0.18]
    var tipPercent = 0.0
    let tipKey = "default_tip_percentage"
    
    var showRounded = false
    let roundedKey = "show/hide rounded"
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        defaults.set(tipPercent, forKey: tipKey)
        defaults.set(false, forKey: roundedKey)
        
        defaults.synchronize()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideRoundedLabels(){
        roundedTipLabel.isHidden = true
        roundedTotalLabel.isHidden = true
        roundedTipValue.isHidden = true
        roundedTotalValue.isHidden = true
    }
    
    func showRoundedLabels(){
        roundedTipLabel.isHidden = false
        roundedTotalLabel.isHidden = false
        roundedTipValue.isHidden = false
        roundedTotalValue.isHidden = false
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        
        // ?? checks if text is valid - if not, return 0
        let bill = Double(billField.text!) ?? 0
        let tip = (bill * tipPercent)
        let total = bill + tip
        let roundedTotal = round(total)
        let roundedTip = roundedTotal - bill
        
        //set the labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        roundedTipValue.text = String(format: "$%.2f", roundedTip)
        roundedTotalValue.text = String(format: "$%.2f", roundedTotal)
        
    }

    @IBAction func tipValueChange(_ sender: Any) {
        tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip(self)
        
        //save the key to UserDefaults
        defaults.set(tipPercent, forKey: tipKey)
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Make the keyboard automatically appear
        billField.becomeFirstResponder()
        
        tipPercent = defaults.double(forKey: tipKey)
        
        if(tipPercent == tipPercentages[0]){
            tipControl.selectedSegmentIndex = 0
        }
        else if(tipPercent == tipPercentages[1]){
            tipControl.selectedSegmentIndex = 1
        }
        else{
            tipControl.selectedSegmentIndex = 2
        }
        calculateTip(self)
        
        let rounded = defaults.bool(forKey: roundedKey)
        
        if(rounded){
            showRoundedLabels()
        }
        else{
            hideRoundedLabels()
        }
    }
    
}

