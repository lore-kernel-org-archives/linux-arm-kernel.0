From: leilk.liu@mediatek.com (Leilk Liu)
Date: Wed, 29 Jul 2015 19:04:32 +0800
Subject: [PATCH v4 1/3] dt-binding: spi: Mediatek: Document devicetree
 bindings for spi bus
In-Reply-To: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
new file mode 100644
index 0000000..f8005d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -0,0 +1,38 @@
+MTK SPI device
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt6589-spi: for mt6589 platforms
+
+- #address-cells: should be 1.
+
+- #size-cells: should be 0.
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clocks: phandles to input clocks.
+
+- clock-names: tuple listing input clock names.
+	Required elements: "main"
+
+- pad-select: should specify spi pad used, only required for MT8173.
+        This value should be 0~3.
+
+Example:
+
+- SoC Specific Portion:
+spi: spi at 1100a000 {
+	compatible = "mediatek,mt8173-spi";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0 0x1100a000 0 0x1000>;
+	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&pericfg CLK_PERI_SPI0>;
+	clock-names = "main";
+	pad-select = <0>;
+	status = "disabled";
+};
-- 
1.8.1.1.dirty
