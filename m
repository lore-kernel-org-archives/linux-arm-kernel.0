From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Thu, 11 Apr 2013 12:13:16 +0200
Subject: [PATCH 3/4] ARM: dts: imx: use usb-nop-xceiv usbphy entries for imx5x
In-Reply-To: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1365675197-9687-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1365675197-9687-4-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/boot/dts/imx51.dtsi |  8 ++++++++
 arch/arm/boot/dts/imx53.dtsi | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 01fe241..53fe73c 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -153,12 +153,20 @@
 				};
 			};
 
+			usbphy0: usbphy at 0 {
+				compatible = "usb-nop-xceiv";
+				clocks = <&clks 124>;
+				clock-names = "main_clk";
+				status = "okay";
+			};
+
 			usbotg: usb at 73f80000 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80000 0x0200>;
 				interrupts = <18>;
 				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
 			};
 
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 9a1595f..f8e0adb 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -159,12 +159,27 @@
 				};
 			};
 
+			usbphy0: usbphy at 0 {
+				compatible = "usb-nop-xceiv";
+				clocks = <&clks 124>;
+				clock-names = "main_clk";
+				status = "okay";
+			};
+
+			usbphy1: usbphy at 1 {
+				compatible = "usb-nop-xceiv";
+				clocks = <&clks 125>;
+				clock-names = "main_clk";
+				status = "okay";
+			};
+
 			usbotg: usb at 53f80000 {
 				compatible = "fsl,imx53-usb", "fsl,imx27-usb";
 				reg = <0x53f80000 0x0200>;
 				interrupts = <18>;
 				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
 			};
 
@@ -174,6 +189,7 @@
 				interrupts = <14>;
 				clocks = <&clks 108>;
 				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
 
-- 
1.8.2.rc2
