From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:27 +0900
Subject: [PATCH 30/32] ARM: shmobile: r8a7791: add ADSP clocks
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <ae65a8ae4c25c7ea01204c9d033cd47da3000cf8.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the ADSP clocks to the CPG and MSTP5 nodes of the R8A7791 device tree.

Based on the original patch by Konstantin Kozhevnikov
<konstantin.kozhevnikov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 11 +++++++----
 include/dt-bindings/clock/r8a7791-clock.h |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index ff49b95..1e593a2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -909,7 +909,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "z",
-					     "rcan";
+					     "rcan", "adsp";
 		};
 
 		/* Variable factor clocks */
@@ -1164,13 +1164,16 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&cpg_clocks R8A7791_CLK_ADSP>,
+				 <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
-				R8A7791_CLK_THERMAL R8A7791_CLK_PWM
+				R8A7791_CLK_ADSP_MOD R8A7791_CLK_THERMAL
+				R8A7791_CLK_PWM
 			>;
-			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
+			clock-output-names = "audmac0", "audmac1", "adsp_mod",
+					     "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index a45a363..8fc5dc8 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -21,6 +21,7 @@
 #define R8A7791_CLK_SD0			7
 #define R8A7791_CLK_Z			8
 #define R8A7791_CLK_RCAN		9
+#define R8A7791_CLK_ADSP		10
 
 /* MSTP0 */
 #define R8A7791_CLK_MSIOF0		0
@@ -72,6 +73,7 @@
 /* MSTP5 */
 #define R8A7791_CLK_AUDIO_DMAC1		1
 #define R8A7791_CLK_AUDIO_DMAC0		2
+#define R8A7791_CLK_ADSP_MOD		6
 #define R8A7791_CLK_THERMAL		22
 #define R8A7791_CLK_PWM			23
 
-- 
2.1.4
