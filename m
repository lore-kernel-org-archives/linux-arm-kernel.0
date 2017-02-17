From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 17 Feb 2017 14:48:37 +0100
Subject: [PATCH 3/3] ARM: dts: imx6qp: correct IPU nodes
In-Reply-To: <20170217134837.14173-1-l.stach@pengutronix.de>
References: <20170217134837.14173-1-l.stach@pengutronix.de>
Message-ID: <20170217134837.14173-3-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference them by handle and remove the changed clocks that are copied
from the downstream DT and are not part of the mainline binding.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index b077394ed586..4fd6f26b89a6 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -55,32 +55,6 @@
 			reg = <0x00960000 0x20000>;
 			clocks = <&clks IMX6QDL_CLK_OCRAM>;
 		};
-
-		ipu1: ipu at 02400000 {
-			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
-			clocks = <&clks IMX6QDL_CLK_IPU1>,
-				 <&clks IMX6QDL_CLK_IPU1_DI0>, <&clks IMX6QDL_CLK_IPU1_DI1>,
-				 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
-				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
-				 <&clks IMX6QDL_CLK_PRG0_APB>;
-			clock-names = "bus",
-				      "di0", "di1",
-				      "di0_sel", "di1_sel",
-				      "ldb_di0", "ldb_di1", "prg";
-		};
-
-		ipu2: ipu at 02800000 {
-			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
-			clocks = <&clks IMX6QDL_CLK_IPU2>,
-				 <&clks IMX6QDL_CLK_IPU2_DI0>, <&clks IMX6QDL_CLK_IPU2_DI1>,
-				 <&clks IMX6QDL_CLK_IPU2_DI0_SEL>, <&clks IMX6QDL_CLK_IPU2_DI1_SEL>,
-				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
-				 <&clks IMX6QDL_CLK_PRG1_APB>;
-			clock-names = "bus",
-				      "di0", "di1",
-				      "di0_sel", "di1_sel",
-				      "ldb_di0", "ldb_di1", "prg";
-		};
 	};
 };
 
@@ -90,6 +64,14 @@
 		     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&ipu1 {
+	compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+};
+
+&ipu2 {
+	compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
+};
+
 &ldb {
 	clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
 		 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
-- 
2.11.0
