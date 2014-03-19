From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 19 Mar 2014 14:28:41 +0100
Subject: [PATCH 5/5] ARM: dts: tx53: Add IPU DI ports and endpoints
In-Reply-To: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1395235721-13847-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x03x.dts |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 0217dde3..43b4b7b 100644
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
-- 
1.7.10.4
