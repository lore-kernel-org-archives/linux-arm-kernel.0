From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:37 +0900
Subject: [PATCH 06/30] ARM: shmobile: r8a7794 dtsi: Change to using
 clock-indices
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <1045d0655704a16a736e001d3ae052829d5532b0.1419812185.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

With the addition of clock-indices in commit 8e33f91a0b84ae19 ("clk:
shmobile: clk-mstp: change to using clock-indices"), we can change the
DTSes to use the generic property instead of the deprecated
vendor-specific property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 19c9de3..1801bb4 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -455,7 +455,7 @@
 			reg = <0 0xe6150130 0 4>, <0 0xe6150030 0 4>;
 			clocks = <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7794_CLK_MSIOF0>;
+			clock-indices = <R8A7794_CLK_MSIOF0>;
 			clock-output-names = "msiof0";
 		};
 		mstp1_clks: mstp1_clks at e6150134 {
@@ -465,7 +465,7 @@
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&rclk_clk>, <&cp_clk>,
 				 <&zs_clk>, <&zs_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_VCP0 R8A7794_CLK_VPC0 R8A7794_CLK_TMU1
 				R8A7794_CLK_3DG R8A7794_CLK_2DDMAC R8A7794_CLK_FDP1_0
 				R8A7794_CLK_TMU3 R8A7794_CLK_TMU2 R8A7794_CLK_CMT0
@@ -481,7 +481,7 @@
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
 				 <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_SCIFA2 R8A7794_CLK_SCIFA1 R8A7794_CLK_SCIFA0
 				R8A7794_CLK_MSIOF2 R8A7794_CLK_SCIFB0 R8A7794_CLK_SCIFB1
 				R8A7794_CLK_MSIOF1 R8A7794_CLK_SCIFB2
@@ -495,7 +495,7 @@
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&rclk_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_CMT1
 			>;
 			clock-output-names =
@@ -507,7 +507,7 @@
 			clocks = <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
@@ -522,7 +522,7 @@
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
 			clocks = <&zg_clk>, <&zg_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_VIN1 R8A7794_CLK_VIN0 R8A7794_CLK_ETHER
 			>;
 			clock-output-names =
@@ -533,7 +533,7 @@
 			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7794_CLK_SCIFA3 R8A7794_CLK_SCIFA4 R8A7794_CLK_SCIFA5
 			>;
 			clock-output-names = "scifa3", "scifa4", "scifa5";
-- 
2.1.3
