From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 7 Mar 2016 17:17:28 +0200
Subject: [PATCH v2 01/10] ARM: DTS: dra7: Move the sDMA crossbar node under
 l4_cfg/scm
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1457363857-20797-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the sDMA xbar nodes under the L4 interconnect node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 098b4dd14b01..db7fda97a4fa 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -161,6 +161,15 @@
 					compatible = "syscon";
 					reg = <0x1c24 0x0024>;
 				};
+
+				sdma_xbar: dma-router at b78 {
+					compatible = "ti,dra7-dma-crossbar";
+					reg = <0xb78 0xfc>;
+					#dma-cells = <1>;
+					dma-requests = <205>;
+					ti,dma-safe-map = <0>;
+					dma-masters = <&sdma>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon at 5000 {
@@ -315,15 +324,6 @@
 			dma-requests = <127>;
 		};
 
-		sdma_xbar: dma-router at 4a002b78 {
-			compatible = "ti,dra7-dma-crossbar";
-			reg = <0x4a002b78 0xfc>;
-			#dma-cells = <1>;
-			dma-requests = <205>;
-			ti,dma-safe-map = <0>;
-			dma-masters = <&sdma>;
-		};
-
 		gpio1: gpio at 4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-- 
2.7.2
