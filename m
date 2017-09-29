From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:29 +0200
Subject: [PATCH 37/48] ARM: dts: r8a7792: Add reset control properties
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <6e11a322f1d7505d3a1db4ae26c6c0e46082f4ae.1506683482.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add properties to describe the reset topology for on-SoC devices:
  - Add the "#reset-cells" property to the CPG/MSSR device node,
  - Add resets and reset-names properties to the various device nodes.

This allows to reset SoC devices using the Reset Controller API.

Note that resets usually match the corresponding module clocks.
Exceptions are:
  - The audio module has resets for the Serial Sound Interfaces only,
    but audio is not yet enabled in r8a7792.dtsi,
  - The display module has only a single reset for all DU channels, but
    adding reset properties for the display is postponed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7792.dtsi | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index a209787d899a..c332f77ebb6b 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -95,6 +95,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		irqc: interrupt-controller at e61c0000 {
@@ -108,6 +109,7 @@
 				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
 		};
 
 		timer {
@@ -155,6 +157,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio at e6051000 {
@@ -169,6 +172,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio at e6052000 {
@@ -183,6 +187,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio at e6053000 {
@@ -197,6 +202,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio at e6054000 {
@@ -211,6 +217,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio at e6055000 {
@@ -225,6 +232,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio at e6055100 {
@@ -239,6 +247,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		gpio7: gpio at e6055200 {
@@ -253,6 +262,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 904>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 904>;
 		};
 
 		gpio8: gpio at e6055300 {
@@ -267,6 +277,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 921>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 921>;
 		};
 
 		gpio9: gpio at e6055400 {
@@ -281,6 +292,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
 		};
 
 		gpio10: gpio at e6055500 {
@@ -295,6 +307,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 914>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
 		};
 
 		gpio11: gpio at e6055600 {
@@ -309,6 +322,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 913>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 913>;
 		};
 
 		dmac0: dma-controller at e6700000 {
@@ -339,6 +353,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
@@ -371,6 +386,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <15>;
 		};
@@ -387,6 +403,7 @@
 			       <&dmac1 0x29>, <&dmac1 0x2a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 721>;
 			status = "disabled";
 		};
 
@@ -402,6 +419,7 @@
 			       <&dmac1 0x2d>, <&dmac1 0x2e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 720>;
 			status = "disabled";
 		};
 
@@ -417,6 +435,7 @@
 			       <&dmac1 0x2b>, <&dmac1 0x2c>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 719>;
 			status = "disabled";
 		};
 
@@ -432,6 +451,7 @@
 			       <&dmac1 0x2f>, <&dmac1 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 718>;
 			status = "disabled";
 		};
 
@@ -447,6 +467,7 @@
 			       <&dmac1 0x39>, <&dmac1 0x3a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 717>;
 			status = "disabled";
 		};
 
@@ -462,6 +483,7 @@
 			       <&dmac1 0x4d>, <&dmac1 0x4e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 716>;
 			status = "disabled";
 		};
 
@@ -492,6 +514,7 @@
 			dma-names = "tx", "rx", "tx", "rx";
 			clocks = <&cpg CPG_MOD 314>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
 			status = "disabled";
 		};
 
@@ -502,6 +525,7 @@
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 106>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 106>;
 		};
 
 		avb: ethernet at e6800000 {
@@ -511,6 +535,7 @@
 			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -524,6 +549,7 @@
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -537,6 +563,7 @@
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -550,6 +577,7 @@
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -563,6 +591,7 @@
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -576,6 +605,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
 			i2c-scl-internal-delay-ns = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -589,6 +619,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 925>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 925>;
 			i2c-scl-internal-delay-ns = <110>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -604,6 +635,7 @@
 			       <&dmac1 0x17>, <&dmac1 0x18>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -620,6 +652,7 @@
 			       <&dmac1 0x51>, <&dmac1 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -635,6 +668,7 @@
 			       <&dmac1 0x55>, <&dmac1 0x56>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -677,6 +711,7 @@
 				 <&cpg CPG_CORE R8A7792_CLK_RCAN>, <&can_clk>;
 			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
@@ -689,6 +724,7 @@
 				 <&cpg CPG_CORE R8A7792_CLK_RCAN>, <&can_clk>;
 			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
@@ -699,6 +735,7 @@
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 811>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 811>;
 			status = "disabled";
 		};
 
@@ -709,6 +746,7 @@
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 810>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 810>;
 			status = "disabled";
 		};
 
@@ -719,6 +757,7 @@
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 809>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 809>;
 			status = "disabled";
 		};
 
@@ -729,6 +768,7 @@
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 808>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 808>;
 			status = "disabled";
 		};
 
@@ -739,6 +779,7 @@
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 805>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 805>;
 			status = "disabled";
 		};
 
@@ -749,6 +790,7 @@
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 804>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 804>;
 			status = "disabled";
 		};
 
@@ -758,6 +800,7 @@
 			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 131>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 131>;
 		};
 
 		vsp1 at fe930000 {
@@ -766,6 +809,7 @@
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 128>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 128>;
 		};
 
 		vsp1 at fe938000 {
@@ -774,6 +818,7 @@
 			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 127>;
 			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 127>;
 		};
 
 		cpg: clock-controller at e6150000 {
-- 
2.1.4
