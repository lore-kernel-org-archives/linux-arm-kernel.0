From: meng.yi@nxp.com (Meng Yi)
Date: Tue, 20 Dec 2016 14:03:07 +0800
Subject: [PATCH] arm64/dts/ls2080a-rdb: remove disable status of pca9547
Message-ID: <1482213787-27814-1-git-send-email-meng.yi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pca9547 won't probed since its status property is disabled.
while there are devices connected to it, we need remove status
property to let ds3232 and adt7461 probed correctly.

Signed-off-by: Meng Yi <meng.yi@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
index 265e0a8..2ff46ca 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
@@ -102,7 +102,6 @@
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		status = "disabled";
 		i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.1.0.27.g96db324
