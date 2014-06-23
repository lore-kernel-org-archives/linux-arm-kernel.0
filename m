From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:33 +0900
Subject: [PATCH 20/24] ARM: shmobile: r8a7779 dtsi: Correct
 #address-cells/#size-cells for clocks
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <5cc8afcbc47c5f33732fb1a4b37a35841e7494e8.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (ranges_format): /clocks has empty "ranges" property but its #address-cells (2) differs from / (1)
Warning (ranges_format): /clocks has empty "ranges" property but its #size-cells (2) differs from / (1)

As r8a7779 doesn't support LPAE, change #address-cells and #size-cells from
"<2>" to "<1>", and update the affected "reg" properties to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 27bf227..61d08f4 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -284,8 +284,8 @@
 	};
 
 	clocks {
-		#address-cells = <2>;
-		#size-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
 		ranges;
 
 		/* External root clock */
@@ -300,7 +300,7 @@
 		/* Special CPG clocks */
 		cpg_clocks: clocks at ffc80000 {
 			compatible = "renesas,r8a7779-cpg-clocks";
-			reg = <0 0xffc80000 0 0x30>;
+			reg = <0xffc80000 0x30>;
 			clocks = <&extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "plla", "z", "zs", "s",
@@ -345,7 +345,7 @@
 		mstp0_clks: clocks at ffc80030 {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
-			reg = <0 0xffc80030 0 4>;
+			reg = <0xffc80030 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_S>,
 			         <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
@@ -382,7 +382,7 @@
 		mstp1_clks: clocks at ffc80034 {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
-			reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
+			reg = <0xffc80034 4>, <0xffc80044 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
@@ -411,7 +411,7 @@
 		mstp3_clks: clocks at ffc8003c {
 			compatible = "renesas,r8a7779-mstp-clocks",
 			             "renesas,cpg-mstp-clocks";
-			reg = <0 0xffc8003c 0 4>;
+			reg = <0xffc8003c 4>;
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
 			#clock-cells = <1>;
-- 
2.0.0.rc2
