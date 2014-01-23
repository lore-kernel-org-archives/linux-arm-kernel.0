From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:13 +0100
Subject: [PATCH v3 09/15] at91: dt: sam9261: Added support for the LCD display
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-10-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 97e6b62..79d7554 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -57,6 +57,17 @@
 			status = "disabled";
 		};
 
+		fb0: fb at 0x00600000 {
+			compatible = "atmel,at91sam9261-lcdc";
+			reg = <0x00600000 0x1000>;
+			interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fb>;
+			clocks = <&lcd_clk>, <&hclk1>;
+			clock-names = "lcdc_clk", "hclk";
+			status = "disabled";
+		};
+
 		nand0: nand at 40000000 {
 			compatible = "atmel,at91rm9200-nand";
 			#address-cells = <1>;
@@ -432,6 +443,34 @@
 					};
 				};
 
+				fb {
+					pinctrl_fb: fb-0 {
+						atmel,pins =
+							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 3 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 15 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 16 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 23 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 24 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 25 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 26 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 27 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOB 28 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 >;
+					};
+				};
+
 				pioA: gpio at fffff400 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff400 0x200>;
-- 
1.8.5.2
