From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Apr 2014 15:19:55 +0800
Subject: [PATCH] ARM: dts: imx53-tx53: add IPU DI ports and endpoints
Message-ID: <1397114395-19587-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent imx-drm device tree binding changes, we need to add IPU
DI ports and endpoints for adapting.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0217dde3..3b73e81 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -25,12 +25,17 @@
 	soc {
 		display: display at di0 {
 			compatible = "fsl,imx-parallel-display";
-			crtcs = <&ipu 0>;
 			interface-pix-fmt = "rgb24";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_rgb24_vga1>;
 			status = "okay";
 
+			port {
+				display0_in: endpoint {
+					remote-endpoint = <&ipu_di0_disp0>;
+				};
+			};
+
 			display-timings {
 				VGA {
 					clock-frequency = <25200000>;
@@ -293,6 +298,10 @@
 	};
 };
 
+&ipu_di0_disp0 {
+	remote-endpoint = <&display0_in>;
+};
+
 &kpp {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_kpp>;
-- 
1.8.3.2
