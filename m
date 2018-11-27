From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:54 +0100
Subject: [PATCH 53/77] ARM: dts: sun8i: a23/a33: Fix Display Engine DTC
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <3aa2981b56cd9f875b9a576d6a3b6c982a832780.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our display engine endpoints trigger some DTC warnings due to the fact that
we're having a single endpoint that doesn't need any reg property, and
since we don't have a reg property, we don't need the address-cells and
size-cells properties anymore.

Fix those

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 11 +-----
 arch/arm/boot/dts/sun8i-a33.dtsi               | 45 +++----------------
 2 files changed, 11 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 541acb4d2b91..b343153948f4 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -63,16 +63,9 @@
 
 	panel {
 		compatible = "netron-dy,e231732";
-		#address-cells = <1>;
-		#size-cells = <0>;
 
-		port at 0 {
-			reg = <0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			panel_input: endpoint at 0 {
-				reg = <0>;
+		port {
+			panel_input: endpoint {
 				remote-endpoint = <&tcon0_out_panel>;
 			};
 		};
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 17d725bd6654..d74cd95afe6d 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -242,12 +242,9 @@
 				#size-cells = <0>;
 
 				tcon0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					tcon0_in_drc0: endpoint at 0 {
-						reg = <0>;
+					tcon0_in_drc0: endpoint {
 						remote-endpoint = <&drc0_out_tcon0>;
 					};
 				};
@@ -328,18 +325,9 @@
 			phy-names = "dphy";
 			status = "disabled";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					dsi_in_tcon0: endpoint {
-						remote-endpoint = <&tcon0_out_dsi>;
-					};
+			port {
+				dsi_in_tcon0: endpoint {
+					remote-endpoint = <&tcon0_out_dsi>;
 				};
 			};
 		};
@@ -370,12 +358,9 @@
 				#size-cells = <0>;
 
 				fe0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					fe0_out_be0: endpoint at 0 {
-						reg = <0>;
+					fe0_out_be0: endpoint {
 						remote-endpoint = <&be0_in_fe0>;
 					};
 				};
@@ -401,23 +386,17 @@
 				#size-cells = <0>;
 
 				be0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					be0_in_fe0: endpoint at 0 {
-						reg = <0>;
+					be0_in_fe0: endpoint {
 						remote-endpoint = <&fe0_out_be0>;
 					};
 				};
 
 				be0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					be0_out_drc0: endpoint at 0 {
-						reg = <0>;
+					be0_out_drc0: endpoint {
 						remote-endpoint = <&drc0_in_be0>;
 					};
 				};
@@ -441,23 +420,17 @@
 				#size-cells = <0>;
 
 				drc0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					drc0_in_be0: endpoint at 0 {
-						reg = <0>;
+					drc0_in_be0: endpoint {
 						remote-endpoint = <&be0_out_drc0>;
 					};
 				};
 
 				drc0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					drc0_out_tcon0: endpoint at 0 {
-						reg = <0>;
+					drc0_out_tcon0: endpoint {
 						remote-endpoint = <&tcon0_in_drc0>;
 					};
 				};
-- 
git-series 0.9.1
