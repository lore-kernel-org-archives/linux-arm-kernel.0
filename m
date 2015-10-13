From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Tue, 13 Oct 2015 17:39:18 +0800
Subject: [PATCH v4 1/3] doc: dt: add documentation for Mediatek spi-nor
 controller
In-Reply-To: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
References: <1444729160-26433-1-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <1444729160-26433-2-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for serial flash with
Mediatek serial flash controller

Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
---
 .../devicetree/bindings/mtd/mtk-quadspi.txt        | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk-quadspi.txt

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
new file mode 100644
index 0000000..8fff0ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
@@ -0,0 +1,30 @@
+* MTD SPI nor driver for MTK MT81xx (and similar) serial flash controller
+
+Required properties:
+- compatible: 	  should be "mediatek,mt8173-nor";
+- reg: 		  physical base address and length of the controller's register
+- clocks: 	  the phandle of the clock needed by the nor controller
+- clock-names: 	  the name of the clocks
+		  the clocks needed "spi" and "sf". "spi" is used for spi bus,
+		  and "sf" is used for controller, these are the clocks witch
+		  hardware needs to enabling nor flash and nor flash controller.
+		  See Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+- #address-cells: should be <1>
+- #size-cells:	  should be <0>
+
+Example:
+
+nor_flash: spi at 1100d000 {
+	compatible = "mediatek,mt8173-nor";
+	reg = <0 0x1100d000 0 0xe0>;
+	clocks = <&pericfg CLK_PERI_SPI>,
+		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+	clock-names = "spi", "sf";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	flash at 0 {
+		....
+	};
+};
+
-- 
1.8.1.1.dirty
