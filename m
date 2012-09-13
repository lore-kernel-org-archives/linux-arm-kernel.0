From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 13 Sep 2012 14:33:38 -0300
Subject: [PATCH 1/2] ARM: dts: mx23: Add USB resources
Message-ID: <1347557619-17793-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB resources for mx23.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23.dtsi |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 9d0e803..17904db 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -436,9 +436,11 @@
 				status = "disabled";
 			};
 
-			usbphy at 8007c000 {
+			usbphy0: usbphy at 8007c000 {
+				compatible = "fsl,imx23-usbphy";
 				reg = <0x8007c000 0x2000>;
-				status = "disabled";
+				clocks = <&clks 41>;
+				status = "disabled";
 			};
 		};
 	};
@@ -450,8 +452,12 @@
 		reg = <0x80080000 0x80000>;
 		ranges;
 
-		usbctrl at 80080000 {
+		usb0: usb at 80080000 {
+			compatible = "fsl,imx23-usb", "fsl,imx27-usb";
 			reg = <0x80080000 0x40000>;
+			interrupts = <11>;
+			fsl,usbphy = <&usbphy0>;
+			clocks = <&clks 40>;
 			status = "disabled";
 		};
 	};
-- 
1.7.9.5
