From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Jan 2015 09:53:42 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Correct SDHI clock base address,
 labels and output-names
Message-ID: <1422406422-671-1-git-send-email-horms+renesas@verge.net.au>
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

---

* A similar change to update the div6 clock node names and labels
  appears to be required for the r8a7791.  The base addresses appear to be
  correct there.

* This patch is a revised version of " ARM: shmobile: r8a7794: Correct SDHI
  base address, clock labels and output-names"
---
 arch/arm/boot/dts/r8a7794.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8f78da5..debf3e2d 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -294,19 +294,19 @@
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
@@ -518,7 +518,7 @@
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
