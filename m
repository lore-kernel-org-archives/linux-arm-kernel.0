From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 15 Aug 2016 10:55:38 +0200
Subject: [PATCH 19/26] ARM: dts: r8a7794: add MSTP5 clocks
In-Reply-To: <cover.1471251169.git.horms+renesas@verge.net.au>
References: <cover.1471251169.git.horms+renesas@verge.net.au>
Message-ID: <2a29f9d6fea82485941449c2328af5b2a4ea636f.1471251169.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add some MSTP5 clocks to the R8A7794 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 9 +++++++++
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 5d1fded79633..1c2d3846d70e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -1204,6 +1204,15 @@
 			clock-indices = <R8A7794_CLK_IRQC>;
 			clock-output-names = "irqc";
 		};
+		mstp5_clks: mstp5_clks at e6150144 {
+			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&hp_clk>, <&extal_clk>, <&p_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7794_CLK_AUDIO_DMAC0
+					 R8A7794_CLK_PWM>;
+			clock-output-names = "audmac0", "pwm";
+		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index a3491ba2f6ec..f8279eca033e 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -67,6 +67,7 @@
 #define R8A7794_CLK_IRQC		7
 
 /* MSTP5 */
+#define R8A7794_CLK_AUDIO_DMAC0		2
 #define R8A7794_CLK_PWM			23
 
 /* MSTP7 */
-- 
2.7.0.rc3.207.g0ac5344
