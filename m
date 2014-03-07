From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri,  7 Mar 2014 17:00:47 +0100
Subject: [PATCH V3 11/12] ARM: shmobile: r7s72100: add spi clocks to dtsi
In-Reply-To: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394208048-32495-12-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 18 ++++++++++++++++++
 include/dt-bindings/clock/r7s72100-clock.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 9f7a06dc5e30..3575c0f86eda 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -129,6 +129,19 @@
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
+			renesas,clock-indices = <
+				R7S72100_CLK_SPI0 R7S72100_CLK_SPI1 R7S72100_CLK_SPI2 R7S72100_CLK_SPI3
+				R7S72100_CLK_SPI4
+			>;
+			clock-output-names = "spi0", "spi1", "spi2", "spi3", "spi4";
+		};
 	};
 
 	cpus {
@@ -326,6 +339,7 @@
 			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI0>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -339,6 +353,7 @@
 			     <0 242 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 243 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI1>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -352,6 +367,7 @@
 			     <0 245 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 246 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI2>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -365,6 +381,7 @@
 			     <0 248 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 249 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI3>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -378,6 +395,7 @@
 			     <0 251 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 252 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error", "rx", "tx";
+		clocks = <&mstp10_clks R7S72100_CLK_SPI4>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index b412bb2c93b1..5cb969fa4931 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -30,4 +30,11 @@
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
1.9.0
