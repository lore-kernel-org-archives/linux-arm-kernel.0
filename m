From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 29 Jan 2015 10:47:18 +0900
Subject: [PATCH] ARM: shmobile: r8a7791: Correct SDHI clock labels and
 output-names
Message-ID: <1422496038-3915-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There appears to have been some inconsistency and confusion here as on
the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.

Fixes: 59e79895b95892863 ("ARM: shmobile: r8a7791: Add clocks")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This follows the naming pattern of "ARM: shmobile: r8a7794: Correct SDHI
clock base address, labels and output-names".
---
 arch/arm/boot/dts/r8a7791.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6b0cd1b..86862a5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -880,19 +880,19 @@
 		};
 
 		/* Variable factor clocks */
-		sd1_clk: sd2_clk at e6150078 {
+		sd2_clk: sd2_clk at e6150078 {
 			compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd1";
+			clock-output-names = "sd2";
 		};
-		sd2_clk: sd3_clk at e615026c {
+		sd3_clk: sd3_clk at e615026c {
 			compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sd2";
+			clock-output-names = "sd3";
 		};
 		mmc0_clk: mmc0_clk at e6150240 {
 			compatible = "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock";
@@ -1113,7 +1113,7 @@
 		mstp3_clks: mstp3_clks at e615013c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
-			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
+			clocks = <&cp_clk>, <&sd3_clk>, <&sd2_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
 				 <&mmc0_clk>, <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>,
 				 <&hp_clk>, <&hp_clk>;
 			#clock-cells = <1>;
-- 
2.1.4
