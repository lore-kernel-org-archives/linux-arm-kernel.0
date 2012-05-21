From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 May 2012 17:23:57 +0800
Subject: [PATCH v2 12/12] ARM: dts: imx28-evk: add usb devices
In-Reply-To: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337592237-5090-13-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |   18 ++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi    |   12 ++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ee520a5..ca6fe30 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -73,10 +73,28 @@
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+
+			usbphy1: usbphy at 8007e000 {
+				status = "okay";
+			};
 		};
 	};
 
 	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			fsl,vbus-power = <&gpio3 9 0>;
+			status = "okay";
+		};
+
+		usb1: usb at 80090000 {
+			fsl,vbus-power = <&gpio3 8 0>;
+			status = "okay";
+		};
+
 		mac0: ethernet at 800f0000 {
 			phy-mode = "rmii";
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..502ad05 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -441,11 +441,13 @@
 			};
 
 			usbphy0: usbphy at 8007c000 {
+				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007c000 0x2000>;
 				status = "disabled";
 			};
 
 			usbphy1: usbphy at 8007e000 {
+				compatible = "fsl,imx28-usbphy", "fsl,imx23-usbphy";
 				reg = <0x8007e000 0x2000>;
 				status = "disabled";
 			};
@@ -459,13 +461,19 @@
 		reg = <0x80080000 0x80000>;
 		ranges;
 
-		usbctrl0: usbctrl at 80080000 {
+		usb0: usb at 80080000 {
+			compatible = "fsl,imx28-usb", "fsl,imx31-usb";
 			reg = <0x80080000 0x10000>;
+			interrupts = <93>;
+			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
 		};
 
-		usbctrl1: usbctrl at 80090000 {
+		usb1: usb at 80090000 {
+			compatible = "fsl,imx28-usb", "fsl,imx31-usb";
 			reg = <0x80090000 0x10000>;
+			interrupts = <92>;
+			fsl,usbphy = <&usbphy1>;
 			status = "disabled";
 		};
 
-- 
1.7.5.4
