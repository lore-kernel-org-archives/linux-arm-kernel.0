From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:33 +0900
Subject: [PATCH 25/26] ARM: dts: r8a73a4: Remove unnecessary
 clock-output-names properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <57c75d1ed6890b8c57fce5d0c557a6b486c4d898.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fixed rate and fixed factor clocks do not require an
  clock-output-names property.
* Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
  optional") Renesas div6 clocks do not require a clock-output-names
  property.

In the above cases there is only one clock output and its name is taken
from that of the clock node.  Accordingly, remove the unnecessary
clock-output-names properties and as necessary update the node names.

The clock-output-names property is left in place for the zb_clk which is
thus treated as a special case as the MSTP clock driver (clk-mstp.c)
explicitly looks for a clock with node name zb_clk for the r8a73a4 and
sh73a0 SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 75 ++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 50 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6583a1dfca1f..6954912a3753 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -486,37 +486,32 @@
 		ranges;
 
 		/* External root clocks */
-		extalr_clk: extalr_clk {
+		extalr_clk: extalr {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
-			clock-output-names = "extalr";
 		};
-		extal1_clk: extal1_clk {
+		extal1_clk: extal1 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
-			clock-output-names = "extal1";
 		};
-		extal2_clk: extal2_clk {
+		extal2_clk: extal2 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <48000000>;
-			clock-output-names = "extal2";
 		};
-		fsiack_clk: fsiack_clk {
+		fsiack_clk: fsiack {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
-			clock-output-names = "fsiack";
 		};
-		fsibck_clk: fsibck_clk {
+		fsibck_clk: fsibck {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
-			clock-output-names = "fsibck";
 		};
 
 		/* Special CPG clocks */
@@ -540,171 +535,151 @@
 			#clock-cells = <0>;
 			clock-output-names = "zb";
 		};
-		sdhi0_clk: sdhi0_clk at e6150074 {
+		sdhi0_clk: sdhi0ck at e6150074 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150074 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sdhi0ck";
 		};
-		sdhi1_clk: sdhi1_clk at e6150078 {
+		sdhi1_clk: sdhi1ck at e6150078 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sdhi1ck";
 		};
-		sdhi2_clk: sdhi2_clk at e615007c {
+		sdhi2_clk: sdhi2ck at e615007c {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615007c 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sdhi2ck";
 		};
-		mmc0_clk: mmc0_clk at e6150240 {
+		mmc0_clk: mmc0 at e6150240 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150240 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mmc0";
 		};
-		mmc1_clk: mmc1_clk at e6150244 {
+		mmc1_clk: mmc1 at e6150244 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150244 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mmc1";
 		};
-		vclk1_clk: vclk1_clk at e6150008 {
+		vclk1_clk: vclk1 at e6150008 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150008 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>, <&main_div2_clk>,
 				 <&extalr_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk1";
 		};
-		vclk2_clk: vclk2_clk at e615000c {
+		vclk2_clk: vclk2 at e615000c {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615000c 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>, <&main_div2_clk>,
 				 <&extalr_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk2";
 		};
-		vclk3_clk: vclk3_clk at e615001c {
+		vclk3_clk: vclk3 at e615001c {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615001c 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>, <&main_div2_clk>,
 				 <&extalr_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk3";
 		};
-		vclk4_clk: vclk4_clk at e6150014 {
+		vclk4_clk: vclk4 at e6150014 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150014 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>, <&main_div2_clk>,
 				 <&extalr_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk4";
 		};
-		vclk5_clk: vclk5_clk at e6150034 {
+		vclk5_clk: vclk5 at e6150034 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150034 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <0>, <&extal2_clk>, <&main_div2_clk>,
 				 <&extalr_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk5";
 		};
-		fsia_clk: fsia_clk at e6150018 {
+		fsia_clk: fsia at e6150018 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150018 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <&fsiack_clk>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "fsia";
 		};
-		fsib_clk: fsib_clk at e6150090 {
+		fsib_clk: fsib at e6150090 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150090 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <&fsibck_clk>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "fsib";
 		};
-		mp_clk: mp_clk at e6150080 {
+		mp_clk: mp at e6150080 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150080 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mp";
 		};
-		m4_clk: m4_clk at e6150098 {
+		m4_clk: m4 at e6150098 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150098 0 4>;
 			clocks = <&cpg_clocks R8A73A4_CLK_PLL2S>;
 			#clock-cells = <0>;
-			clock-output-names = "m4";
 		};
-		hsi_clk: hsi_clk at e615026c {
+		hsi_clk: hsi at e615026c {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615026c 0 4>;
 			clocks = <&cpg_clocks R8A73A4_CLK_PLL2H>, <&pll1_div2_clk>,
 				 <&cpg_clocks R8A73A4_CLK_PLL2S>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "hsi";
 		};
-		spuv_clk: spuv_clk at e6150094 {
+		spuv_clk: spuv at e6150094 {
 			compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150094 0 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
 				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "spuv";
 		};
 
 		/* Fixed factor clocks */
-		main_div2_clk: main_div2_clk {
+		main_div2_clk: main_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A73A4_CLK_MAIN>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "main_div2";
 		};
-		pll0_div2_clk: pll0_div2_clk {
+		pll0_div2_clk: pll0_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A73A4_CLK_PLL0>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pll0_div2";
 		};
-		pll1_div2_clk: pll1_div2_clk {
+		pll1_div2_clk: pll1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A73A4_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div2";
 		};
-		extal1_div2_clk: extal1_div2_clk {
+		extal1_div2_clk: extal1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&extal1_clk>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "extal1_div2";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
