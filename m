From: denis@eukrea.com (Denis Carikli)
Date: Fri,  7 Mar 2014 18:04:18 +0100
Subject: [PATCH 4/9] ARM: dts: imx25.dtsi: Fix USB support.
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <1394211863-7569-4-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

This patch was adapted from the thread named
"USB Host support for mx25" on linux-usb at vger.kernel.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 77bb743..ab5c282 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -483,13 +483,11 @@
 			};
 
 			usbphy1: usbphy at 1 {
-				compatible = "nop-usbphy";
-				status = "disabled";
+				compatible = "usb-nop-xceiv";
 			};
 
 			usbphy2: usbphy at 2 {
-				compatible = "nop-usbphy";
-				status = "disabled";
+				compatible = "usb-nop-xceiv";
 			};
 
 			usbotg: usb at 53ff4000 {
@@ -499,6 +497,7 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
 
@@ -509,6 +508,7 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy2>;
 				status = "disabled";
 			};
 
@@ -518,7 +518,6 @@
 				clocks = <&clks 9>, <&clks 70>, <&clks 8>;
 				clock-names = "ipg", "ahb", "per";
 				reg = <0x53ff4600 0x00f>;
-				status = "disabled";
 			};
 
 			dryice at 53ffc000 {
-- 
1.7.9.5
