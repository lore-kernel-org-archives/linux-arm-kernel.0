From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:27 +0900
Subject: [PATCH 19/26] ARM: dts: r8a7793: Remove unnecessary
 clock-output-names properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <3b81c0ce13c53445b1e38fa1ff86025e5b8a9199.1459731908.git.horms+renesas@verge.net.au>
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

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 45 +++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index b48215945241..95bbed95b0c1 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -812,12 +812,11 @@
 		ranges;
 
 		/* External root clock */
-		extal_clk: extal_clk {
+		extal_clk: extal {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
-			clock-output-names = "extal";
 		};
 
 		/*
@@ -828,19 +827,16 @@
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "audio_clk_a";
 		};
 		audio_clk_b: audio_clk_b {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "audio_clk_b";
 		};
 		audio_clk_c: audio_clk_c {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "audio_clk_c";
 		};
 
 		/* External SCIF clock */
@@ -866,111 +862,98 @@
 		};
 
 		/* Variable factor clocks */
-		sd2_clk: sd2_clk at e6150078 {
+		sd2_clk: sd2 at e6150078 {
 			compatible = "renesas,r8a7793-div6-clock",
 				     "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd2";
 		};
-		sd3_clk: sd3_clk at e615026c {
+		sd3_clk: sd3 at e615026c {
 			compatible = "renesas,r8a7793-div6-clock",
 				     "renesas,cpg-div6-clock";
 			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd3";
 		};
-		mmc0_clk: mmc0_clk at e6150240 {
+		mmc0_clk: mmc0 at e6150240 {
 			compatible = "renesas,r8a7793-div6-clock",
 				     "renesas,cpg-div6-clock";
 			reg = <0 0xe6150240 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mmc0";
 		};
 
 		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2_clk {
+		pll1_div2_clk: pll1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div2";
 		};
-		zg_clk: zg_clk {
+		zg_clk: zg {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <5>;
 			clock-mult = <1>;
-			clock-output-names = "zg";
 		};
-		zx_clk: zx_clk {
+		zx_clk: zx {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <3>;
 			clock-mult = <1>;
-			clock-output-names = "zx";
 		};
-		zs_clk: zs_clk {
+		zs_clk: zs {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <6>;
 			clock-mult = <1>;
-			clock-output-names = "zs";
 		};
-		hp_clk: hp_clk {
+		hp_clk: hp {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <12>;
 			clock-mult = <1>;
-			clock-output-names = "hp";
 		};
-		p_clk: p_clk {
+		p_clk: p {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <24>;
 			clock-mult = <1>;
-			clock-output-names = "p";
 		};
-		m2_clk: m2_clk {
+		m2_clk: m2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "m2";
 		};
-		rclk_clk: rclk_clk {
+		rclk_clk: rclk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7793_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <(48 * 1024)>;
 			clock-mult = <1>;
-			clock-output-names = "rclk";
 		};
-		mp_clk: mp_clk {
+		mp_clk: mp {
 			compatible = "fixed-factor-clock";
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
 			clock-div = <15>;
 			clock-mult = <1>;
-			clock-output-names = "mp";
 		};
-		cp_clk: cp_clk {
+		cp_clk: cp {
 			compatible = "fixed-factor-clock";
 			clocks = <&extal_clk>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "cp";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
