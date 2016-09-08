From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  8 Sep 2016 11:28:15 +0200
Subject: [PATCH] ARM: imx35: add iim module to imx35.dtsi
Message-ID: <1473326895-19189-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a prerequisite to remove the static mappings for imx35 devicetree
based machines.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx35.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 490b7b44f1e7..f812d586c5ce 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -309,6 +309,13 @@
 				status = "disabled";
 			};
 
+			iim at 53ff0000 {
+				compatible = "fsl,imx35-iim";
+				reg = <0x53ff0000 0x4000>;
+				interrupts = <19>;
+				clocks = <&clks 80>;
+			};
+
 			usbotg: usb at 53ff4000 {
 				compatible = "fsl,imx35-usb", "fsl,imx27-usb";
 				reg = <0x53ff4000 0x0200>;
-- 
2.8.1
