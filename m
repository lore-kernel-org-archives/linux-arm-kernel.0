From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:28 +0900
Subject: [PATCH 01/13] ARM: dts: r7s72100: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-2-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r7s72100.dtsi | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 89e46ebef1bc..e8e2a5d71976 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -37,46 +37,41 @@
 		#size-cells = <1>;
 
 		/* External clocks */
-		extal_clk: extal_clk {
+		extal_clk: extal {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			/* If clk present, value must be set by board */
 			clock-frequency = <0>;
-			clock-output-names = "extal";
 		};
 
-		usb_x1_clk: usb_x1_clk {
+		usb_x1_clk: usb_x1 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			/* If clk present, value must be set by board */
 			clock-frequency = <0>;
-			clock-output-names = "usb_x1";
 		};
 
 		/* Fixed factor clocks */
-		b_clk: b_clk {
+		b_clk: b {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R7S72100_CLK_PLL>;
 			clock-mult = <1>;
 			clock-div = <3>;
-			clock-output-names = "b";
 		};
-		p1_clk: p1_clk {
+		p1_clk: p1 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R7S72100_CLK_PLL>;
 			clock-mult = <1>;
 			clock-div = <6>;
-			clock-output-names = "p1";
 		};
-		p0_clk: p0_clk {
+		p0_clk: p0 {
 			#clock-cells = <0>;
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R7S72100_CLK_PLL>;
 			clock-mult = <1>;
 			clock-div = <12>;
-			clock-output-names = "p0";
 		};
 
 		/* Special CPG clocks */
-- 
2.1.4
