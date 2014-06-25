From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 25 Jun 2014 13:01:30 +0200
Subject: [PATCH v2 1/2] ARM: dts: i.MX53: add aipstz nodes
Message-ID: <1403694091-27247-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AHB to IP bridges (AIPSTZ) allow fine grained access rights management.
Add both bridges to the DT.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6456a00..aaea979 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -260,6 +260,11 @@
 				};
 			};
 
+			aipstz1: bridge at 53f00000 {
+				compatible = "fsl,imx53-aipstz";
+				reg = <0x53f00000 0x60>;
+			};
+
 			usbphy0: usbphy at 0 {
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX5_CLK_USB_PHY1_GATE>;
@@ -572,6 +577,11 @@
 			reg = <0x60000000 0x10000000>;
 			ranges;
 
+			aipstz2: bridge at 63f00000 {
+				compatible = "fsl,imx53-aipstz";
+				reg = <0x63f00000 0x60>;
+			};
+
 			iim: iim at 63f98000 {
 				compatible = "fsl,imx53-iim", "fsl,imx27-iim";
 				reg = <0x63f98000 0x4000>;
-- 
2.0.0
