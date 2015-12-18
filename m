From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Dec 2015 11:29:33 +0900
Subject: [PATCH 03/25] ARM: shmobile: r8a7791: add EtherAVB clock
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
Message-ID: <eaa870b3055384092d8fc075bca3a3a819f73c43.1450402264.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the EtherAVB clock to the R8A7791 device tree.

Based on the commit 63d2d750c902 ("ARM: shmobile: r8a7790: add EtherAVB
clocks").

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 10 ++++++----
 include/dt-bindings/clock/r8a7791-clock.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 12b2b0f95806..4b3132d9807f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
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
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index dd09b73c4aaf..ffa11379b3f0 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -102,6 +102,7 @@
 #define R8A7791_CLK_VIN2		9
 #define R8A7791_CLK_VIN1		10
 #define R8A7791_CLK_VIN0		11
+#define R8A7791_CLK_ETHERAVB		12
 #define R8A7791_CLK_ETHER		13
 #define R8A7791_CLK_SATA1		14
 #define R8A7791_CLK_SATA0		15
-- 
2.1.4
