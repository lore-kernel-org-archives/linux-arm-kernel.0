From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 17 Feb 2017 14:48:36 +0100
Subject: [PATCH 2/3] ARM: dts: imx6qp: reference MMDC node by handle and
 remove duplication
In-Reply-To: <20170217134837.14173-1-l.stach@pengutronix.de>
References: <20170217134837.14173-1-l.stach@pengutronix.de>
Message-ID: <20170217134837.14173-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Referencing the node by handle make the QP DT more resilent against
changes of the base DT. Also remove the duplicated reg property, it's
not needed as it the same as in the base DT, just the compatible is
actually different.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index bceab2d87af4..b077394ed586 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -81,13 +81,6 @@
 				      "di0_sel", "di1_sel",
 				      "ldb_di0", "ldb_di1", "prg";
 		};
-
-		aips-bus at 02100000 {
-			mmdc0: mmdc at 021b0000 { /* MMDC0 */
-				compatible = "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
-				reg = <0x021b0000 0x4000>;
-			};
-		};
 	};
 };
 
@@ -107,6 +100,10 @@
 		      "di0", "di1";
 };
 
+&mmdc0 {
+	compatible = "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
+};
+
 &pcie {
 	compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
 };
-- 
2.11.0
