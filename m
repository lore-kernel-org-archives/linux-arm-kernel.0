From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:24 +0900
Subject: [PATCH 16/26] ARM: dts: r8a7778: Remove unnecessary
 clock-output-names properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <452fc89994c2a81ade92096088b94ecbfef436a8.1459731908.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7778.dtsi | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index f83a348fc07a..99c10ebbaca2 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -443,11 +443,10 @@
 		ranges;
 
 		/* External input clock */
-		extal_clk: extal_clk {
+		extal_clk: extal {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "extal";
 		};
 
 		/* External SCIF clock */
@@ -474,59 +473,51 @@
 		audio_clk_a: audio_clk_a {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-output-names = "audio_clk_a";
 		};
 		audio_clk_b: audio_clk_b {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-output-names = "audio_clk_b";
 		};
 		audio_clk_c: audio_clk_c {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-output-names = "audio_clk_c";
 		};
 
 		/* Fixed ratio clocks */
-		g_clk: g_clk {
+		g_clk: g {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <12>;
 			clock-mult = <1>;
-			clock-output-names = "g";
 		};
-		i_clk: i_clk {
+		i_clk: i {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <1>;
 			clock-mult = <1>;
-			clock-output-names = "i";
 		};
-		s3_clk: s3_clk {
+		s3_clk: s3 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <4>;
 			clock-mult = <1>;
-			clock-output-names = "s3";
 		};
-		s4_clk: s4_clk {
+		s4_clk: s4 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "s4";
 		};
-		z_clk: z_clk {
+		z_clk: z {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7778_CLK_PLLB>;
 			#clock-cells = <0>;
 			clock-div = <1>;
 			clock-mult = <1>;
-			clock-output-names = "z";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
