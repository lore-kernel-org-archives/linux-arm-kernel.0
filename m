From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Thu, 6 Jul 2017 16:55:28 +0800
Subject: [PATCH 1/3] dts: ls2088a: add pcie support
Message-ID: <1499331330-38362-1-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The physical memory map address and CCSR registers map address are
different between LS2088A and other LS2080A series SoCs.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
index 5c695c6..7d26531 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
@@ -134,6 +134,7 @@
 };
 
 &pcie1 {
+	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
 	reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
 	       0x20 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -142,6 +143,7 @@
 };
 
 &pcie2 {
+	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
 	reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
 	       0x28 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -150,6 +152,7 @@
 };
 
 &pcie3 {
+	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
 	reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
 	       0x30 0x00000000 0x0 0x00002000>; /* configuration space */
 
@@ -158,6 +161,7 @@
 };
 
 &pcie4 {
+	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
 	reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
 	       0x38 0x00000000 0x0 0x00002000>; /* configuration space */
 
-- 
2.1.0.27.g96db324
