From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Sun, 17 Sep 2017 05:19:55 +0200
Subject: [PATCH v2 09/10] arm64: allwinner: a64: Add device node for DMA
 controller
In-Reply-To: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170917031956.28010-10-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC has a DMA controller that supports 8 DMA channels
to and from various peripherals. The last used DRQ port is 27.

Add a device node for it.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e9a9d7fb01c8..4f060ecdb061 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -136,6 +136,17 @@
 			reg = <0x01c00000 0x1000>;
 		};
 
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun50i-a64-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			dma-channels = <8>;
+			dma-requests = <27>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		mmc0: mmc at 1c0f000 {
 			compatible = "allwinner,sun50i-a64-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.14.1
