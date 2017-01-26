From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Jan 2017 11:11:06 +0100
Subject: [PATCH 4/7] ARM: dts: r7s72100: add ostm clock to device tree
In-Reply-To: <cover.1485425227.git.horms+renesas@verge.net.au>
References: <cover.1485425227.git.horms+renesas@verge.net.au>
Message-ID: <cfddd3db08f619bf0c1764b3103caedb6793bc48.1485425227.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 9 +++++++++
 include/dt-bindings/clock/r7s72100-clock.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 3dd427d68c83..d5946df29222 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -108,6 +108,15 @@
 			clock-output-names = "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scif6", "scif7";
 		};
 
+		mstp5_clks: mstp5_clks at fcfe0428 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0428 4>;
+			clocks = <&p0_clk>, <&p0_clk>;
+			clock-indices = <R7S72100_CLK_OSTM0 R7S72100_CLK_OSTM1>;
+			clock-output-names = "ostm0", "ostm1";
+		};
+
 		mstp7_clks: mstp7_clks at fcfe0430 {
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index 29e01ed10e74..ce09915c298f 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -25,6 +25,10 @@
 #define R7S72100_CLK_SCIF6	1
 #define R7S72100_CLK_SCIF7	0
 
+/* MSTP5 */
+#define R7S72100_CLK_OSTM0	1
+#define R7S72100_CLK_OSTM1	0
+
 /* MSTP7 */
 #define R7S72100_CLK_ETHER	4
 
-- 
2.7.0.rc3.207.g0ac5344
