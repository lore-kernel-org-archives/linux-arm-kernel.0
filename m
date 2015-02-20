From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 20 Feb 2015 15:42:06 +0200
Subject: [PATCH 5/5] ARM: DTS: dra7: Correct the dma controller's property
 names
In-Reply-To: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
References: <1424439726-31994-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1424439726-31994-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the Documentation/devicetree/bindings/dma/dma.txt the
dma-channels and dma-requests property should not have '#'.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5827fedafd43..aefa4192533a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -249,8 +249,8 @@
 				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			#dma-channels = <32>;
-			#dma-requests = <127>;
+			dma-channels = <32>;
+			dma-requests = <127>;
 		};
 
 		gpio1: gpio at 4ae10000 {
-- 
2.3.0
