From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Feb 2014 11:12:23 -0800
Subject: [PATCH] devicetree: bindings: Make msm8974-pinctrl documentation
 match code
Message-ID: <1393441943-1689-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The compatible string doesn't have an x in it. Fix it. Also
remove the "qcom" prefix from pins and functions as this binding
uses the generic pinctrl bindings for the pins and functions.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt   | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
index 4c352be5dd61..9fb89e3f61ea 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
@@ -1,7 +1,7 @@
 Qualcomm MSM8974 TLMM block
 
 Required properties:
-- compatible: "qcom,msm8x74-pinctrl"
+- compatible: "qcom,msm8974-pinctrl"
 - reg: Should be the base address and length of the TLMM block.
 - interrupts: Should be the parent IRQ of the TLMM block.
 - interrupt-controller: Marks the device node as an interrupt controller.
@@ -42,14 +42,14 @@ Non-empty subnodes must specify the 'pins' property.
 Note that not all properties are valid for all pins.
 
 
-Valid values for qcom,pins are:
+Valid values for pins are:
   gpio0-gpio145
     Supports mux, bias and drive-strength
 
   sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data
     Supports bias and drive-strength
 
-Valid values for qcom,function are:
+Valid values for function are:
   blsp_i2c2, blsp_i2c6, blsp_i2c11, blsp_spi1, blsp_uart2, blsp_uart8, slimbus
 
   (Note that this is not yet the complete list of functions)
@@ -73,18 +73,18 @@ Example:
 
 		uart2_default: uart2_default {
 			mux {
-				qcom,pins = "gpio4", "gpio5";
-				qcom,function = "blsp_uart2";
+				pins = "gpio4", "gpio5";
+				function = "blsp_uart2";
 			};
 
 			tx {
-				qcom,pins = "gpio4";
+				pins = "gpio4";
 				drive-strength = <4>;
 				bias-disable;
 			};
 
 			rx {
-				qcom,pins = "gpio5";
+				pins = "gpio5";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
