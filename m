From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 03 Dec 2015 01:21:49 +0300
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add EtherAVB clock
In-Reply-To: <2926317.Iq110C4Bmk@wasted.cogentembedded.com>
References: <2926317.Iq110C4Bmk@wasted.cogentembedded.com>
Message-ID: <1620245.6Dzpr9HbEp@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EtherAVB clock to the R8A7791 device tree.

Based on the commit 63d2d750c902 ("ARM: shmobile: r8a7790: add EtherAVB
clocks").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791.dtsi            |   10 ++++++----
 include/dt-bindings/clock/r8a7791-clock.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -1329,16 +1329,18 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
 			clocks = <&zx_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
-			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
+			         <&zg_clk>, <&hp_clk>, <&p_clk>, <&zs_clk>,
+				 <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7791_CLK_IPMMU_SGX R8A7791_CLK_MLB
 				R8A7791_CLK_VIN2 R8A7791_CLK_VIN1 R8A7791_CLK_VIN0
-				R8A7791_CLK_ETHER R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
+				R8A7791_CLK_ETHERAVB R8A7791_CLK_ETHER
+				R8A7791_CLK_SATA1 R8A7791_CLK_SATA0
 			>;
 			clock-output-names =
-				"ipmmu_sgx", "mlb", "vin2", "vin1", "vin0", "ether",
-				"sata1", "sata0";
+				"ipmmu_sgx", "mlb", "vin2", "vin1", "vin0",
+				"etheravb", "ether", "sata1", "sata0";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
Index: renesas/include/dt-bindings/clock/r8a7791-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
+++ renesas/include/dt-bindings/clock/r8a7791-clock.h
@@ -102,6 +102,7 @@
 #define R8A7791_CLK_VIN2		9
 #define R8A7791_CLK_VIN1		10
 #define R8A7791_CLK_VIN0		11
+#define R8A7791_CLK_ETHERAVB		12
 #define R8A7791_CLK_ETHER		13
 #define R8A7791_CLK_SATA1		14
 #define R8A7791_CLK_SATA0		15
