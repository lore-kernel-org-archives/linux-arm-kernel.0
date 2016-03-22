From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:33 +0900
Subject: [PATCH 06/13] ARM: dts: r8a7779: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-7-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7779.dtsi | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index a0cc08e6295b..60bc1e66bba9 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -445,12 +445,11 @@
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
 
 		/* External SCIF clock */
@@ -474,37 +473,33 @@
 		};
 
 		/* Fixed factor clocks */
-		i_clk: i_clk {
+		i_clk: i {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "i";
 		};
-		s3_clk: s3_clk {
+		s3_clk: s3 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <8>;
 			clock-mult = <1>;
-			clock-output-names = "s3";
 		};
-		s4_clk: s4_clk {
+		s4_clk: s4 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <16>;
 			clock-mult = <1>;
-			clock-output-names = "s4";
 		};
-		g_clk: g_clk {
+		g_clk: g {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
 			#clock-cells = <0>;
 			clock-div = <24>;
 			clock-mult = <1>;
-			clock-output-names = "g";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
