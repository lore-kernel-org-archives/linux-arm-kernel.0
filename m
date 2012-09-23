From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 23 Sep 2012 15:01:17 -0300
Subject: [PATCH] ARM: dts: imx28-evk: Use pinctrl for gpio-led
Message-ID: <1348423277-10740-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 8fe4554f (leds: leds-gpio: adopt pinctrl support) gpio-led driver 
has pinctrl support, so setup the gpio led pin via pinctrl and avoid the 
following warning:

leds-gpio leds.12: pins are not configured from the driver

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index a0ad71c..8dc5b2b 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -76,7 +76,6 @@
 						0x20c3 /* MX28_PAD_SSP1_SCK__GPIO_2_12 */
 						0x31c3 /* MX28_PAD_PWM3__GPIO_3_28 */
 						0x31e3 /* MX28_PAD_LCD_RESET__GPIO_3_30 */
-						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
 						0x3083 /* MX28_PAD_AUART2_RX__GPIO_3_8 */
 						0x3093 /* MX28_PAD_AUART2_TX__GPIO_3_9 */
 					>;
@@ -85,6 +84,16 @@
 					fsl,pull-up = <0>;
 				};
 
+				led_pin_gpio3_5: led at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3053 /* MX28_PAD_AUART1_TX__GPIO_3_5 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				gpmi_pins_evk: gpmi-nand-evk at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -291,6 +300,7 @@
 
 		user {
 			label = "Heartbeat";
+			pinctrl-0 = <&led_pin_gpio3_5>;
 			gpios = <&gpio3 5 0>;
 			linux,default-trigger = "heartbeat";
 		};
-- 
1.7.9.5
