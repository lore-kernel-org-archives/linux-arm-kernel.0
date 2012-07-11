From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 11 Jul 2012 19:33:45 +0800
Subject: [PATCH v6 7/7] ARM: dts: imx6q-sabrelite: add usbotg pinctrl support
In-Reply-To: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342006425-21008-8-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
 arch/arm/boot/dts/imx6q.dtsi          |    6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 5bba0d1..de3cd2e 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -57,6 +57,8 @@
 		aips-bus at 02100000 { /* AIPS2 */
 			usb at 02184000 { /* USB OTG */
 				vbus-supply = <&reg_usb_otg_vbus>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_usbotg_1>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 5e4f100..64a24a0 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -552,6 +552,12 @@
 					};
 				};
 
+				usbotg {
+					pinctrl_usbotg_1: usbotggrp-1 {
+						fsl,pins = <1591 0x17059>;	/* MX6Q_PAD_GPIO_1__USBOTG_ID */
+					};
+				};
+
 				usdhc3 {
 					pinctrl_usdhc3_1: usdhc3grp-1 {
 						fsl,pins = <1273 0x17059	/* MX6Q_PAD_SD3_CMD__USDHC3_CMD */
-- 
1.7.9.5
