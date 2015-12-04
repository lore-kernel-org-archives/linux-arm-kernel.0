From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Dec 2015 15:53:25 +0200
Subject: [PATCH 1/6] ARM: DTS: da850: fix edma0 reg space
In-Reply-To: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1449237210-16381-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The size of the eDMA0 CC register space is 0x8000 and not 0x10000.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 0bd98cd00816..e73f5efb3aa3 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -152,7 +152,8 @@
 		};
 		edma0: edma at 01c00000 {
 			compatible = "ti,edma3";
-			reg =	<0x0 0x10000>;
+			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
+			reg =	<0x0 0x8000>;
 			interrupts = <11 13 12>;
 			#dma-cells = <1>;
 		};
-- 
2.6.3
