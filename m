From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:54 +0100
Subject: [PATCH 28/40] arm64: dts: renesas: r8a774a1: Replace power magic
 numbers
In-Reply-To: <cover.1543229515.git.horms+renesas@verge.net.au>
References: <cover.1543229515.git.horms+renesas@verge.net.au>
Message-ID: <aeee3d9cb776542f5700425f703fa78c70a1dcd0.1543229515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Now that include/dt-bindings/power/r8a774a1-sysc.h is in Linus'
master branch we can replace power related magic numbers with
the corresponding labels.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 201 +++++++++++++++---------------
 1 file changed, 101 insertions(+), 100 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 78ac8e3cda6e..d549755a4025 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
+#include <dt-bindings/power/r8a774a1-sysc.h>
 
 / {
 	compatible = "renesas,r8a774a1";
@@ -63,7 +64,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x0>;
 			device_type = "cpu";
-			power-domains = <&sysc 0>;
+			power-domains = <&sysc R8A774A1_PD_CA57_CPU0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE 0>;
@@ -73,7 +74,7 @@
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
-			power-domains = <&sysc 1>;
+			power-domains = <&sysc R8A774A1_PD_CA57_CPU1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
 			clocks = <&cpg CPG_CORE 0>;
@@ -83,7 +84,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x100>;
 			device_type = "cpu";
-			power-domains = <&sysc 5>;
+			power-domains = <&sysc R8A774A1_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE 1>;
@@ -93,7 +94,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x101>;
 			device_type = "cpu";
-			power-domains = <&sysc 6>;
+			power-domains = <&sysc R8A774A1_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE 1>;
@@ -103,7 +104,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x102>;
 			device_type = "cpu";
-			power-domains = <&sysc 7>;
+			power-domains = <&sysc R8A774A1_PD_CA53_CPU2>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE 1>;
@@ -113,7 +114,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x103>;
 			device_type = "cpu";
-			power-domains = <&sysc 8>;
+			power-domains = <&sysc R8A774A1_PD_CA53_CPU3>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
 			clocks =<&cpg CPG_CORE 1>;
@@ -121,14 +122,14 @@
 
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
-			power-domains = <&sysc 12>;
+			power-domains = <&sysc R8A774A1_PD_CA57_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
 
 		L2_CA53: cache-controller-1 {
 			compatible = "cache";
-			power-domains = <&sysc 21>;
+			power-domains = <&sysc R8A774A1_PD_CA53_SCU>;
 			cache-unified;
 			cache-level = <2>;
 		};
@@ -195,7 +196,7 @@
 				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 402>;
 			status = "disabled";
 		};
@@ -211,7 +212,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 912>;
 		};
 
@@ -226,7 +227,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 911>;
 		};
 
@@ -241,7 +242,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 910>;
 		};
 
@@ -256,7 +257,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 909>;
 		};
 
@@ -271,7 +272,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 908>;
 		};
 
@@ -286,7 +287,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 907>;
 		};
 
@@ -301,7 +302,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 906>;
 		};
 
@@ -316,7 +317,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 905>;
 		};
 
@@ -355,7 +356,7 @@
 				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 522>;
 			#thermal-sensor-cells = <1>;
 		};
@@ -372,7 +373,7 @@
 				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 407>;
 		};
 
@@ -384,7 +385,7 @@
 			reg = <0 0xe6500000 0 0x40>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 931>;
 			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
 			       <&dmac2 0x91>, <&dmac2 0x90>;
@@ -401,7 +402,7 @@
 			reg = <0 0xe6508000 0 0x40>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 930>;
 			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
 			       <&dmac2 0x93>, <&dmac2 0x92>;
@@ -418,7 +419,7 @@
 			reg = <0 0xe6510000 0 0x40>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 929>;
 			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
 			       <&dmac2 0x95>, <&dmac2 0x94>;
@@ -435,7 +436,7 @@
 			reg = <0 0xe66d0000 0 0x40>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 928>;
 			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
 			dma-names = "tx", "rx";
@@ -451,7 +452,7 @@
 			reg = <0 0xe66d8000 0 0x40>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 927>;
 			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
 			dma-names = "tx", "rx";
@@ -467,7 +468,7 @@
 			reg = <0 0xe66e0000 0 0x40>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 919>;
 			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
 			dma-names = "tx", "rx";
@@ -483,7 +484,7 @@
 			reg = <0 0xe66e8000 0 0x40>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 918>;
 			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
 			dma-names = "tx", "rx";
@@ -500,7 +501,7 @@
 			reg = <0 0xe60b0000 0 0x425>;
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 926>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 926>;
 			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
 			dma-names = "tx", "rx";
