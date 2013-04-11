From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 11 Apr 2013 12:13:14 +0200
Subject: [PATCH 1/4] ARM: dts: imx: add imx5x usbmisc entries
In-Reply-To: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1365675197-9687-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi | 10 ++++++++++
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fcf035b..2316472 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -157,6 +157,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80000 0x0200>;
 				interrupts = <18>;
+				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
 
@@ -164,6 +165,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80200 0x0200>;
 				interrupts = <14>;
+				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
 
@@ -171,6 +173,7 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80400 0x0200>;
 				interrupts = <16>;
+				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
 
@@ -178,9 +181,16 @@
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80600 0x0200>;
 				interrupts = <17>;
+				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
 
+			usbmisc: usbmisc at 73f80800 {
+				#index-cells = <1>;
+				compatible = "fsl,imx51-usbmisc";
+				reg = <0x73f80800 0x200>;
+			};
+
 			gpio1: gpio at 73f84000 {
 				compatible = "fsl,imx51-gpio", "fsl,imx35-gpio";
 				reg = <0x73f84000 0x4000>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index d05aa21..c00a100 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -163,6 +163,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80000 0x0200>;
 				interrupts = <18>;
+				fsl,usbmisc = <&usbmisc 0>;
 				status = "disabled";
 			};
 
@@ -170,6 +171,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80200 0x0200>;
 				interrupts = <14>;
+				fsl,usbmisc = <&usbmisc 1>;
 				status = "disabled";
 			};
 
@@ -177,6 +179,7 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80400 0x0200>;
 				interrupts = <16>;
+				fsl,usbmisc = <&usbmisc 2>;
 				status = "disabled";
 			};
 
@@ -184,9 +187,16 @@
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80600 0x0200>;
 				interrupts = <17>;
+				fsl,usbmisc = <&usbmisc 3>;
 				status = "disabled";
 			};
 
+			usbmisc: usbmisc at 53f80800 {
+				#index-cells = <1>;
+				compatible = "fsl,imx53-usbmisc";
+				reg = <0x53f80800 0x200>;
+			};
+
 			gpio1: gpio at 53f84000 {
 				compatible = "fsl,imx53-gpio", "fsl,imx35-gpio";
 				reg = <0x53f84000 0x4000>;
-- 
1.8.2.rc2
