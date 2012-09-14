From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 14 Sep 2012 14:42:45 +0800
Subject: [PATCH v7] ARM: dts: imx6q-sabrelite: add usbmisc device
Message-ID: <1347604966-11956-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add usbmisc device
- set property fsl,usbmisc for usb controllers
- set disable-over-current for imx6q-sabrelite usb otg

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
Changes form v6:
 - include clk that describe using clk lookup dt binding

 arch/arm/boot/dts/imx6q-sabrelite.dts |    1 +
 arch/arm/boot/dts/imx6q.dtsi          |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index cfdbe53..66fc765 100644
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
index 925da33..6b832d5 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -665,6 +665,7 @@
 				interrupts = <0 43 0x04>;
 				clocks = <&clks 162>;
 				fsl,usbphy = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
 
@@ -674,6 +675,7 @@
 				interrupts = <0 40 0x04>;
 				clocks = <&clks 162>;
 				fsl,usbphy = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
 
@@ -682,6 +684,7 @@
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 0x04>;
 				clocks = <&clks 162>;
+				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
 
@@ -690,9 +693,17 @@
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 0x04>;
 				clocks = <&clks 162>;
+				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
 
+			usbmisc: usbmisc at 02184800 {
+				#index-cells = <1>;
+				compatible = "fsl,imx6q-usbmisc";
+				reg = <0x02184800 0x200>;
+				clocks = <&clks 162>;
+			};
+
 			ethernet at 02188000 {
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
-- 
1.7.9.5
