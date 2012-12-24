From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Dec 2012 16:01:39 -0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix IOMUX settings
Message-ID: <1356372099-16134-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On the imx23-olinuxino board GPIO2_1 is connected to the LED and GPIO0_17
is the USB PHY reset.

So make the IOMUX assignment properly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 7c43b8e..e7484e4 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -39,17 +39,17 @@
 				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
+						0x0113 /* MX23_PAD_GPMI_ALE__GPIO_0_17 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
 					fsl,pull-up = <0>;
 				};
 
-				led_pin_gpio0_17: led_gpio0_17 at 0 {
+				led_pin_gpio2_1: led_gpio2_1 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-						0x0113 /* MX23_PAD_GPMI_ALE__GPIO_0_17 */
+						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
 					>;
 					fsl,drive-strength = <0>;
 					fsl,voltage = <1>;
@@ -110,7 +110,7 @@
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
-		pinctrl-0 = <&led_pin_gpio0_17>;
+		pinctrl-0 = <&led_pin_gpio2_1>;
 
 		user {
 			label = "green";
-- 
1.7.9.5
