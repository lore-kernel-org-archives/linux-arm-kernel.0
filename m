From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:40:30 +0900
Subject: [PATCH 03/13] ARM: dts: sh73a0: Remove unnecessary clock-output-names
 properties
In-Reply-To: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
References: <1458610840-15194-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458610840-15194-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fixed rate and fixed factor clocks do not require an
  clock-output-names property.
* Since 07705583e920fef6 ("clk: shmobile: div6: Make clock-output-names
  optional") Renesas div6 clocks do not require a clock-output-names
  property.

In the above cases there is only one clock output and its name is taken
from that of the clock node.

Accordingly, remove the unnecessary clock-output-names properties and as
necessary update the node names. The zb_clk is excluded from this rename
as the MSTP clock driver (clk-mstp.c) explicitly looks for a clock
named zb_clk for the r8a73a4 and sh73a0 SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 88 ++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 59 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index bf825ca4f6f7..e697250886ef 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -602,39 +602,33 @@
 		ranges;
 
 		/* External root clocks */
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
 			clock-frequency = <26000000>;
-			clock-output-names = "extal1";
 		};
-		extal2_clk: extal2_clk {
+		extal2_clk: extal2 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-output-names = "extal2";
 		};
-		extcki_clk: extcki_clk {
+		extcki_clk: extcki {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-output-names = "extcki";
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
@@ -650,7 +644,7 @@
 		};
 
 		/* Variable factor clocks (DIV6) */
-		vclk1_clk: vclk1_clk at e6150008 {
+		vclk1_clk: vclk1 at e6150008 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150008 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
@@ -658,9 +652,8 @@
 				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
 				 <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk1";
 		};
-		vclk2_clk: vclk2_clk at e615000c {
+		vclk2_clk: vclk2 at e615000c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615000c 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
@@ -668,9 +661,8 @@
 				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
 				 <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk2";
 		};
-		vclk3_clk: vclk3_clk at e615001c {
+		vclk3_clk: vclk3 at e615001c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615001c 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
@@ -678,7 +670,6 @@
 				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
 				 <0>;
 			#clock-cells = <0>;
-			clock-output-names = "vclk3";
 		};
 		zb_clk: zb_clk at e6150010 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
@@ -686,170 +677,149 @@
 			clocks = <&pll1_div2_clk>, <0>,
 				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "zb";
 		};
-		flctl_clk: flctl_clk at e6150014 {
+		flctl_clk: flctlck at e6150014 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150014 4>;
 			clocks = <&pll1_div2_clk>, <0>,
 				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "flctlck";
 		};
-		sdhi0_clk: sdhi0_clk at e6150074 {
+		sdhi0_clk: sdhi0ck at e6150074 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150074 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "sdhi0ck";
 		};
-		sdhi1_clk: sdhi1_clk at e6150078 {
+		sdhi1_clk: sdhi1ck at e6150078 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150078 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "sdhi1ck";
 		};
-		sdhi2_clk: sdhi2_clk at e615007c {
+		sdhi2_clk: sdhi2ck at e615007c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615007c 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "sdhi2ck";
 		};
-		fsia_clk: fsia_clk at e6150018 {
+		fsia_clk: fsia at e6150018 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150018 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&fsiack_clk>, <&fsiack_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "fsia";
 		};
-		fsib_clk: fsib_clk at e6150090 {
+		fsib_clk: fsib at e6150090 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150090 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&fsibck_clk>, <&fsibck_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "fsib";
 		};
-		sub_clk: sub_clk at e6150080 {
+		sub_clk: sub at e6150080 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150080 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "sub";
 		};
-		spua_clk: spua_clk at e6150084 {
+		spua_clk: spua at e6150084 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150084 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "spua";
 		};
-		spuv_clk: spuv_clk at e6150094 {
+		spuv_clk: spuv at e6150094 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150094 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
-			clock-output-names = "spuv";
 		};
-		msu_clk: msu_clk at e6150088 {
+		msu_clk: msu at e6150088 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150088 4>;
 			clocks = <&pll1_div2_clk>, <0>,
 				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "msu";
 		};
-		hsi_clk: hsi_clk at e615008c {
+		hsi_clk: hsi at e615008c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615008c 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&pll1_div7_clk>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "hsi";
 		};
-		mfg1_clk: mfg1_clk at e6150098 {
+		mfg1_clk: mfg1 at e6150098 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150098 4>;
 			clocks = <&pll1_div2_clk>, <0>,
 				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "mfg1";
 		};
-		mfg2_clk: mfg2_clk at e615009c {
+		mfg2_clk: mfg2 at e615009c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615009c 4>;
 			clocks = <&pll1_div2_clk>, <0>,
 				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "mfg2";
 		};
-		dsit_clk: dsit_clk at e6150060 {
+		dsit_clk: dsit at e6150060 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150060 4>;
 			clocks = <&pll1_div2_clk>, <0>,
 				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "dsit";
 		};
-		dsi0p_clk: dsi0p_clk at e6150064 {
+		dsi0p_clk: dsi0pck at e6150064 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150064 4>;
 			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
 				 <&cpg_clocks SH73A0_CLK_MAIN>, <&extal2_clk>,
 				 <&extcki_clk>, <0>, <0>, <0>;
 			#clock-cells = <0>;
-			clock-output-names = "dsi0pck";
 		};
 
 		/* Fixed factor clocks */
-		main_div2_clk: main_div2_clk {
+		main_div2_clk: main_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks SH73A0_CLK_MAIN>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "main_div2";
 		};
-		pll1_div2_clk: pll1_div2_clk {
+		pll1_div2_clk: pll1_div2 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks SH73A0_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <2>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div2";
 		};
-		pll1_div7_clk: pll1_div7_clk {
+		pll1_div7_clk: pll1_div7 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks SH73A0_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <7>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div7";
 		};
-		pll1_div13_clk: pll1_div13_clk {
+		pll1_div13_clk: pll1_div13 {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks SH73A0_CLK_PLL1>;
 			#clock-cells = <0>;
 			clock-div = <13>;
 			clock-mult = <1>;
-			clock-output-names = "pll1_div13";
 		};
-		twd_clk: twd_clk {
+		twd_clk: twd {
 			compatible = "fixed-factor-clock";
 			clocks = <&cpg_clocks SH73A0_CLK_Z>;
 			#clock-cells = <0>;
 			clock-div = <4>;
 			clock-mult = <1>;
-			clock-output-names = "twd";
 		};
 
 		/* Gate clocks */
-- 
2.1.4
