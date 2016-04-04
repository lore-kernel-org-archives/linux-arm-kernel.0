From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:21 +0900
Subject: [PATCH 13/26] ARM: dts: r8a7790: Remove unnecessary
 clock-output-names properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <b19dd47b27d2bd719d304f27c0a4fcd3f51632dd.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fixed rate and fixed factor clocks do not require an
  clock-output-names property.
* Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
  optional") Renesas div6 clocks do not require a clock-output-names
  property.

In the above cases there is only one clock output and its name is taken
from that of the clock node.

Accordingly, remove the unnecessary clock-output-names properties and
as necessary the nodes.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 88 ++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 38b706399a6b..283698fc0fea 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1003,20 +1003,18 @@
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
 
 		/* External PCIe clock - can be overridden by the board */
-		pcie_bus_clk: pcie_bus_clk {
+		pcie_bus_clk: pcie_bus {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <100000000>;
-			clock-output-names = "pcie_bus";
 			status = "disabled";
 		};
 
@@ -1028,19 +1026,16 @@
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
@@ -1053,11 +1048,10 @@
 		};
 
 		/* External USB clock - can be overridden by the board */
-		usb_extal_clk: usb_extal_clk {
+		usb_extal_clk: usb_extal {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <48000000>;
-			clock-output-names = "usb_extal";
 		};
 
 		/* External CAN clock */
@@ -1066,7 +1060,6 @@
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
 			clock-frequency = <0>;
-			clock-output-names = "can_clk";
 			status = "disabled";
 		};
 
@@ -1084,201 +1077,176 @@
 		};
 
 		/* Variable factor clocks */
-		sd2_clk: sd2_clk at e6150078 {
+		sd2_clk: sd2 at e6150078 {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd2";
 		};
-		sd3_clk: sd3_clk at e615026c {
+		sd3_clk: sd3 at e615026c {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd3";
 		};
-		mmc0_clk: mmc0_clk at e6150240 {
+		mmc0_clk: mmc0 at e6150240 {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150240 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mmc0";
 		};
-		mmc1_clk: mmc1_clk at e6150244 {
+		mmc1_clk: mmc1 at e6150244 {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150244 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "mmc1";
 		};
-		ssp_clk: ssp_clk at e6150248 {
+		ssp_clk: ssp at e6150248 {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150248 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "ssp";
 		};
-		ssprs_clk: ssprs_clk at e615024c {
+		ssprs_clk: ssprs at e615024c {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615024c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "ssprs";
 		};
 
 		/* Fixed factor clocks */
-		pll1_div2_clk: pll1_div2_clk {
+		pll1_div2_clk: pll1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div2";
 		};
-		z2_clk: z2_clk {
+		z2_clk: z2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "z2";
 		};
-		zg_clk: zg_clk {
+		zg_clk: zg {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <3>;
 			clock-mult = <1>;
-			clock-output-names = "zg";
 		};
-		zx_clk: zx_clk {
+		zx_clk: zx {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <3>;
 			clock-mult = <1>;
-			clock-output-names = "zx";
 		};
-		zs_clk: zs_clk {
+		zs_clk: zs {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <6>;
 			clock-mult = <1>;
-			clock-output-names = "zs";
 		};
-		hp_clk: hp_clk {
+		hp_clk: hp {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <12>;
 			clock-mult = <1>;
-			clock-output-names = "hp";
 		};
-		i_clk: i_clk {
+		i_clk: i {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "i";
 		};
-		b_clk: b_clk {
+		b_clk: b {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <12>;
 			clock-mult = <1>;
-			clock-output-names = "b";
 		};
-		p_clk: p_clk {
+		p_clk: p {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <24>;
 			clock-mult = <1>;
-			clock-output-names = "p";
 		};
-		cl_clk: cl_clk {
+		cl_clk: cl {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <48>;
 			clock-mult = <1>;
-			clock-output-names = "cl";
 		};
-		m2_clk: m2_clk {
+		m2_clk: m2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "m2";
 		};
-		imp_clk: imp_clk {
+		imp_clk: imp {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <4>;
 			clock-mult = <1>;
-			clock-output-names = "imp";
 		};
-		rclk_clk: rclk_clk {
+		rclk_clk: rclk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <(48 * 1024)>;
 			clock-mult = <1>;
-			clock-output-names = "rclk";
 		};
-		oscclk_clk: oscclk_clk {
+		oscclk_clk: oscclk {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <(12 * 1024)>;
 			clock-mult = <1>;
-			clock-output-names = "oscclk";
 		};
-		zb3_clk: zb3_clk {
+		zb3_clk: zb3 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
 			#clock-cells = <0>;
 			clock-div = <4>;
 			clock-mult = <1>;
-			clock-output-names = "zb3";
 		};
-		zb3d2_clk: zb3d2_clk {
+		zb3d2_clk: zb3d2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "zb3d2";
 		};
-		ddr_clk: ddr_clk {
+		ddr_clk: ddr {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7790_CLK_PLL3>;
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
 			clocks = <&extal_clk>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "cp";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
