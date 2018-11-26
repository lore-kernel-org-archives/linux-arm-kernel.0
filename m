From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:31 +0100
Subject: [PATCH 05/40] arm64: dts: renesas: r8a77990: Add DMA properties to
 MSIOF nodes
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <8517042060b55a37c1b7d3cbb04e131bfe61c13a.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

This patch adds DMA properties to the MSIOF device nodes of R8A77990 SoC.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 7278cd52891d..6d5efeb9f363 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -700,6 +700,9 @@
 			reg = <0 0xe6e90000 0 0x0064>;
 			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 211>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
+			       <&dmac2 0x41>, <&dmac2 0x40>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 211>;
 			#address-cells = <1>;
@@ -713,6 +716,9 @@
 			reg = <0 0xe6ea0000 0 0x0064>;
 			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 210>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
+			       <&dmac2 0x43>, <&dmac2 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 210>;
 			#address-cells = <1>;
@@ -726,6 +732,8 @@
 			reg = <0 0xe6c00000 0 0x0064>;
 			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 209>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 209>;
 			#address-cells = <1>;
@@ -739,6 +747,8 @@
 			reg = <0 0xe6c10000 0 0x0064>;
 			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
 			resets = <&cpg 208>;
 			#address-cells = <1>;
-- 
2.11.0
