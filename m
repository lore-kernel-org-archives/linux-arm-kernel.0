From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:17 +0100
Subject: [PATCH v3 13/15] at91: dt: sam9261: CCF: Added USB clocks
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-14-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 112e587..2a87c19 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -54,6 +54,8 @@
 			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
 			reg = <0x00500000 0x100000>;
 			interrupts = <20 IRQ_TYPE_LEVEL_HIGH 2>;
+			clocks = <&usb>, <&ohci_clk>, <&hclk0>, <&uhpck>;
+			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
 			status = "disabled";
 		};
 
@@ -107,6 +109,8 @@
 				compatible = "atmel,at91rm9200-udc";
 				reg = <0xfffa4000 0x4000>;
 				interrupts = <10 IRQ_TYPE_LEVEL_HIGH 2>;
+				clocks = <&usb>, <&udc_clk>, <&udpck>;
+				clock-names = "usb_clk", "udc_clk", "udpck";
 				status = "disabled";
 			};
 
@@ -563,11 +567,30 @@
 					atmel,clk-divisors = <1 2 4 3>;
 				};
 
+				usb: usbck {
+					compatible = "atmel,at91rm9200-clk-usb";
+					#clock-cells = <0>;
+					atmel,clk-divisors = <1 2 4 3>;
+					clocks = <&pllb>;
+				};
+
 				systemck {
 					compatible = "atmel,at91rm9200-clk-system";
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					uhpck: uhpck {
+						#clock-cells = <0>;
+						reg = <6>;
+						clocks = <&usb>;
+					};
+
+					udpck: udpck {
+						#clock-cells = <0>;
+						reg = <7>;
+						clocks = <&usb>;
+					};
+
 					hclk0: hclk0 {
 						#clock-cells = <0>;
 						reg = <16>;
@@ -623,6 +646,11 @@
 						reg = <9>;
 					};
 
+					udc_clk: udc_clk {
+						#clock-cells = <0>;
+						reg = <10>;
+					};
+
 					twi0_clk: twi0_clk {
 						reg = <11>;
 						#clock-cells = <0>;
@@ -643,6 +671,11 @@
 						reg = <17>;
 					};
 
+					ohci_clk: ohci_clk {
+						#clock-cells = <0>;
+						reg = <20>;
+					};
+
 					lcd_clk: lcd_clk {
 						#clock-cells = <0>;
 						reg = <21>;
-- 
1.8.5.2