@@ -520,7 +521,7 @@
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>,
 			       <&dmac2 0x31>, <&dmac2 0x30>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 520>;
 			status = "disabled";
 		};
@@ -538,7 +539,7 @@
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>,
 			       <&dmac2 0x33>, <&dmac2 0x32>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 519>;
 			status = "disabled";
 		};
@@ -556,7 +557,7 @@
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>,
 			       <&dmac2 0x35>, <&dmac2 0x34>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 518>;
 			status = "disabled";
 		};
@@ -573,7 +574,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 517>;
 			status = "disabled";
 		};
@@ -590,7 +591,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 516>;
 			status = "disabled";
 		};
@@ -607,7 +608,7 @@
 			renesas,buswait = <11>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 704>;
 			status = "disabled";
 		};
@@ -620,7 +621,7 @@
 				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 330>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
@@ -634,7 +635,7 @@
 				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 331>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
@@ -647,7 +648,7 @@
 			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
 				 <&usb_extal_clk>;
 			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 328>;
 			#phy-cells = <0>;
 			status = "disabled";
@@ -681,7 +682,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -715,7 +716,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -749,7 +750,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -759,7 +760,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xe6740000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 0>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -767,7 +768,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xe7740000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 1>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -775,7 +776,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xe6570000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 2>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -784,7 +785,7 @@
 			reg = <0 0xe67b0000 0 0x1000>;
 			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -792,7 +793,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xec670000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 4>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -800,7 +801,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xfd800000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 5>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -808,7 +809,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xfd950000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 6>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -816,7 +817,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xfe6b0000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 8>;
-			power-domains = <&sysc 14>;
+			power-domains = <&sysc R8A774A1_PD_A3VC>;
 			#iommu-cells = <1>;
 		};
 
@@ -824,7 +825,7 @@
 			compatible = "renesas,ipmmu-r8a774a1";
 			reg = <0 0xfebd0000 0 0x1000>;
 			renesas,ipmmu-main = <&ipmmu_mm 9>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			#iommu-cells = <1>;
 		};
 
@@ -865,7 +866,7 @@
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 812>;
 			phy-mode = "rgmii";
 			#address-cells = <1>;
@@ -880,7 +881,7 @@
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
 			clock-names = "clkp1", "can_clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 916>;
 			status = "disabled";
 		};
@@ -892,7 +893,7 @@
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
 			clock-names = "clkp1", "can_clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 915>;
 			status = "disabled";
 		};
@@ -903,7 +904,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -913,7 +914,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -923,7 +924,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -933,7 +934,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -943,7 +944,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -953,7 +954,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -963,7 +964,7 @@
 			#pwm-cells = <2>;
 			clocks = <&cpg CPG_MOD 523>;
 			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -979,7 +980,7 @@
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
 			       <&dmac2 0x51>, <&dmac2 0x50>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 207>;
 			status = "disabled";
 		};
@@ -996,7 +997,7 @@
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
 			       <&dmac2 0x53>, <&dmac2 0x52>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 206>;
 			status = "disabled";
 		};
@@ -1010,7 +1011,7 @@
 				 <&cpg CPG_CORE 19>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 310>;
 			status = "disabled";
 		};
@@ -1026,7 +1027,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 204>;
 			status = "disabled";
 		};
@@ -1042,7 +1043,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 203>;
 			status = "disabled";
 		};
@@ -1059,7 +1060,7 @@
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
 			       <&dmac2 0x5b>, <&dmac2 0x5a>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 202>;
 			status = "disabled";
 		};
@@ -1073,7 +1074,7 @@
 			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
 			       <&dmac2 0x41>, <&dmac2 0x40>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 211>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1089,7 +1090,7 @@
 			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
 			       <&dmac2 0x43>, <&dmac2 0x42>;
 			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 210>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1104,7 +1105,7 @@
 			clocks = <&cpg CPG_MOD 209>;
 			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 209>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1119,7 +1120,7 @@
 			clocks = <&cpg CPG_MOD 208>;
 			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
 			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1131,7 +1132,7 @@
 			reg = <0 0xe6ef0000 0 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 811>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 811>;
 			renesas,id = <0>;
 			status = "disabled";
@@ -1163,7 +1164,7 @@
 			reg = <0 0xe6ef1000 0 0x1000>;
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 810>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 810>;
 			renesas,id = <1>;
 			status = "disabled";
@@ -1195,7 +1196,7 @@
 			reg = <0 0xe6ef2000 0 0x1000>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 809>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 809>;
 			renesas,id = <2>;
 			status = "disabled";
@@ -1227,7 +1228,7 @@
 			reg = <0 0xe6ef3000 0 0x1000>;
 			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 808>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 808>;
 			renesas,id = <3>;
 			status = "disabled";
