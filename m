From: leilk.liu@mediatek.com (leilk.liu at mediatek.com)
Date: Fri, 8 May 2015 16:55:41 +0800
Subject: [PATCH 1/3] dt-bindings: ARM: Mediatek: Document devicetree bindings
 for spi bus
In-Reply-To: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1431075343-7887-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilk Liu <leilk.liu@mediatek.com>

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
new file mode 100644
index 0000000..04c28fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -0,0 +1,32 @@
+MTK SPI device
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt6589-spi: for mt6589 platforms
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clock-names: tuple listing input clock names.
+	Required elements: "main"
+
+- clocks: phandles to input clocks.
+
+- pad-select: should specify spi pad used, only required for MT8173.
+	This value should be 0~3.
+
+Example:
+
+- SoC Specific Portion:
+spi: spi at 1100a000 {
+	compatible = "mediatek,mt8173-spi";
+	reg = <0 0x1100a000 0 0x1000>;
+	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&pericfg PERI_SPI0>;
+	clock-names = "main";
+	pad-select = <1>;
+	status = "disabled";
+};
-- 
1.8.1.1.dirty
