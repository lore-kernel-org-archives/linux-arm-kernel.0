From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 15 Feb 2018 17:21:44 +0530
Subject: [PATCH 4/4] ARM64: dts: Add NOR connection type with IFC
Message-ID: <20180215115144.23798-1-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Connection between IFC and NOR flash is of big-endian type.

So add big-endian property in flash node to reflect the same.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Changes for v2: None
Changes for v3: None
Changes for v4: Updated device tree as per new binding

 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 6341281485cf..80aed686933f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -89,6 +89,7 @@
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
+		big-endian;
 	};
 
 	nand at 1,0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 3dc0c8e9663d..600ab2fb6f5a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -104,6 +104,7 @@
 			reg = <0x0 0x0 0x8000000>;
 			bank-width = <2>;
 			device-width = <1>;
+			big-endian;
 		};
 
 		nand at 1,0 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index 434383bade0e..153bba913e9a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -180,6 +180,7 @@
 		reg = <0x0 0x0 0x8000000>;
 		bank-width = <2>;
 		device-width = <1>;
+		big-endian;
 	};
 
 	nand at 1,0 {
-- 
2.14.1
