From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 22 Feb 2014 13:32:33 +0400
Subject: [PATCH 1/3] ARM: dts: i.MX27: Add USB nodes
Message-ID: <1393061555-26707-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing (Universal serial bus) USB devicetree
nodes for i.MX27 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27.dtsi | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 2763cae..6279e0b 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -70,6 +70,26 @@
 		};
 	};
 
+	usbphy {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usbphy at 0 {
+			compatible = "usb-nop-xceiv";
+			reg = <0>;
+			clocks = <&clks 75>;
+			clock-names = "main_clk";
+		};
+
+		usbphy2: usbphy at 2 {
+			compatible = "usb-nop-xceiv";
+			reg = <2>;
+			clocks = <&clks 75>;
+			clock-names = "main_clk";
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -439,6 +459,42 @@
 				iram = <&iram>;
 			};
 
+			usbotg: usb at 10024000 {
+				compatible = "fsl,imx27-usb";
+				reg = <0x10024000 0x200>;
+				interrupts = <56>;
+				clocks = <&clks 15>;
+				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy0>;
+				status = "disabled";
+			};
+
+			usbh1: usb at 10024200 {
+				compatible = "fsl,imx27-usb";
+				reg = <0x10024200 0x200>;
+				interrupts = <54>;
+				clocks = <&clks 15>;
+				fsl,usbmisc = <&usbmisc 1>;
+				status = "disabled";
+			};
+
+			usbh2: usb at 10024400 {
+				compatible = "fsl,imx27-usb";
+				reg = <0x10024400 0x200>;
+				interrupts = <55>;
+				clocks = <&clks 15>;
+				fsl,usbmisc = <&usbmisc 2>;
+				fsl,usbphy = <&usbphy2>;
+				status = "disabled";
+			};
+
+			usbmisc: usbmisc at 10024600 {
+				#index-cells = <1>;
+				compatible = "fsl,imx27-usbmisc";
+				reg = <0x10024600 0x200>;
+				clocks = <&clks 62>;
+			};
+
 			sahara2: sahara at 10025000 {
 				compatible = "fsl,imx27-sahara";
 				reg = <0x10025000 0x1000>;
-- 
1.8.3.2
