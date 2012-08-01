From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 1 Aug 2012 10:51:09 +0800
Subject: [PATCH v4 3/3] ARM: dts: imx6q-sabrelite: add usbmisc device
In-Reply-To: <1343789469-26821-1-git-send-email-richard.zhao@freescale.com>
References: <1343789469-26821-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1343789469-26821-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usbmisc device
- set property fsl,usbmisc for usb controllers

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts |    1 +
 arch/arm/boot/dts/imx6q.dtsi          |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index d42e851..b32ebfc 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -62,6 +62,7 @@
 		aips-bus at 02100000 { /* AIPS2 */
 			usb at 02184000 { /* USB OTG */
 				vbus-supply = <&reg_usb_otg_vbus>;
+				disable-over-current;
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 3d3c64b..a6e1816 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -629,6 +629,7 @@
 				reg = <0x02184000 0x200>;
 				interrupts = <0 43 0x04>;
 				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
 
@@ -637,6 +638,7 @@
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 0x04>;
 				fsl,usbphy = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
 
@@ -644,6 +646,7 @@
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 0x04>;
+				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
 
@@ -651,9 +654,16 @@
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
