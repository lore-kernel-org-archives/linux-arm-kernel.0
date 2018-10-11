From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 12 Oct 2018 01:41:02 +0900
Subject: [PATCH v4 1/2] dt-bindings: dmaengine: add DT binding for UniPhier
 MIO DMAC
In-Reply-To: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1539276063-5103-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIO DMAC (Media IO DMA Controller) is used in UniPhier LD4,
Pro4, and sLD8 SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4: None
Changes in v3:
 - Add Rob's Reviewed-by

Changes in v2:
 - Rename the node "dmac" to "dma-controller"
 - Remove dma-channels property

 .../devicetree/bindings/dma/uniphier-mio-dmac.txt  | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
new file mode 100644
index 0000000..b12388d
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
@@ -0,0 +1,25 @@
+UniPhier Media IO DMA controller
+
+This works as an external DMA engine for SD/eMMC controllers etc.
+found in UniPhier LD4, Pro4, sLD8 SoCs.
+
+Required properties:
+- compatible: should be "socionext,uniphier-mio-dmac".
+- reg: offset and length of the register set for the device.
+- interrupts: a list of interrupt specifiers associated with the DMA channels.
+- clocks: a single clock specifier.
+- #dma-cells: should be <1>. The single cell represents the channel index.
+
+Example:
+	dmac: dma-controller at 5a000000 {
+		compatible = "socionext,uniphier-mio-dmac";
+		reg = <0x5a000000 0x1000>;
+		interrupts = <0 68 4>, <0 68 4>, <0 69 4>, <0 70 4>,
+			     <0 71 4>, <0 72 4>, <0 73 4>, <0 74 4>;
+		clocks = <&mio_clk 7>;
+		#dma-cells = <1>;
+	};
+
+Note:
+In the example above, "interrupts = <0 68 4>, <0 68 4>, ..." is not a typo.
+The first two channels share a single interrupt line.
-- 
2.7.4
