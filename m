From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Thu, 26 Nov 2015 10:39:30 +0800
Subject: [PATCH V1] ARM: dts: imx6: Change the clock name for spba clock
Message-ID: <8cd5b975aa4792f1dd9ac2f8909689f8d2018160.1448505436.git.shengjiu.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio IP need the spba clock, but original clock name "dma" is not
accurate, so change it to name "spba". The audio driver has been
using the new name "spba", the binding document has been updated.

Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 +++---
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 2b6cc8b..9ad5a2d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -227,7 +227,7 @@
 						      "rxtx1", "rxtx2",
 						      "rxtx3", "rxtx4",
 						      "rxtx5", "rxtx6",
-						      "rxtx7", "dma";
+						      "rxtx7", "spba";
 					status = "disabled";
 				};
 
@@ -309,7 +309,7 @@
 						 <&clks IMX6QDL_CLK_ESAI_EXTAL>,
 						 <&clks IMX6QDL_CLK_ESAI_IPG>,
 						 <&clks IMX6QDL_CLK_SPBA>;
-					clock-names = "core", "mem", "extal", "fsys", "dma";
+					clock-names = "core", "mem", "extal", "fsys", "spba";
 					dmas = <&sdma 23 21 0>, <&sdma 24 21 0>;
 					dma-names = "rx", "tx";
 					status = "disabled";
@@ -378,7 +378,7 @@
 						"asrck_1", "asrck_2", "asrck_3", "asrck_4",
 						"asrck_5", "asrck_6", "asrck_7", "asrck_8",
 						"asrck_9", "asrck_a", "asrck_b", "asrck_c",
-						"asrck_d", "asrck_e", "asrck_f", "dma";
+						"asrck_d", "asrck_e", "asrck_f", "spba";
 					dmas = <&sdma 17 23 1>, <&sdma 18 23 1>, <&sdma 19 23 1>,
 						<&sdma 20 23 1>, <&sdma 21 23 1>, <&sdma 22 23 1>;
 					dma-names = "rxa", "rxb", "rxc",
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index d8ba99f..cba6a44 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -151,7 +151,7 @@
 						"rxtx1", "rxtx2",
 						"rxtx3", "rxtx4",
 						"rxtx5", "rxtx6",
-						"rxtx7", "dma";
+						"rxtx7", "spba";
 					status = "disabled";
 				};
 
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 167f77b..afc142e 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -222,7 +222,7 @@
 						      "rxtx1", "rxtx2",
 						      "rxtx3", "rxtx4",
 						      "rxtx5", "rxtx6",
-						      "rxtx7", "dma";
+						      "rxtx7", "spba";
 					status = "disabled";
 				};
 
@@ -295,7 +295,7 @@
 						 <&clks IMX6SX_CLK_ESAI_IPG>,
 						 <&clks IMX6SX_CLK_SPBA>;
 					clock-names = "core", "mem", "extal",
-						      "fsys", "dma";
+						      "fsys", "spba";
 					status = "disabled";
 				};
 
@@ -348,7 +348,7 @@
 						 <&clks IMX6SX_CLK_ASRC_IPG>,
 						 <&clks IMX6SX_CLK_SPDIF>,
 						 <&clks IMX6SX_CLK_SPBA>;
-					clock-names = "mem", "ipg", "asrck", "dma";
+					clock-names = "mem", "ipg", "asrck", "spba";
 					dmas = <&sdma 17 20 1>, <&sdma 18 20 1>,
 					       <&sdma 19 20 1>, <&sdma 20 20 1>,
 					       <&sdma 21 20 1>, <&sdma 22 20 1>;
-- 
1.9.1
