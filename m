From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 29 Mar 2013 19:46:41 +0100
Subject: [PATCH] ARM: cfa10036: add one wire bitbanging to the cfa10049
Message-ID: <1364582801-15087-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index ded7784..b9dad4e 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -30,7 +30,6 @@
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x0073 /* MX28_PAD_GPMI_D7__GPIO_0_7 */
-						0x1153 /* MX28_PAD_LCD_D22__GPIO_1_21 */
 						0x1163 /* MX28_PAD_LCD_D22__GPIO_1_22 */
 						0x1173 /* MX28_PAD_LCD_D22__GPIO_1_23 */
 						0x2153 /* MX28_PAD_SSP2_D5__GPIO_2_21 */
@@ -120,6 +119,16 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
+
+				w1_gpio_pins: w1-gpio at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x1153 /* MX28_PAD_LCD_D21__GPIO_1_21 */
+					>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>; /* 0 will enable the keeper */
+				};
 			};
 
 			lcdif at 80030000 {
@@ -304,5 +313,14 @@
 		pwms = <&pwm 3 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+
+	};
+
+	onewire at 0 {
+		compatible = "w1-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&w1_gpio_pins>;
+		status = "okay";
+		gpios = <&gpio1 21 0>;
 	};
 };
-- 
1.7.10.4
