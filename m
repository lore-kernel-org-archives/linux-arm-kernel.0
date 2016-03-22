From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:35 +0900
Subject: [PATCH 08/13] ARM: dts: r8a7793: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-9-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7793.dtsi | 45 +++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index e34d7f48eff3..bf70c464920b 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -856,12 +856,11 @@
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
@@ -872,19 +871,16 @@
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
 
 		/* External USB clock - can be overridden by the board */
@@ -926,111 +922,98 @@
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
