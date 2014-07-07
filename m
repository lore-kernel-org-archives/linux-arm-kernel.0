From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon,  7 Jul 2014 18:43:02 +0200
Subject: [RESEND PATCH v3 09/11] ARM: at91/dt: define the HLCDC node available
 on sama5d3 SoCs
In-Reply-To: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1404751384-5077-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1404751384-5077-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the HLCDC (HLCD Controller) IP available on some sama5d3 SoCs
(i.e. sama5d31, sama5d33, sama5d34 and sama5d36) in sama5d3 dtsi file.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3_lcd.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3_lcd.dtsi b/arch/arm/boot/dts/sama5d3_lcd.dtsi
index 9642eef..f6aa637 100644
--- a/arch/arm/boot/dts/sama5d3_lcd.dtsi
+++ b/arch/arm/boot/dts/sama5d3_lcd.dtsi
@@ -166,6 +166,26 @@
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
+					compatible = "atmel,hlcdc-dc";
+					interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
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
