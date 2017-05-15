From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 15 May 2017 14:59:26 +0800
Subject: [PATCH 1/2] dt-bindings: dmaengine: Add Mediatek High-Speed DMA
 controller bindings
In-Reply-To: <cover.1494830885.git.sean.wang@mediatek.com>
References: <cover.1494830885.git.sean.wang@mediatek.com>
Message-ID: <07cc981fbf9620459d1ac63e8720eaa2dd110048.1494830885.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Document the devicetree bindings for Mediatek High-Speed DMA controller
which could be found on MT7623 SoC or other similar Mediatek SoCs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/dma/mtk-hsdma.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt

diff --git a/Documentation/devicetree/bindings/dma/mtk-hsdma.txt b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
new file mode 100644
index 0000000..62cdda4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mtk-hsdma.txt
@@ -0,0 +1,30 @@
+Mediatek High-Speed DMA Controller
+==================================
+
+This driver follows the generic DMA bindings defined in dma/dma.txt.
+
+Required properties:
+
+- compatible:	Must be one of
+		  "mediatek,mt7623-hsdma".
+- reg:		Should contain the register's base address and length.
+- interrupts:	Should contain a reference to the interrupt used by this
+		device.
+- clocks:	Should be the clock specifiers corresponding to the entry in
+		clock-names property.
+- clock-names:	Should contain "hsdma" entries.
+- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
+		in dmas property of a client device represents the channel
+		number.
+Example:
+
+        hsdma: hsdma at 1b007000 {
+		compatible = "mediatek,mt7623-hsdma";
+		reg = <0 0x1b007000 0 0x1000>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ethsys CLK_ETHSYS_HSDMA>;
+		clock-names = "hsdma";
+		status = "okay";
+	};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
2.7.4
