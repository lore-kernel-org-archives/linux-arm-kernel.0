From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:17 +0100
Subject: [PATCH 76/77] ARM: dts: sun9i: Fix Display Engine DTC warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <ea20262c67e8248f2eaf6eb6b8ec645271cf97a7.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our display engine endpoints trigger some DTC warnings due to the fact that
we're having a single endpoint that doesn't need any reg property, and
since we don't have a reg property, we don't need the address-cells and
size-cells properties anymore.

Fix those

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 15 +----
 arch/arm/boot/dts/sun9i-a80.dtsi            | 64 ++++------------------
 2 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 85da85faf869..2701d3446b6c 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -89,31 +89,23 @@
 	vga-dac {
 		compatible = "corpro,gm7123", "adi,adv7123", "dumb-vga-dac";
 		vdd-supply = <&reg_dcdc1>;
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
@@ -464,8 +456,7 @@
 };
 
 &tcon0_out {
-	tcon0_out_vga: endpoint at 0 {
-		reg = <0>;
+	tcon0_out_vga: endpoint {
 		remote-endpoint = <&vga_dac_in>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d9532fb1ef65..27c2ad6bf002 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -544,12 +544,9 @@
 				#size-cells = <0>;
 
 				fe0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					fe0_out_deu0: endpoint at 0 {
-						reg = <0>;
+					fe0_out_deu0: endpoint {
 						remote-endpoint = <&deu0_in_fe0>;
 					};
 				};
@@ -571,12 +568,9 @@
 				#size-cells = <0>;
 
 				fe1_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					fe1_out_deu1: endpoint at 0 {
-						reg = <0>;
+					fe1_out_deu1: endpoint {
 						remote-endpoint = <&deu1_in_fe1>;
 					};
 				};
@@ -614,12 +608,9 @@
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
@@ -657,12 +648,9 @@
 				};
 
 				be1_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					be1_out_drc1: endpoint at 0 {
-						reg = <0>;
+					be1_out_drc1: endpoint {
 						remote-endpoint = <&drc1_in_be1>;
 					};
 				};
@@ -686,12 +674,9 @@
 				#size-cells = <0>;
 
 				deu0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					deu0_in_fe0: endpoint at 0 {
-						reg = <0>;
+					deu0_in_fe0: endpoint {
 						remote-endpoint = <&fe0_out_deu0>;
 					};
 				};
@@ -731,12 +716,9 @@
 				#size-cells = <0>;
 
 				deu1_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					deu1_in_fe1: endpoint at 0 {
-						reg = <0>;
+					deu1_in_fe1: endpoint {
 						remote-endpoint = <&fe1_out_deu1>;
 					};
 				};
@@ -776,23 +758,17 @@
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
@@ -816,23 +792,17 @@
 				#size-cells = <0>;
 
 				drc1_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					drc1_in_be1: endpoint at 0 {
-						reg = <0>;
+					drc1_in_be1: endpoint {
 						remote-endpoint = <&be1_out_drc1>;
 					};
 				};
 
 				drc1_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					drc1_out_tcon1: endpoint at 0 {
-						reg = <0>;
+					drc1_out_tcon1: endpoint {
 						remote-endpoint = <&tcon1_in_drc1>;
 					};
 				};
@@ -854,19 +824,14 @@
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
 
 				tcon0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
@@ -886,19 +851,14 @@
 				#size-cells = <0>;
 
 				tcon1_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					tcon1_in_drc1: endpoint at 0 {
-						reg = <0>;
+					tcon1_in_drc1: endpoint {
 						remote-endpoint = <&drc1_out_tcon1>;
 					};
 				};
 
 				tcon1_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
-- 
git-series 0.9.1
