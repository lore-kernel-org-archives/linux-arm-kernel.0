From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:20 +0900
Subject: [PATCH 08/17] ARM: shmobile: sh73a0 dtsi: Add selectable sources to
 DIV6 clocks
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <a1bef10ef201c2e7fd59e9a2506caaaa90109141.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Specifies clock sources and register bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
[geert: Drop renesas,src-shift/renesas,src-width, pad to 4 or 8 parents]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 64 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ac660c4..e187f16 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -417,133 +417,159 @@
 		vclk1_clk: vclk1_clk at e6150008 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150008 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
+				 <0>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk1";
 		};
 		vclk2_clk: vclk2_clk at e615000c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615000c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
+				 <0>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk2";
 		};
 		vclk3_clk: vclk3_clk at e615001c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615001c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extcki_clk>, <&extal2_clk>, <&main_div2_clk>,
+				 <&extalr_clk>, <&cpg_clocks SH73A0_CLK_MAIN>,
+				 <0>;
 			#clock-cells = <0>;
 			clock-output-names = "vclk3";
 		};
 		zb_clk: zb_clk at e6150010 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150010 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "zb";
 		};
 		flctl_clk: flctl_clk at e6150014 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150014 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "flctlck";
 		};
 		sdhi0_clk: sdhi0_clk at e6150074 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150074 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi0ck";
 		};
 		sdhi1_clk: sdhi1_clk at e6150078 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150078 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi1ck";
 		};
 		sdhi2_clk: sdhi2_clk at e615007c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615007c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div13_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "sdhi2ck";
 		};
 		fsia_clk: fsia_clk at e6150018 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150018 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&fsiack_clk>, <&fsiack_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "fsia";
 		};
 		fsib_clk: fsib_clk at e6150090 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150090 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&fsibck_clk>, <&fsibck_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "fsib";
 		};
 		sub_clk: sub_clk at e6150080 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150080 4>;
-			clocks = <&extal2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "sub";
 		};
 		spua_clk: spua_clk at e6150084 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150084 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "spua";
 		};
 		spuv_clk: spuv_clk at e6150094 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150094 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&extal2_clk>, <&extal2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "spuv";
 		};
 		msu_clk: msu_clk at e6150088 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150088 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "msu";
 		};
 		hsi_clk: hsi_clk at e615008c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615008c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&pll1_div7_clk>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "hsi";
 		};
 		mfg1_clk: mfg1_clk at e6150098 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150098 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "mfg1";
 		};
 		mfg2_clk: mfg2_clk at e615009c {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe615009c 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "mfg2";
 		};
 		dsit_clk: dsit_clk at e6150060 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150060 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <0>,
+				 <&cpg_clocks SH73A0_CLK_PLL2>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "dsit";
 		};
 		dsi0p_clk: dsi0p_clk at e6150064 {
 			compatible = "renesas,sh73a0-div6-clock", "renesas,cpg-div6-clock";
 			reg = <0xe6150064 4>;
-			clocks = <&pll1_div2_clk>;
+			clocks = <&pll1_div2_clk>, <&cpg_clocks SH73A0_CLK_PLL2>,
+				 <&cpg_clocks SH73A0_CLK_MAIN>, <&extal2_clk>,
+				 <&extcki_clk>, <0>, <0>, <0>;
 			#clock-cells = <0>;
 			clock-output-names = "dsi0pck";
 		};
-- 
2.1.4
