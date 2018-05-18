From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:29 +0200
Subject: [PATCH 067/102] arm64: dts: renesas: r8a77965: use r8a77965-sysc
 binding definitions
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <7e26520fb466ddbecf7d0c1eea44126c1a353a19.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Replace the hardcoded power domain indices by R8A77965_PD_* symbols.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
[simon: dropped hunk to include r8a77965-sysc.h which is already present]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 94 +++++++++++++++----------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 7c9555309c0a..536fed8eec6a 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -61,7 +61,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
-			power-domains = <&sysc 0>;
+			power-domains = <&sysc R8A77965_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
@@ -70,14 +70,14 @@
 			compatible = "arm,cortex-a57","arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
-			power-domains = <&sysc 1>;
+			power-domains = <&sysc R8A77965_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 		};
 
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			power-domains = <&sysc 12>;
+			power-domains = <&sysc R8A77965_PD_CA57_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -147,7 +147,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 912>;
 		};
 
@@ -162,7 +162,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 911>;
 		};
 
@@ -177,7 +177,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 910>;
 		};
 
@@ -192,7 +192,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 909>;
 		};
 
@@ -207,7 +207,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 908>;
 		};
 
@@ -222,7 +222,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 907>;
 		};
 
@@ -237,7 +237,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 906>;
 		};
 
@@ -252,7 +252,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 905>;
 		};
 
@@ -294,7 +294,7 @@
 				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 407>;
 		};
 
@@ -348,7 +348,7 @@
 			reg = <0 0xe60b0000 0 0x425>;
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 926>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 926>;
 			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
 			dma-names = "tx", "rx";
@@ -367,7 +367,7 @@
 			renesas,buswait = <11>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 704>;
 			status = "disabled";
 		};
@@ -380,7 +380,7 @@
 				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 330>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
@@ -394,7 +394,7 @@
 				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 331>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
@@ -407,7 +407,7 @@
 			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
 				 <&usb_extal_clk>;
 			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 328>;
 			#phy-cells = <0>;
 			status = "disabled";
@@ -441,7 +441,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -475,7 +475,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -509,7 +509,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -552,7 +552,7 @@
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii";
 			#address-cells = <1>;
@@ -566,7 +566,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -576,7 +576,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -586,7 +586,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -596,7 +596,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -606,7 +606,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -616,7 +616,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -626,7 +626,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -642,7 +642,7 @@
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
 			       <&dmac2 0x51>, <&dmac2 0x50>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 207>;
 			status = "disabled";
 		};
@@ -659,7 +659,7 @@
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
 			       <&dmac2 0x53>, <&dmac2 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 206>;
 			status = "disabled";
 		};
@@ -673,7 +673,7 @@
 				 <&cpg CPG_CORE 20>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
 		};
@@ -689,7 +689,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 204>;
 			status = "disabled";
 		};
@@ -705,7 +705,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 203>;
 			status = "disabled";
 		};
@@ -722,7 +722,7 @@
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
 			       <&dmac2 0x5b>, <&dmac2 0x5a>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 202>;
 			status = "disabled";
 		};
@@ -736,7 +736,7 @@
 			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
 			       <&dmac2 0x41>, <&dmac2 0x40>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 211>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -752,7 +752,7 @@
 			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
 			       <&dmac2 0x43>, <&dmac2 0x42>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 210>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -767,7 +767,7 @@
 			clocks = <&cpg CPG_MOD 209>;
 			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 209>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -782,7 +782,7 @@
 			clocks = <&cpg CPG_MOD 208>;
 			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -873,7 +873,7 @@
 			reg = <0 0xee000000 0 0xc00>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 328>;
 			status = "disabled";
 		};
@@ -884,7 +884,7 @@
 			reg = <0 0xee020000 0 0x400>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 328>;
 			status = "disabled";
 		};
@@ -896,7 +896,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
 		};
@@ -908,7 +908,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			status = "disabled";
 		};
@@ -921,7 +921,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
 		};
@@ -934,7 +934,7 @@
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			companion = <&ohci1>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			status = "disabled";
 		};
@@ -945,7 +945,7 @@
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			#phy-cells = <0>;
 			status = "disabled";
@@ -956,7 +956,7 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			#phy-cells = <0>;
 			status = "disabled";
@@ -995,7 +995,7 @@
 					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
 			resets = <&cpg 408>;
 		};
 
-- 
2.11.0
