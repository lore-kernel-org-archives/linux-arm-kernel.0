From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:16 +0100
Subject: [PATCH 14/16] ARM: dts: r8a77470: Add QSPI support
In-Reply-To: <cover.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <d4798031b876fb22e35c4a86b586b0493d7dc1e1.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add QSPI[01] support to the RZ/G1C SoC specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 5c0e48d0449a..f4e232bf9d03 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -460,6 +460,38 @@
 			status = "disabled";
 		};
 
+		qspi0: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a77470", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 918>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&cpg 918>;
+			status = "disabled";
+		};
+
+		qspi1: spi at ee200000 {
+			compatible = "renesas,qspi-r8a77470", "renesas,qspi";
+			reg = <0 0xee200000 0 0x2c>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			resets = <&cpg 917>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77470",
 				     "renesas,rcar-gen2-scif", "renesas,scif";
-- 
2.11.0
