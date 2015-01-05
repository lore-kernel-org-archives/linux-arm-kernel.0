From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  5 Jan 2015 09:44:08 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: Correct SDHI clock node names
Message-ID: <1420418648-7815-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the SDHI clock node names to match their labels
and the documentation.

This has no run-time affect as the clock nodes are not currently used.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8f78da5..9856e9c 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -294,14 +294,14 @@
 					     "lb", "qspi", "sdh", "sd0", "z";
 		};
 		/* Variable factor clocks */
-		sd1_clk: sd2_clk at e6150078 {
+		sd1_clk: sd1_clk at e6150078 {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe6150078 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "sd1";
 		};
-		sd2_clk: sd3_clk at e615007c {
+		sd2_clk: sd2_clk at e615007c {
 			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0 0xe615007c 0 4>;
 			clocks = <&pll1_div2_clk>;
-- 
2.1.3
