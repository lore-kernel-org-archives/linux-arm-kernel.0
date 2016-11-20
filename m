From: hao5781286@gmail.com (Hao Zhang)
Date: Sun, 20 Nov 2016 18:45:39 +0800
Subject: [PATCH v4 2/3] ARM64: dts: sun6i: add dma node for a64.
In-Reply-To: <1479638740-20520-1-git-send-email-hao5781286@gmail.com>
References: <1479638740-20520-1-git-send-email-hao5781286@gmail.com>
Message-ID: <1479638740-20520-3-git-send-email-hao5781286@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Accroding to the Allwinner_A64_User_Manual_V1.0 P198
the DMA base address is 0x01c02000.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index e3c3d7d8..403bbfa 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -122,6 +122,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		dma: dma-controller at 1c02000 {
+			compatible = "allwinner,sun50i-a64-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		ccu: clock at 01c20000 {
 			compatible = "allwinner,sun50i-a64-ccu";
 			reg = <0x01c20000 0x400>;
-- 
2.7.4
