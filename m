From: mporter@ti.com (Matt Porter)
Date: Thu, 11 Oct 2012 15:04:31 -0400
Subject: [RFC PATCH v2 06/16] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <1349982281-10785-1-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Message-ID: <1349982281-10785-7-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The binding definition is based on the generic DMA controller
binding.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt |   49 +++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
new file mode 100644
index 0000000..06402eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -0,0 +1,49 @@
+TI EDMA
+
+Required properties:
+- compatible : "ti,edma3"
+- ti,hwmods: Name of the hwmods associated to the EDMA
+- ti,edma-regions: Number of regions
+- ti,edma-slots: Number of slots
+- ti,edma-queue-tc-map: List of transfer control to queue mappings
+- ti,edma-queue-priority-map: List of queue priority mappings
+- ti,edma-default-queue: Default queue value
+
+Optional properties:
+- ti,edma-reserved-channels: List of reserved channel regions
+- ti,edma-reserved-slots: List of reserved slot regions
+
+Example:
+
+edma: edma at 49000000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x49000000 0x10000>;
+	interrupt-parent = <&intc>;
+	interrupts = <12 13 14>;
+	compatible = "ti,edma3";
+	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+	#dma-cells = <1>;
+	dma-channels = <64>;
+	ti,edma-regions = <4>;
+	ti,edma-slots = <256>;
+	ti,edma-reserved-channels = <0  2
+				     14 2
+				     26 6
+				     48 4
+				     56 8>;
+	ti,edma-reserved-slots = <0  2
+				  14 2
+				  26 6
+				  48 4
+				  56 8
+				  64 127>;
+	ti,edma-queue-tc-map = <0 0
+				1 1
+				2 2>;
+	ti,edma-queue-priority-map = <0 0
+				      1 1
+				      2 2>;
+	ti,edma-default-queue = <0>;
+};
+
-- 
1.7.9.5
