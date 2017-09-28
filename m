From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 28 Sep 2017 03:49:26 +0200
Subject: [PATCH v4 09/11] arm64: allwinner: a64: Add device node for DMA
 controller
In-Reply-To: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
Message-ID: <0f84fde8-d9df-4186-9a6e-f5ca4045c276@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SoC has a DMA controller that supports 8 DMA channels
to and from various peripherals. The last used DRQ port is 27.

Add a device node for it.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>

---

Changes in v4: None
Changes in v3:
- Drop leading 0 from dma controller unit name

Changes in v2: None

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e9a9d7fb01c8..cbffefce0e71 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -136,6 +136,17 @@
 			reg = <0x01c00000 0x1000>;
 		};
 
+		dma: dma-controller at 1c02000 {
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
