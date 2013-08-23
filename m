From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 23 Aug 2013 13:56:30 +0800
Subject: [PATCH 1/1]  ARM: dts: imx28-evk: Add pinctrl for USB OTG ID pin
Message-ID: <1377237390-15983-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After that, the dual-role switch can be used at imx28-evk.

Due to hardware limitations, it needs to switch VDD 5V
SOURCE SELECT to "USB 5V" if the user wants to use OTG
dual-role switch function. it needs to switch VDD 5V
SOURCE SELECT to "WALL 5V" if the user wants to Host 1.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    2 ++
 arch/arm/boot/dts/imx28.dtsi    |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 15715d9..fa48bd5 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -243,6 +243,8 @@
 	ahb at 80080000 {
 		usb0: usb at 80080000 {
 			vbus-supply = <&reg_usb0_vbus>;
+			pinctrl-names = "default";
+  			pinctrl-0 = <&usb0_pins_a>;
 			status = "okay";
 		};
 
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 7363fde..54bd17c 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -731,6 +731,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				usb0_pins_a: usb0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3071 /* MX28_PAD_AUART1_RTS__USB0_ID */
+					>;
+					fsl,drive-strength = <2>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+
 				usbphy1_pins_a: usbphy1 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.1
