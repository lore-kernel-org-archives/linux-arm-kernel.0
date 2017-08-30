From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 31 Aug 2017 01:36:08 +0200
Subject: [PATCH 2/3] arm64: allwinner: a64: Add device node for DMA controller
In-Reply-To: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170830233609.13855-3-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC has a DMA controller that supports 8 DMA channels
to and from various peripherals.

Add a device node for it.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 Documentation/devicetree/bindings/dma/sun6i-dma.txt | 1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi       | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 6b267045f522..4398b990250c 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -9,6 +9,7 @@ Required properties:
 		  "allwinner,sun8i-a23-dma"
 		  "allwinner,sun8i-a83t-dma"
 		  "allwinner,sun8i-h3-dma"
+		  "allwinner,sun50i-a64-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 7be9eb2ad83c..f96287d3043a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -136,6 +136,15 @@
 			reg = <0x01c00000 0x1000>;
 		};
 
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun50i-a64-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun50i-a64-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.14.1
