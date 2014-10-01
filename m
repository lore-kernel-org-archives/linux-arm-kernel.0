From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  1 Oct 2014 16:53:06 +0200
Subject: [PATCH v7 09/11] ARM: at91/dt: define the HLCDC node available on
 sama5d3 SoCs
In-Reply-To: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1412175188-28278-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1412175188-28278-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Define the HLCDC (HLCD Controller) IP available on some sama5d3 SoCs
(i.e. sama5d31, sama5d33, sama5d34 and sama5d36) in sama5d3 dtsi file.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Tested-by: Anthony Harivel <anthony.harivel@emtrion.de>
---
 arch/arm/boot/dts/sama5d3_lcd.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index e7581f6..611ff8a 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -166,6 +166,34 @@
 				};
 			};
 
+			hlcdc: hlcdc at f0030000 {
+				compatible = "atmel,sama5d3-hlcdc";
+				reg = <0xf0030000 0x2000>;
+				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&lcdc_clk>, <&lcdck>, <&clk32k>;
+				clock-names = "periph_clk","sys_clk", "slow_clk";
+				status = "disabled";
+
+				hlcdc-display-controller {
+					compatible = "atmel,hlcdc-display-controller";
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
1.9.1
