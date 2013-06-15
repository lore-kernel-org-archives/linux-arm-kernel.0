From: joelagnel@ti.com (Joel A Fernandes)
Date: Fri, 14 Jun 2013 21:32:47 -0500
Subject: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
Message-ID: <1371263570-9323-5-git-send-email-joelagnel@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matt Porter <mdp@ti.com>

The binding definition is based on the generic DMA controller
binding.

Joel: Droped reserved and queue DT entries from Documentation
for now from the original patch series.

Signed-off-by: Matt Porter <mporter@ti.com>
Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
---
 Documentation/devicetree/bindings/dma/ti-edma.txt |   26 +++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt

diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
new file mode 100644
index 0000000..ada0018
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
@@ -0,0 +1,26 @@
+TI EDMA
+
+Required properties:
+- compatible : "ti,edma3"
+- ti,hwmods: Name of the hwmods associated to the EDMA
+- ti,edma-regions: Number of regions
+- ti,edma-slots: Number of slots
+
+Optional properties:
+- ti,edma-xbar-event-map: Crossbar event to channel map
+
+Example:
+
+edma: edma at 49000000 {
+	reg = <0x49000000 0x10000>;
+	interrupt-parent = <&intc>;
+	interrupts = <12 13 14>;
+	compatible = "ti,edma3";
+	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+	#dma-cells = <1>;
+	dma-channels = <64>;
+	ti,edma-regions = <4>;
+	ti,edma-slots = <256>;
+	ti,edma-xbar-event-map = <1 12
+				  2 13>;
+};
-- 
1.7.9.5