@@ -1259,7 +1260,7 @@
 			reg = <0 0xe6ef4000 0 0x1000>;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 807>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 807>;
 			renesas,id = <4>;
 			status = "disabled";
@@ -1291,7 +1292,7 @@
 			reg = <0 0xe6ef5000 0 0x1000>;
 			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 806>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 806>;
 			renesas,id = <5>;
 			status = "disabled";
@@ -1323,7 +1324,7 @@
 			reg = <0 0xe6ef6000 0 0x1000>;
 			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 805>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 805>;
 			renesas,id = <6>;
 			status = "disabled";
@@ -1355,7 +1356,7 @@
 			reg = <0 0xe6ef7000 0 0x1000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 804>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 804>;
 			renesas,id = <7>;
 			status = "disabled";
@@ -1431,7 +1432,7 @@
 				      "ctu.1", "ctu.0",
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 1005>,
 				 <&cpg 1006>, <&cpg 1007>,
 				 <&cpg 1008>, <&cpg 1009>,
@@ -1617,7 +1618,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 502>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -1651,7 +1652,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 501>;
 			clock-names = "fck";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 501>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
@@ -1663,7 +1664,7 @@
 			reg = <0 0xee000000 0 0xc00>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 328>;
 			status = "disabled";
 		};
@@ -1674,7 +1675,7 @@
 			reg = <0 0xee020000 0 0x400>;
 			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 328>;
 			status = "disabled";
 		};
@@ -1686,7 +1687,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
 		};
@@ -1698,7 +1699,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			status = "disabled";
 		};
@@ -1711,7 +1712,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			companion = <&ohci0>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
 		};
@@ -1724,7 +1725,7 @@
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			companion = <&ohci1>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			status = "disabled";
 		};
@@ -1735,7 +1736,7 @@
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			#phy-cells = <0>;
 			status = "disabled";
@@ -1746,7 +1747,7 @@
 				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 702>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
 			#phy-cells = <0>;
 			status = "disabled";
@@ -1759,7 +1760,7 @@
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
 			max-frequency = <200000000>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 314>;
 			status = "disabled";
 		};
@@ -1771,7 +1772,7 @@
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 313>;
 			max-frequency = <200000000>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 313>;
 			status = "disabled";
 		};
@@ -1783,7 +1784,7 @@
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
 			max-frequency = <200000000>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 312>;
 			status = "disabled";
 		};
@@ -1795,7 +1796,7 @@
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
 			max-frequency = <200000000>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 311>;
 			status = "disabled";
 		};
@@ -1813,7 +1814,7 @@
 					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 408>;
 		};
 
@@ -1821,7 +1822,7 @@
 			compatible = "renesas,fcpf";
 			reg = <0 0xfe950000 0 0x200>;
 			clocks = <&cpg CPG_MOD 615>;
-			power-domains = <&sysc 14>;
+			power-domains = <&sysc R8A774A1_PD_A3VC>;
 			resets = <&cpg 615>;
 		};
 
@@ -1829,7 +1830,7 @@
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 607>;
-			power-domains = <&sysc 14>;
+			power-domains = <&sysc R8A774A1_PD_A3VC>;
 			resets = <&cpg 607>;
 		};
 
@@ -1837,7 +1838,7 @@
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea27000 0 0x200>;
 			clocks = <&cpg CPG_MOD 603>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 603>;
 			iommus = <&ipmmu_vi0 8>;
 		};
@@ -1846,7 +1847,7 @@
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 602>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 602>;
 			iommus = <&ipmmu_vi0 9>;
 		};
@@ -1855,7 +1856,7 @@
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea37000 0 0x200>;
 			clocks = <&cpg CPG_MOD 601>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 601>;
 			iommus = <&ipmmu_vi0 10>;
 		};
@@ -1864,7 +1865,7 @@
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe9af000 0 0x200>;
 			clocks = <&cpg CPG_MOD 611>;
-			power-domains = <&sysc 14>;
+			power-domains = <&sysc R8A774A1_PD_A3VC>;
 			resets = <&cpg 611>;
 			iommus = <&ipmmu_vc0 19>;
 		};
@@ -1874,7 +1875,7 @@
 			reg = <0 0xfea80000 0 0x10000>;
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 714>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 714>;
 			status = "disabled";
 
@@ -1929,7 +1930,7 @@
 			reg = <0 0xfeaa0000 0 0x10000>;
 			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 716>;
-			power-domains = <&sysc 32>;
+			power-domains = <&sysc R8A774A1_PD_ALWAYS_ON>;
 			resets = <&cpg 716>;
 			status = "disabled";
 
-- 
2.11.0
