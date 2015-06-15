From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 16 Jun 2015 02:42:42 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: add EtherAVB clocks
In-Reply-To: <2857896.YA1bBSQVkA@wasted.cogentembedded.com>
References: <2857896.YA1bBSQVkA@wasted.cogentembedded.com>
Message-ID: <3547940.lZD6YNB6hA@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the EtherAVB clock to the R8A7790 device tree.

Based on original patch by Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- fixed the order of the clock property values;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi            |   10 ++++++----
 include/dt-bindings/clock/r8a7790-clock.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -1249,16 +1249,18 @@
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
 			clocks = <&hp_clk>, <&zg_clk>, <&zg_clk>, <&zg_clk>,
-			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
+			         <&zg_clk>, <&hp_clk>, <&p_clk>, <&zs_clk>,
+				 <&zs_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7790_CLK_MLB R8A7790_CLK_VIN3 R8A7790_CLK_VIN2
-				R8A7790_CLK_VIN1 R8A7790_CLK_VIN0 R8A7790_CLK_ETHER
+				R8A7790_CLK_VIN1 R8A7790_CLK_VIN0
+				R8A7790_CLK_ETHERAVB R8A7790_CLK_ETHER
 				R8A7790_CLK_SATA1 R8A7790_CLK_SATA0
 			>;
 			clock-output-names =
-				"mlb", "vin3", "vin2", "vin1", "vin0", "ether",
-				"sata1", "sata0";
+				"mlb", "vin3", "vin2", "vin1", "vin0",
+				"etheravb", "ether", "sata1", "sata0";
 		};
 		mstp9_clks: mstp9_clks at e6150994 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
Index: renesas/include/dt-bindings/clock/r8a7790-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7790-clock.h
+++ renesas/include/dt-bindings/clock/r8a7790-clock.h
@@ -108,6 +108,7 @@
 #define R8A7790_CLK_VIN2		9
 #define R8A7790_CLK_VIN1		10
 #define R8A7790_CLK_VIN0		11
+#define R8A7790_CLK_ETHERAVB		12
 #define R8A7790_CLK_ETHER		13
 #define R8A7790_CLK_SATA1		14
 #define R8A7790_CLK_SATA0		15
