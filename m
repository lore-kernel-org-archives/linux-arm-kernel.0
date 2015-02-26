From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:15 +0900
Subject: [PATCH 18/32] ARM: shmobile: r8a7794: Correct SDHI clock base address,
 labels and output-names
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <5e7e155483dfbf590be9b05e53ae954dced73253.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Correct base address of SD3 div6 clk.
* Update div6 clock node labels
  There appears to have been some inconsistency and confusion here as on
  the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
  the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.

This has no run-time affect as the clock nodes are not currently used.

Fixes: 8e181633e6ca96049 ("ARM: shmobile: r8a7794: Add SDHI clocks to device tree")
Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 63b918b..fff9497 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -365,19 +365,19 @@
 					     "lb", "qspi", "sdh", "sd0", "z";
 		};
 		/* Variable factor clocks */
-		sd1_clk: sd2_clk at e6150078 {
+		sd2_clk: sd2_clk at e6150078 {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd1";
+			clock-output-names = "sd2";
 		};
-		sd2_clk: sd3_clk at e615007c {
+		sd3_clk: sd3_clk at e615026c {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615007c 0 4>;
+			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd2";
+			clock-output-names = "sd3";
 		};
 		mmc0_clk: mmc0_clk at e6150240 {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
@@ -589,7 +589,7 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
+			clocks = <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7794_CLK_SD0>,
 			         <&mmc0_clk>, <&rclk_clk>, <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
-- 
2.1.4
