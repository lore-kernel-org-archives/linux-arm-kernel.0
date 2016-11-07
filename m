From: hao5781286@gmail.com (Hao Zhang)
Date: Tue, 8 Nov 2016 02:22:47 +0800
Subject: [PATCH v3 2/3] ARM64: dts: sun6i: add dma node for a64.
Message-ID: <20161107182247.GA3669@arx12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the dma node for sun50i a64.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e3c3d7d8..855ae2c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -227,6 +227,15 @@
 			};
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
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.7.4
