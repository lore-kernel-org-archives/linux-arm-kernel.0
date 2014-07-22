From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 22 Jul 2014 15:11:33 +0200
Subject: [PATCH v4 09/11] ARM: at91/dt: define the HLCDC node available on
 sama5d3 SoCs
In-Reply-To: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1406034695-15534-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1406034695-15534-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the HLCDC (HLCD Controller) IP available on some sama5d3 SoCs
(i.e. sama5d31, sama5d33, sama5d34 and sama5d36) in sama5d3 dtsi file.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3_lcd.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index e7581f6..1874cf7 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -166,6 +166,34 @@
 				};
 			};
 
+			hlcdc: hlcdc at f0030000 {
+				compatible = "atmel,sama5d3-hlcdc";
+				reg = <0xf0030000 0x2000>;
+				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clock-names = "periph_clk","sys_clk", "slow_clk";
+				status = "disabled";
+
+				hlcdc-display-controller {
+					compatible = "atmel,hlcdc-display-controller";
+					interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port at 0 {
+						#address-cells = <1>;
+						#size-cells = <0>;
+						reg = <0>;
+					};
+				};
+
+				hlcdc_pwm: hlcdc-pwm {
+					compatible = "atmel,hlcdc-pwm";
+					pinctrl-names = "default";
+					pinctrl-0 = <&pinctrl_lcd_pwm>;
+					#pwm-cells = <3>;
+				};
+			};
+
 			pmc: pmc at fffffc00 {
 				periphck {
 					lcdc_clk: lcdc_clk {
-- 
1.8.3.2
