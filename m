From: marex@denx.de (Marek Vasut)
Date: Fri, 24 Apr 2015 13:29:47 +0200
Subject: [PATCH V2] ARM: dts: imx28: Fix AUART4 TX-DMA interrupt name
Message-ID: <1429874987-5481-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a typo in the TX DMA interrupt name for AUART4.
This patch makes AUART4 operational again.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: stable at vger.kernel.org
---
 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt | 2 +-
 arch/arm/boot/dts/imx28.dtsi                          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

V2: Update the Documentation as well (thanks to Stefan Wahren for spotting this)

diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
index a4873e5..e30e184 100644
--- a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
+++ b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
@@ -38,7 +38,7 @@ dma_apbx: dma-apbx at 80024000 {
 		      80 81 68 69
 		      70 71 72 73
 		      74 75 76 77>;
-	interrupt-names = "auart4-rx", "aurat4-tx", "spdif-tx", "empty",
+	interrupt-names = "auart4-rx", "auart4-tx", "spdif-tx", "empty",
 			  "saif0", "saif1", "i2c0", "i2c1",
 			  "auart0-rx", "auart0-tx", "auart1-rx", "auart1-tx",
 			  "auart2-rx", "auart2-tx", "auart3-rx", "auart3-tx";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 25e25f8..4e073e8 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -913,7 +913,7 @@
 					      80 81 68 69
 					      70 71 72 73
 					      74 75 76 77>;
-				interrupt-names = "auart4-rx", "aurat4-tx", "spdif-tx", "empty",
+				interrupt-names = "auart4-rx", "auart4-tx", "spdif-tx", "empty",
 						  "saif0", "saif1", "i2c0", "i2c1",
 						  "auart0-rx", "auart0-tx", "auart1-rx", "auart1-tx",
 						  "auart2-rx", "auart2-tx", "auart3-rx", "auart3-tx";
-- 
2.1.4
