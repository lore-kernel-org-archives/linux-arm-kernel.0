From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:46:15 +0100
Subject: [PATCH 74/77] ARM: dts: sun8i: a83t: Fix Display Engine DTC warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <4e7aa4d027f022d95da5ddc164409e5ffab1e8b2.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our display engine endpoints trigger some DTC warnings due to the fact that
we're having a single endpoint that doesn't need any reg property, and
since we don't have a reg property, we don't need the address-cells and
size-cells properties anymore.

Fix those

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts |  3 +--
 arch/arm/boot/dts/sun8i-a83t.dtsi         | 12 ++----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 98e8cea26dbe..4bda2f9372cb 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -391,8 +391,7 @@
 };
 
 &tcon0_out {
-	tcon0_out_lcd: endpoint at 0 {
-		reg = <0>;
+	tcon0_out_lcd: endpoint {
 		remote-endpoint = <&panel_input>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index b099d2fbb5cd..c32d74083d10 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -325,12 +325,9 @@
 				#size-cells = <0>;
 
 				mixer0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 
-					mixer0_out_tcon0: endpoint at 0 {
-						reg = <0>;
+					mixer0_out_tcon0: endpoint {
 						remote-endpoint = <&tcon0_in_mixer0>;
 					};
 				};
@@ -428,19 +425,14 @@
 				#size-cells = <0>;
 
 				tcon0_in: port at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <0>;
 
-					tcon0_in_mixer0: endpoint at 0 {
-						reg = <0>;
+					tcon0_in_mixer0: endpoint {
 						remote-endpoint = <&mixer0_out_tcon0>;
 					};
 				};
 
 				tcon0_out: port at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
 					reg = <1>;
 				};
 			};
-- 
git-series 0.9.1
