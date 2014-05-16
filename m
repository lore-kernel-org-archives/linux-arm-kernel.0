From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 16 May 2014 15:17:16 +0300
Subject: [PATCH v3 09/13] dt/bindings: ti,
 edma: Remove redundant properties from documentation
In-Reply-To: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1400242640-9902-10-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From CCCFG register of eDMA3 we can get all the needed information for the
driver about the IP:
Number of channels: NUM_DMACH
Number of regions: NUM_REGN
Number of slots (PaRAM sets): NUM_PAENTRY
Number of TC/EQ: NUM_EVQUE

The ti,edma-regions; ti,edma-slots and dma-channels in DT are
redundant since the very same information can be obtained from the HW.
The mentioned properties are deprecated.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
index 68ff2137bae7..5ba525a10035 100644
--- a/Documentation/devicetree/bindings/dma/ti-edma.txt
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -2,11 +2,8 @@ TI EDMA
 
 Required properties:
 - compatible : "ti,edma3"
-- ti,edma-regions: Number of regions
-- ti,edma-slots: Number of slots
 - #dma-cells: Should be set to <1>
               Clients should use a single channel number per DMA request.
-- dma-channels: Specify total DMA channels per CC
 - reg: Memory map for accessing module
 - interrupt-parent: Interrupt controller the interrupt is routed through
 - interrupts: Exactly 3 interrupts need to be specified in the order:
@@ -17,6 +14,13 @@ Optional properties:
 - ti,hwmods: Name of the hwmods associated to the EDMA
 - ti,edma-xbar-event-map: Crossbar event to channel map
 
+Deprecated properties:
+Listed here in case one wants to boot an old kernel with new DTB. These
+properties might need to be added to the new DTS files.
+- ti,edma-regions: Number of regions
+- ti,edma-slots: Number of slots
+- dma-channels: Specify total DMA channels per CC
+
 Example:
 
 edma: edma at 49000000 {
@@ -26,9 +30,6 @@ edma: edma at 49000000 {
 	compatible = "ti,edma3";
 	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
 	#dma-cells = <1>;
-	dma-channels = <64>;
-	ti,edma-regions = <4>;
-	ti,edma-slots = <256>;
 	ti,edma-xbar-event-map = /bits/ 16 <1 12
 					    2 13>;
 };
-- 
1.9.3
