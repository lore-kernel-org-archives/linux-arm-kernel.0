From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu,  6 Mar 2014 12:32:29 +0100
Subject: [PATCH V2 09/12] ARM: shmobile: r7s72100: add i2c clocks to dtsi
In-Reply-To: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394105552-9744-10-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100.dtsi            | 15 +++++++++++++++
 include/dt-bindings/clock/r7s72100-clock.h |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index a926f61f7f69..7d2f12ede1f7 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -118,6 +118,17 @@
 			>;
 			clock-output-names = "scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scif6", "scif7";
 		};
+
+		mstp9_clks: mstp9_clks at fcfe0438 {
+			#clock-cells = <1>;
+			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xfcfe0438 4>;
+			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>;
+			renesas,clock-indices = <
+				R7S72100_CLK_I2C0 R7S72100_CLK_I2C1 R7S72100_CLK_I2C2 R7S72100_CLK_I2C3
+			>;
+			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
+		};
 	};
 
 	cpus {
@@ -153,6 +164,7 @@
 			     <0 162 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 163 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 164 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R7S72100_CLK_I2C0>;
 		clock-frequency = <100000>;
 		status = "disabled";
 	};
@@ -170,6 +182,7 @@
 			     <0 170 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 171 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 172 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R7S72100_CLK_I2C1>;
 		clock-frequency = <100000>;
 		status = "disabled";
 	};
@@ -187,6 +200,7 @@
 			     <0 178 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 179 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 180 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R7S72100_CLK_I2C2>;
 		clock-frequency = <100000>;
 		status = "disabled";
 	};
@@ -204,6 +218,7 @@
 			     <0 186 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 187 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R7S72100_CLK_I2C3>;
 		clock-frequency = <100000>;
 		status = "disabled";
 	};
diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index eced0a8382b0..46fab31d070a 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -22,4 +22,10 @@
 #define R7S72100_CLK_SCIF6	1
 #define R7S72100_CLK_SCIF7	0
 
+/* MSTP9 */
+#define R7S72100_CLK_I2C0	7
+#define R7S72100_CLK_I2C1	6
+#define R7S72100_CLK_I2C2	5
+#define R7S72100_CLK_I2C3	4
+
 #endif /* __DT_BINDINGS_CLOCK_R7S72100_H__ */
-- 
1.9.0
