From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 16 Mar 2017 15:07:24 +0100
Subject: [PATCH v2 2/4] arm64: dts: r8a7796: Add reset control properties
In-Reply-To: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
References: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1489673246-11015-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties to describe the reset topology for on-SoC devices:
  - Add the "#reset-cells" property to the CPG/MSSR device node,
  - Add resets and reset-names properties to the various device nodes.

This allows to reset SoC devices using the Reset Controller API.

Note that all resets added match the corresponding module clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add reset properties to recently added device nodes (i2c_dvfs,
    hscif[0-4], scif[01345], tsc).
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index a90abf14dc4e7c79..2ec1ed5f499165ad 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -155,6 +155,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		timer {
@@ -175,6 +176,7 @@
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
 			status = "disabled";
 		};
 
@@ -190,6 +192,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio at e6051000 {
@@ -204,6 +207,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio at e6052000 {
@@ -218,6 +222,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio at e6053000 {
@@ -232,6 +237,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio at e6054000 {
@@ -246,6 +252,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio at e6055000 {
@@ -260,6 +267,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio at e6055400 {
@@ -274,6 +282,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
 		gpio7: gpio at e6055800 {
@@ -288,6 +297,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		pfc: pin-controller at e6060000 {
@@ -322,6 +332,7 @@
 			clock-names = "extal", "extalr";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
 		rst: reset-controller at e6160000 {
@@ -350,6 +361,7 @@
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 926>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 926>;
 			status = "disabled";
 		};
 
@@ -362,6 +374,7 @@
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
 			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
 			       <&dmac2 0x91>, <&dmac2 0x90>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -378,6 +391,7 @@
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
 			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
 			       <&dmac2 0x93>, <&dmac2 0x92>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -394,6 +408,7 @@
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
 			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
 			       <&dmac2 0x95>, <&dmac2 0x94>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -410,6 +425,7 @@
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
 			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -425,6 +441,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
 			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -440,6 +457,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
 			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -455,6 +473,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 918>;
 			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
@@ -473,6 +492,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
@@ -488,6 +508,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
@@ -504,6 +525,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
 			status = "disabled";
 
 			channel0 {
@@ -553,6 +575,7 @@
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
 			phy-mode = "rgmii-txid";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -573,6 +596,7 @@
 			       <&dmac2 0x31>, <&dmac2 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 520>;
 			status = "disabled";
 		};
 
@@ -590,6 +614,7 @@
 			       <&dmac2 0x33>, <&dmac2 0x32>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 519>;
 			status = "disabled";
 		};
 
@@ -607,6 +632,7 @@
 			       <&dmac2 0x35>, <&dmac2 0x34>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 518>;
 			status = "disabled";
 		};
 
@@ -623,6 +649,7 @@
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 517>;
 			status = "disabled";
 		};
 
@@ -639,6 +666,7 @@
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 516>;
 			status = "disabled";
 		};
 
@@ -655,6 +683,7 @@
 			       <&dmac2 0x51>, <&dmac2 0x50>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
 			status = "disabled";
 		};
 
@@ -671,6 +700,7 @@
 			       <&dmac2 0x53>, <&dmac2 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
 			status = "disabled";
 		};
 
@@ -684,6 +714,7 @@
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
 			status = "disabled";
 		};
 
@@ -699,6 +730,7 @@
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
@@ -714,6 +746,7 @@
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
@@ -730,6 +763,7 @@
 			       <&dmac2 0x5b>, <&dmac2 0x5a>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
@@ -743,6 +777,7 @@
 			       <&dmac2 0x41>, <&dmac2 0x40>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 211>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -758,6 +793,7 @@
 			       <&dmac2 0x43>, <&dmac2 0x42>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 210>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -772,6 +808,7 @@
 			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 209>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -786,6 +823,7 @@
 			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -820,6 +858,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -853,6 +892,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -886,6 +926,7 @@
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -897,6 +938,7 @@
 			clocks = <&cpg CPG_MOD 314>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
 			status = "disabled";
 		};
 
@@ -907,6 +949,7 @@
 			clocks = <&cpg CPG_MOD 313>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
 			status = "disabled";
 		};
 
@@ -917,6 +960,7 @@
 			clocks = <&cpg CPG_MOD 312>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
 			status = "disabled";
 		};
 
@@ -927,6 +971,7 @@
 			clocks = <&cpg CPG_MOD 311>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
 			status = "disabled";
 		};
 
@@ -940,6 +985,7 @@
 				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
 			#thermal-sensor-cells = <1>;
 			status = "okay";
 		};
-- 
2.7.4
