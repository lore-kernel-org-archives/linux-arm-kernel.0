From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 13 May 2014 10:43:48 +0300
Subject: [PATCH 4/4] ARM: dts: am4372: Remove obsolete properties from edma
 node
In-Reply-To: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
References: <1399967028-24757-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1399967028-24757-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
the the same information is available in the IP's CCCFG register.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 03a225505126..b9f83b705f4b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -108,9 +108,6 @@
 					<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
 					<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
-			dma-channels = <64>;
-			ti,edma-regions = <4>;
-			ti,edma-slots = <256>;
 		};
 
 		uart0: serial at 44e09000 {
-- 
1.9.3
