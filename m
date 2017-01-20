From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:24 +0100
Subject: [PATCH 6/8] arm64: dts: r8a7796: Add reset control properties
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties to describe the reset topology for on-SoC devices:
  - Add the "#reset-cells" property to the CPG/MSSR device node,
  - Add resets and reset-names properties to the various device nodes.

This allows to reset SoC devices using the Reset Controller API.

Note that all resets added match the corresponding module clocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 6591c76613687b40..e3286106a038e936 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -104,6 +104,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		timer {
@@ -124,6 +125,7 @@
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
 			status = "disabled";
 		};
 
@@ -139,6 +141,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio at e6051000 {
@@ -153,6 +156,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio at e6052000 {
@@ -167,6 +171,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio at e6053000 {
@@ -181,6 +186,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio at e6054000 {
@@ -195,6 +201,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio at e6055000 {
@@ -209,6 +216,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio at e6055400 {
@@ -223,6 +231,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
 		gpio7: gpio at e6055800 {
@@ -237,6 +246,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		pfc: pin-controller at e6060000 {
@@ -251,6 +261,7 @@
 			clock-names = "extal", "extalr";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
 		rst: reset-controller at e6160000 {
@@ -278,6 +289,7 @@
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
 			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
 			       <&dmac2 0x91>, <&dmac2 0x90>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -294,6 +306,7 @@
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
 			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
 			       <&dmac2 0x93>, <&dmac2 0x92>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -310,6 +323,7 @@
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
 			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
 			       <&dmac2 0x95>, <&dmac2 0x94>;
 			dma-names = "tx", "rx", "tx", "rx";
@@ -326,6 +340,7 @@
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
 			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -341,6 +356,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
 			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -356,6 +372,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
 			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -371,6 +388,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 918>;
 			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
@@ -389,6 +407,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
@@ -404,6 +423,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
@@ -420,6 +440,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
 			status = "disabled";
 
 			channel0 {
@@ -469,6 +490,7 @@
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -484,6 +506,7 @@
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
 			status = "disabled";
 		};
 
@@ -497,6 +520,7 @@
 			       <&dmac2 0x41>, <&dmac2 0x40>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 211>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -512,6 +536,7 @@
 			       <&dmac2 0x43>, <&dmac2 0x42>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 210>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -526,6 +551,7 @@
 			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 209>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -540,6 +566,7 @@
 			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -574,6 +601,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -607,6 +635,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -640,6 +669,7 @@
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -651,6 +681,7 @@
 			clocks = <&cpg CPG_MOD 314>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
 			status = "disabled";
 		};
 
@@ -661,6 +692,7 @@
 			clocks = <&cpg CPG_MOD 313>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
 			status = "disabled";
 		};
 
@@ -671,6 +703,7 @@
 			clocks = <&cpg CPG_MOD 312>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
 			status = "disabled";
 		};
 
@@ -681,6 +714,7 @@
 			clocks = <&cpg CPG_MOD 311>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
 			status = "disabled";
 		};
 	};
-- 
1.9.1
