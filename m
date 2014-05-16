From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:34 +0900
Subject: [PATCH 09/12] ARM: shmobile: r7s72100: add spi clocks to dtsi
In-Reply-To: <cover.1400201383.git.horms+renesas@verge.net.au>
References: <cover.1400201383.git.horms+renesas@verge.net.au>
Message-ID: <52eed4f5c267bd50d870f9c63d0a83d6f83d8bab.1400201383.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 18 ++++++++++++++++++
 include/dt-bindings/clock/r7s72100-clock.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index afce2e3..f50fbc8 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -121,6 +121,19 @@
 			>;
 			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
 		};
+
+		mstp10_clks: mstp10_clks at fcfe043c {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe043c 4>;
+			clocks = <&p1_clk>, <&p1_clk>, <&p1_clk>, <&p1_clk>,
+				 <&p1_clk>;
+			clock-indices = <
+				R7S72100_CLK_SPI0 R7S72100_CLK_SPI1 R7S72100_CLK_SPI2 R7S72100_CLK_SPI3
+				R7S72100_CLK_SPI4
+			>;
+			clock-output-names = "spi0", "spi1", "spi2", "spi3", "spi4";
+		};
 	};
 
 	cpus {
@@ -318,6 +331,7 @@
 			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI0>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -331,6 +345,7 @@
 			     <0 242 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 243 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI1>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -344,6 +359,7 @@
 			     <0 245 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI2>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -357,6 +373,7 @@
 			     <0 248 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 249 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI3>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -370,6 +387,7 @@
 			     <0 251 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 252 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI4>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index ff84e0b..5128f4d 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -31,4 +31,11 @@
 #define R7S72100_CLK_I2C2	5
 #define R7S72100_CLK_I2C3	4
 
+/* MSTP10 */
+#define R7S72100_CLK_SPI0	7
+#define R7S72100_CLK_SPI1	6
+#define R7S72100_CLK_SPI2	5
+#define R7S72100_CLK_SPI3	4
+#define R7S72100_CLK_SPI4	3
+
 #endif /* __DT_BINDINGS_CLOCK_R7S72100_H__ */
-- 
1.8.5.2
