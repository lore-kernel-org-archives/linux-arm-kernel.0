From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 27 Jul 2016 23:59:59 +0300
Subject: [PATCH v4 2/6] ARM: dts: r8a7794: add MSTP5 clocks
In-Reply-To: <3910788.ckTpUWEs6B@wasted.cogentembedded.com>
References: <3910788.ckTpUWEs6B@wasted.cogentembedded.com>
Message-ID: <3560619.yXVhzgu5Aq@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some MSTP5 clocks to the R8A7794 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- removed non-existant thermal sensor clock;
- refreshed the patch.

Changes in version 3:
- refreshed the patch.

Changes in version 2:
- added "the" article to the change log.

 arch/arm/boot/dts/r8a7794.dtsi            |    9 +++++++++
 include/dt-bindings/clock/r8a7794-clock.h |    1 +
 2 files changed, 10 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
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
Index: renesas/include/dt-bindings/clock/r8a7794-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7794-clock.h
+++ renesas/include/dt-bindings/clock/r8a7794-clock.h
@@ -67,6 +67,7 @@
 #define R8A7794_CLK_IRQC		7
 
 /* MSTP5 */
+#define R8A7794_CLK_AUDIO_DMAC0		2
 #define R8A7794_CLK_PWM			23
 
 /* MSTP7 */
