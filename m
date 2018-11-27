From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:27 +0100
Subject: [PATCH 26/77] ARM: dts: sun6i: Fix Display Engine DTC warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <5787dbe557d085e65ea01bfb0360143d0df7c8b7.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our display engine endpoints trigger some DTC warnings due to the fact that
we're having a single endpoint that doesn't need any reg property, and
since we don't have a reg property, we don't need the address-cells and
size-cells properties anymore.

Fix those

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 12 ++----------
 arch/arm/boot/dts/sun6i-a31.dtsi            | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index ce4f9e9834bf..4eab94737203 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -86,31 +86,23 @@
 	vga-dac {
 		compatible = "dumb-vga-dac";
 		vdd-supply = <&reg_vga_3v3>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
 			port at 0 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 
-				vga_dac_in: endpoint at 0 {
-					reg = <0>;
+				vga_dac_in: endpoint {
 					remote-endpoint = <&tcon0_out_vga>;
 				};
 			};
 
 			port at 1 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <1>;
 
-				vga_dac_out: endpoint at 0 {
-					reg = <0>;
+				vga_dac_out: endpoint {
 					remote-endpoint = <&vga_con_in>;
 				};
 			};
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 5355213f73b9..c5fd97b88b90 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -486,8 +486,6 @@
 				};
 
 				hdmi_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
@@ -1218,12 +1216,9 @@
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
@@ -1248,12 +1243,9 @@
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
-- 
git-series 0.9.1
