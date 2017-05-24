From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 18:06:05 +0800
Subject: [PATCH v3 7/9] ARM: dts: sun8i: add DMA engine in V3s DTSI
In-Reply-To: <20170524100607.29790-1-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
Message-ID: <20170524100607.29790-8-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Allwinner V3s SoC features a DMA engine.

Add it in the DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v3:
- Added Chen-Yu's ACK.

 arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index a49ebef53c91..e0e99bbebdb3 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -95,6 +95,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		dma: dma-controller at 01c02000 {
+			compatible = "allwinner,sun8i-v3s-dma";
+			reg = <0x01c02000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
-- 
2.12.2
