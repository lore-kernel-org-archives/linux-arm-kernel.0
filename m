From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  5 Mar 2017 21:37:06 +0800
Subject: [PATCH v2 09/12] ARM: dts: sun8i: add DMA engine in V3s DTSI
In-Reply-To: <20170305133709.6288-1-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
Message-ID: <20170305133709.6288-10-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features a DMA engine.

Add it in the DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index b3f8b7f9c0bb..7e0342976ba8 100644
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
2.11.1
