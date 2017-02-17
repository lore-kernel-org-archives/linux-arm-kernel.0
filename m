From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 17 Feb 2017 14:48:35 +0100
Subject: [PATCH 1/3] ARM: dts: imx6qp: reference PCIe node by handle
Message-ID: <20170217134837.14173-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By using the handle, we can avoid some duplication of the base DT
and so avoid any maintenance overhead in the QP DT if the referenced
node changes.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 24d071f5d9cd..bceab2d87af4 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -82,10 +82,6 @@
 				      "ldb_di0", "ldb_di1", "prg";
 		};
 
-		pcie: pcie at 0x01000000 {
-			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
-		};
-
 		aips-bus at 02100000 {
 			mmdc0: mmdc at 021b0000 { /* MMDC0 */
 				compatible = "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
@@ -110,3 +106,7 @@
 		      "di0_sel", "di1_sel", "di2_sel", "di3_sel",
 		      "di0", "di1";
 };
+
+&pcie {
+	compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
+};
-- 
2.11.0
