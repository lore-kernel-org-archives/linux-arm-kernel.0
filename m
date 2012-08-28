From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 28 Aug 2012 14:58:29 +0800
Subject: [PATCH v6 3/3] ARM: dts: imx6q-sabrelite: add usbmisc device
In-Reply-To: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
References: <1346137109-32247-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1346137109-32247-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usbmisc device
- set property fsl,usbmisc for usb controllers
- set disable-over-current for imx6q-sabrelite usb otg

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    1 +
 arch/arm/boot/dts/imx6q.dtsi          |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 72f30f3..aee0568 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -63,6 +63,7 @@
 		aips-bus at 02100000 { /* AIPS2 */
 			usb at 02184000 { /* USB OTG */
 				vbus-supply = <&reg_usb_otg_vbus>;
+				disable-over-current;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index fd57079..7c27267 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -636,6 +636,7 @@
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 0x04>;
 				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
 
@@ -644,6 +645,7 @@
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 0x04>;
 				fsl,usbphy = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
 
@@ -651,6 +653,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 0x04>;
+				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
 
@@ -658,9 +661,16 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 0x04>;
+				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
 
+			usbmisc: usbmisc at 02184800 {
+				#index-cells = <1>;
+				compatible = "fsl,imx6q-usbmisc";
+				reg = <0x02184800 0x200>;
+			};
+
 			ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
-- 
1.7.9.5
