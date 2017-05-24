From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 18:06:06 +0800
Subject: [PATCH v3 8/9] ARM: dts: sun8i: add audio codec support into V3s DTSI
In-Reply-To: <20170524100607.29790-1-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
Message-ID: <20170524100607.29790-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Allwinner V3s SoC features an internal audio codec like the one in H3,
and a analog codec like the one in H3/A23 (but much simpler).

Add them in the DTSI file.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v3:
- Added Chen-Yu's ACK.

 arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index e0e99bbebdb3..01751ea0761e 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -271,6 +271,25 @@
 			status = "disabled";
 		};
 
+		codec: codec at 01c22c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-v3s-codec";
+			reg = <0x01c22c00 0x400>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;
+			clock-names = "apb", "codec";
+			resets = <&ccu RST_BUS_CODEC>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "rx", "tx";
+			allwinner,codec-analog-controls = <&codec_analog>;
+			status = "disabled";
+		};
+
+		codec_analog: codec-analog at 01c23000 {
+			compatible = "allwinner,sun8i-v3s-codec-analog";
+			reg = <0x01c23000 0x4>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.12.2
