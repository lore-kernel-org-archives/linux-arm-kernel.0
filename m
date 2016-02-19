From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 19 Feb 2016 17:35:03 +0800
Subject: [PATCH 1/2] ARM: dts: imx25.dtsi: change the clock information for usb
Message-ID: <1455874504-28993-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@freescale.com>

For imx25, it needs three clocks to let the controller work,
the old code is wrong, and usbmisc has not included clock
handling code any more.

Acked-by: Shawn Guo <shawnguo@kernel.org>
Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
Shawn, the related changes for i.mx27 has already been in mainline.
Unlike the changes for i.mx27, it is not a bug fix for i.mx25 and i.mx35.

 arch/arm/boot/dts/imx25.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index cde329e..d82e8d8 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -497,7 +497,8 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
 				interrupts = <37>;
-				clocks = <&clks 70>;
+				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
+				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
@@ -507,7 +508,8 @@
 				compatible = "fsl,imx25-usb", "fsl,imx27-usb";
 				reg = <0x53ff4400 0x0200>;
 				interrupts = <35>;
-				clocks = <&clks 70>;
+				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
+				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
 				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
@@ -516,8 +518,6 @@
 			usbmisc: usbmisc at 53ff4600 {
 				#index-cells = <1>;
 				compatible = "fsl,imx25-usbmisc";
-				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
-				clock-names = "ipg", "ahb", "per";
 				reg = <0x53ff4600 0x00f>;
 			};
 
-- 
1.9.1
