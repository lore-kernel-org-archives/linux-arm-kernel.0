From: marco.franchi@nxp.com (Marco Franchi)
Date: Thu, 13 Jul 2017 12:35:59 -0300
Subject: [PATCH 1/2 v2] ARM: dts: imx6ul-evk: Add DRM panel support
Message-ID: <1499960160-20852-1-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is preferred to use the panel compatible string rather than passing the LCD
timming in the device tree.

So pass the "innolux,at043tn24" compatible string to describe the parallel LCD
on this board.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
-Add missed space
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 36 ++++++++++++----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index d2be8aa..ed11cd1 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -78,6 +78,16 @@
 			clocks = <&clks IMX6UL_CLK_SAI2>;
 		};
 	};
+
+	panel {
+		compatible = "innolux,at043tn24";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -139,31 +149,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat
 		     &pinctrl_lcdif_ctrl>;
-	display = <&display0>;
 	status = "okay";
 
-	display0: display {
-		bits-per-pixel = <16>;
-		bus-width = <24>;
-
-		display-timings {
-			native-mode = <&timing0>;
-
-			timing0: timing0 {
-				clock-frequency = <9200000>;
-				hactive = <480>;
-				vactive = <272>;
-				hfront-porch = <8>;
-				hback-porch = <4>;
-				hsync-len = <41>;
-				vback-porch = <2>;
-				vfront-porch = <4>;
-				vsync-len = <10>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <1>;
-				pixelclk-active = <0>;
-			};
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
 		};
 	};
 };
-- 
2.7.4
