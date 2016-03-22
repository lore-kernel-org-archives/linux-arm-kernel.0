From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:36 +0900
Subject: [PATCH 09/13] ARM: dts: r8a7794: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-10-git-send-email-horms+renesas@verge.net.au>
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
---
 arch/arm/boot/dts/r8a7794.dtsi | 66 ++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index e2a4b6bd16a0..a057112d14f0 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -887,12 +887,11 @@
 		ranges;
 
 		/* External root clock */
-		extal_clk: extal_clk {
+		extal_clk: extal {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			/* This value must be overriden by the board. */
 			clock-frequency = <0>;
-			clock-output-names = "extal";
 		};
 
 		/* External USB clock - can be overridden by the board */
@@ -933,173 +932,152 @@
 			#power-domain-cells = <0>;
 		};
 		/* Variable factor clocks */
-		sd2_clk: sd2_clk at e6150078 {
+		sd2_clk: sd2 at e6150078 {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd2";
 		};
-		sd3_clk: sd3_clk at e615026c {
+		sd3_clk: sd3 at e615026c {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd3";
 		};
-		mmc0_clk: mmc0_clk at e6150240 {
+		mmc0_clk: mmc0 at e6150240 {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150240 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mmc0";
 		};
 
 		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2_clk {
+		pll1_div2_clk: pll1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div2";
 		};
-		zg_clk: zg_clk {
+		zg_clk: zg {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <6>;
 			clock-mult = <1>;
-			clock-output-names = "zg";
 		};
-		zx_clk: zx_clk {
+		zx_clk: zx {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <3>;
 			clock-mult = <1>;
-			clock-output-names = "zx";
 		};
-		zs_clk: zs_clk {
+		zs_clk: zs {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <6>;
 			clock-mult = <1>;
-			clock-output-names = "zs";
 		};
-		hp_clk: hp_clk {
+		hp_clk: hp {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <12>;
 			clock-mult = <1>;
-			clock-output-names = "hp";
 		};
-		i_clk: i_clk {
+		i_clk: i {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "i";
 		};
-		b_clk: b_clk {
+		b_clk: b {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <12>;
 			clock-mult = <1>;
-			clock-output-names = "b";
 		};
-		p_clk: p_clk {
+		p_clk: p {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <24>;
 			clock-mult = <1>;
-			clock-output-names = "p";
 		};
-		cl_clk: cl_clk {
+		cl_clk: cl {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <48>;
 			clock-mult = <1>;
-			clock-output-names = "cl";
 		};
-		m2_clk: m2_clk {
+		m2_clk: m2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "m2";
 		};
-		rclk_clk: rclk_clk {
+		rclk_clk: rclk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <(48 * 1024)>;
 			clock-mult = <1>;
-			clock-output-names = "rclk";
 		};
-		oscclk_clk: oscclk_clk {
+		oscclk_clk: oscclk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <(12 * 1024)>;
 			clock-mult = <1>;
-			clock-output-names = "oscclk";
 		};
-		zb3_clk: zb3_clk {
+		zb3_clk: zb3 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
 			#clock-cells = <0>;
 			clock-div = <4>;
 			clock-mult = <1>;
-			clock-output-names = "zb3";
 		};
-		zb3d2_clk: zb3d2_clk {
+		zb3d2_clk: zb3d2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "zb3d2";
 		};
-		ddr_clk: ddr_clk {
+		ddr_clk: ddr {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7794_CLK_PLL3>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "ddr";
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
 			clocks = <&cpg_clocks R8A7794_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <48>;
 			clock-mult = <1>;
-			clock-output-names = "cp";
 		};
 
-		acp_clk: acp_clk {
+		acp_clk: acp {
 			compatible = "fixed-factor-clock";
 			clocks = <&extal_clk>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "acp";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
