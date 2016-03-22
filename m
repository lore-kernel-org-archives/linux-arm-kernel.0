From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:31 +0900
Subject: [PATCH 04/13] ARM: dts: r8a7740: Remove unnecessary
 clock-output-names properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-5-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7740.dtsi | 57 ++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 995fbda74b7a..39b2f88ad151 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -422,53 +422,45 @@
 		ranges;
 
 		/* External root clock */
-		extalr_clk: extalr_clk {
+		extalr_clk: extalr {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
-			clock-output-names = "extalr";
 		};
-		extal1_clk: extal1_clk {
+		extal1_clk: extal1 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "extal1";
 		};
-		extal2_clk: extal2_clk {
+		extal2_clk: extal2 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "extal2";
 		};
-		dv_clk: dv_clk {
+		dv_clk: dv {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <27000000>;
-			clock-output-names = "dv";
 		};
-		fmsick_clk: fmsick_clk {
+		fmsick_clk: fmsick {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "fmsick";
 		};
-		fmsock_clk: fmsock_clk {
+		fmsock_clk: fmsock {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "fmsock";
 		};
-		fsiack_clk: fsiack_clk {
+		fsiack_clk: fsiack {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "fsiack";
 		};
-		fsibck_clk: fsibck_clk {
+		fsibck_clk: fsibck {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
-			clock-output-names = "fsibck";
 		};
 
 		/* Special CPG clocks */
@@ -486,7 +478,7 @@
 		};
 
 		/* Variable factor clocks (DIV6) */
-		vclk1_clk: vclk1_clk at e6150008 {
+		vclk1_clk: vclk1 at e6150008 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150008 4>;
 			clocks = <&pllc1_div2_clk>, <0>, <&dv_clk>,
@@ -494,9 +486,8 @@
 				 <&extal1_div2_clk>, <&extalr_clk>, <0>,
 				 <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk1";
 		};
-		vclk2_clk: vclk2_clk at e615000c {
+		vclk2_clk: vclk2 at e615000c {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615000c 4>;
 			clocks = <&pllc1_div2_clk>, <0>, <&dv_clk>,
@@ -504,77 +495,67 @@
 				 <&extal1_div2_clk>, <&extalr_clk>, <0>,
 				 <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk2";
 		};
-		fmsi_clk: fmsi_clk at e6150010 {
+		fmsi_clk: fmsi at e6150010 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150010 4>;
 			clocks = <&pllc1_div2_clk>, <&fmsick_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "fmsi";
 		};
-		fmso_clk: fmso_clk at e6150014 {
+		fmso_clk: fmso at e6150014 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150014 4>;
 			clocks = <&pllc1_div2_clk>, <&fmsock_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "fmso";
 		};
-		fsia_clk: fsia_clk at e6150018 {
+		fsia_clk: fsia at e6150018 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150018 4>;
 			clocks = <&pllc1_div2_clk>, <&fsiack_clk>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "fsia";
 		};
-		sub_clk: sub_clk at e6150080 {
+		sub_clk: sub at e6150080 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150080 4>;
 			clocks = <&pllc1_div2_clk>,
 				 <&cpg_clocks R8A7740_CLK_USB24S>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "sub";
 		};
-		spu_clk: spu_clk at e6150084 {
+		spu_clk: spu at e6150084 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150084 4>;
 			clocks = <&pllc1_div2_clk>,
 				 <&cpg_clocks R8A7740_CLK_USB24S>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "spu";
 		};
-		vou_clk: vou_clk at e6150088 {
+		vou_clk: vou at e6150088 {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150088 4>;
 			clocks = <&pllc1_div2_clk>, <&extal1_clk>, <&dv_clk>,
 				 <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vou";
 		};
-		stpro_clk: stpro_clk at e615009c {
+		stpro_clk: stpro at e615009c {
 			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615009c 4>;
 			clocks = <&cpg_clocks R8A7740_CLK_PLLC0>;
 			#clock-cells = <0>;
-			clock-output-names = "stpro";
 		};
 
 		/* Fixed factor clocks */
-		pllc1_div2_clk: pllc1_div2_clk {
+		pllc1_div2_clk: pllc1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks R8A7740_CLK_PLLC1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pllc1_div2";
 		};
-		extal1_div2_clk: extal1_div2_clk {
+		extal1_div2_clk: extal1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&extal1_clk>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "extal1_div2";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
