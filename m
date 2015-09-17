From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Thu, 17 Sep 2015 16:36:32 +0800
Subject: [PATCH 1/3] doc: dt: add documentation for Mediatek spi-nor controller
Message-ID: <1442478994-12467-1-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for serial flash with
Mediatek serial flash controller

Change-Id: Iaecd0bb7ba1b224f1e27bd7063f0b8d7ea30175a
Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
---
 Documentation/devicetree/bindings/mtd/mtk_quadspi.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk_quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/mtk_quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk_quadspi.txt
new file mode 100644
index 0000000..6153227
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtk_quadspi.txt
@@ -0,0 +1,18 @@
+* MTD SPI nor driver for MTK MT81xx (and similar) serial flash controller
+
+Required properties:
+- compatible: Should be "mediatek,mt8173-nor";
+- reg: Physical base address and length of the controller's register
+- clocks: spi source clock amd serial flash controller's clock
+- clock-names: "spi", "sf"
+  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+
+Example:
+nor_flash: nor at 1100d000 {
+	compatible = "mediatek,mt8173-nor";
+	reg = <0 0x1100D000 0 0xE0>;
+	clocks = <&pericfg CLK_PERI_SPI>,
+			 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+	clock-names = "spi", "sf";
+};
+
-- 
1.8.1.1.dirty
