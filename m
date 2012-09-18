From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 18 Sep 2012 13:39:00 +0800
Subject: [PATCH] ARM: dts: imx6q-sabrelite: add usbotg pinctrl support
Message-ID: <1347946741-32506-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 arch/arm/boot/dts/imx6q.dtsi          |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 66fc765..52b7fde 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -63,6 +63,8 @@
 		aips-bus at 02100000 { /* AIPS2 */
 			usb at 02184000 { /* USB OTG */
 				vbus-supply = <&reg_usb_otg_vbus>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usbotg_1>;
 				disable-over-current;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 6b832d5..b0c80ee 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -584,6 +584,12 @@
 					};
 				};
 
+				usbotg {
+					pinctrl_usbotg_1: usbotggrp-1 {
+						fsl,pins = <1592 0x17059>;	/* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-- 
1.7.9.5
