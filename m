From: tharvey@gateworks.com (Tim Harvey)
Date: Thu,  7 Jan 2016 09:58:09 -0800
Subject: [PATCH] ARM: dts: imx: ventana: add alternate PWM4 pinmux for GW54xx
Message-ID: <1452189489-22515-1-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GW54xx can provide PWM4 out either the off-board backlight connector
or the off-board digital I/O connector. By default the pinmux routes it
to the backlight connector but this pinctl alternate provides documentation
for those who may want to change it.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 2b3c877..cbfa718 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -397,8 +397,9 @@
 };
 
 &pwm4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm4>;
+	pinctrl-names = "default", "state_dio";
+	pinctrl-0 = <&pinctrl_pwm4_backlight>;
+	pinctrl-1 = <&pinctrl_pwm4_dio>;
 	status = "okay";
 };
 
@@ -573,12 +574,20 @@
 			>;
 		};
 
-		pinctrl_pwm4: pwm4grp {
+		pinctrl_pwm4_backlight: pwm4grpbacklight {
 			fsl,pins = <
+				/* LVDS_PWM J6.5 */
 				MX6QDL_PAD_SD1_CMD__PWM4_OUT		0x1b0b1
 			>;
 		};
 
+		pinctrl_pwm4_dio: pwm4grpdio {
+			fsl,pins = <
+				/* DIO3 J16.4 */
+				MX6QDL_PAD_SD4_DAT2__PWM4_OUT		0x1b0b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-- 
1.9.1
