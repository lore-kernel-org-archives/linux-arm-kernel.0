From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  7 Nov 2013 12:45:04 +0400
Subject: [PATCH 1/5] ARM: dts: i.MX51: Move usbphy0 node from AIPS1
Message-ID: <1383813908-26571-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usbphy0 is not a part of AIPS1, so move this node under usbotg.
Additionally this patch removes useless "status" property.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 463dfe8..1075a7d 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -189,13 +189,6 @@
 				};
 			};
 
-			usbphy0: usbphy at 0 {
-				compatible = "usb-nop-xceiv";
-				clocks = <&clks 75>;
-				clock-names = "main_clk";
-				status = "okay";
-			};
-
 			usbotg: usb at 73f80000 {
 				compatible = "fsl,imx51-usb", "fsl,imx27-usb";
 				reg = <0x73f80000 0x0200>;
@@ -204,6 +197,12 @@
 				fsl,usbmisc = <&usbmisc 0>;
 				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
+
+				usbphy0: usbphy at 0 {
+					compatible = "usb-nop-xceiv";
+					clocks = <&clks 75>;
+					clock-names = "main_clk";
+				};
 			};
 
 			usbh1: usb at 73f80200 {
-- 
1.8.1.5
