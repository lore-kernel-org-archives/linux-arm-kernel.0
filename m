From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:13 +0100
Subject: [PATCH 14/29] ARM: dts: r7s72100: add sdhi clock to device tree
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <7c8522b7047c77ef598e8b5f9ff6e349c22e0622.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 8 ++++++++
 include/dt-bindings/clock/r7s72100-clock.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 50f9f3bc109d..eab06701ef11 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -149,6 +149,14 @@
 			>;
 			clock-output-names = "spi0", "spi1", "spi2", "spi3", "spi4";
 		};
+		mstp12_clks: mstp12_clks at fcfe0444 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0444 4>;
+			clocks = <&p1_clk>, <&p1_clk>;
+			clock-indices = <R7S72100_CLK_SDHI1 R7S72100_CLK_SDHI0>;
+			clock-output-names = "sdhi1", "sdhi0";
+		};
 	};
 
 	cpus {
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index 5eaf0fb469c2..29e01ed10e74 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -44,4 +44,8 @@
 #define R7S72100_CLK_SPI3	4
 #define R7S72100_CLK_SPI4	3
 
+/* MSTP12 */
+#define R7S72100_CLK_SDHI0	3
+#define R7S72100_CLK_SDHI1	2
+
 #endif /* __DT_BINDINGS_CLOCK_R7S72100_H__ */
-- 
2.7.0.rc3.207.g0ac5344
