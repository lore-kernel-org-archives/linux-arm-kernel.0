From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Sep 2012 23:52:20 -0300
Subject: [PATCH 2/2] ARM: dts: imx23-olinuxino: Use pinctrl for gpio-led
In-Reply-To: <1348541540-15641-1-git-send-email-festevam@gmail.com>
References: <1348541540-15641-1-git-send-email-festevam@gmail.com>
Message-ID: <1348541540-15641-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 8fe4554f (leds: leds-gpio: adopt pinctrl support) gpio-led driver 
has pinctrl support, so setup the gpio led pin via pinctrl and avoid the 
following warning:

leds-gpio leds.5: pins are not configured from the driver

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 35489a1..8bd56fc 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -40,6 +40,15 @@
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				led_pin_gpio0_17: led_gpio0_17 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
 						0x0113 /* MX23_PAD_GPMI_ALE__GPIO_0_17 */
 					>;
 					fsl,drive-strength = <0>;
@@ -91,6 +100,8 @@
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pin_gpio0_17>;
 
 		user {
 			label = "green";
-- 
1.7.9.5
