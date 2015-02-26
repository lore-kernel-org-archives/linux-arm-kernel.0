From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:28 +0900
Subject: [PATCH 31/32] ARM: shmobile: r8a7790: add ADSP clocks
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <3453ca9e4f51a0e6865d303f4e428cb6f630594f.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the ADSP clocks to the CPG and MSTP5 nodes of the R8A7790 device tree.

Based on the original patch by Konstantin Kozhevnikov
<konstantin.kozhevnikov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 11 +++++++----
 include/dt-bindings/clock/r8a7790-clock.h |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index cd7fc05..c6c0a0c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -885,7 +885,7 @@
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "sd1",
-					     "z", "rcan";
+					     "z", "rcan", "adsp";
 		};
 
 		/* Variable factor clocks */
@@ -1159,13 +1159,16 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&cpg_clocks R8A7790_CLK_ADSP>,
+				 <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
-				R8A7790_CLK_THERMAL R8A7790_CLK_PWM
+				R8A7790_CLK_ADSP_MOD R8A7790_CLK_THERMAL
+				R8A7790_CLK_PWM
 			>;
-			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
+			clock-output-names = "audmac0", "audmac1", "adsp_mod",
+					     "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index ffa8c11..3f2c6b1 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -22,6 +22,7 @@
 #define R8A7790_CLK_SD1			8
 #define R8A7790_CLK_Z			9
 #define R8A7790_CLK_RCAN		10
+#define R8A7790_CLK_ADSP		11
 
 /* MSTP0 */
 #define R8A7790_CLK_MSIOF0		0
@@ -81,6 +82,7 @@
 /* MSTP5 */
 #define R8A7790_CLK_AUDIO_DMAC1		1
 #define R8A7790_CLK_AUDIO_DMAC0		2
+#define R8A7790_CLK_ADSP_MOD		6
 #define R8A7790_CLK_THERMAL		22
 #define R8A7790_CLK_PWM			23
 
-- 
2.1.4
