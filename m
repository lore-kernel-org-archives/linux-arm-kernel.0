From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 27 Apr 2016 14:20:15 +1000
Subject: [PATCH 2/2] arm64: dts: r8a7795: Use SYSC "always-on" PM Domain
In-Reply-To: <cover.1461730364.git.horms+renesas@verge.net.au>
References: <cover.1461730364.git.horms+renesas@verge.net.au>
Message-ID: <38dbb45ee4bc7dda4aabba2178eebff2f93380d1.1461730364.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Hook up all devices that are part of the CPG/MSSR Clock Domain to the
SYSC "always-on" PM Domain, for a more consistent device-power-area
description in DT.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 110 +++++++++++++++----------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f96d0732b2a8..3285a9286786 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -175,7 +175,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio1: gpio at e6051000 {
@@ -189,7 +189,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio2: gpio at e6052000 {
@@ -203,7 +203,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio3: gpio at e6053000 {
@@ -217,7 +217,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio4: gpio at e6054000 {
@@ -231,7 +231,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio5: gpio at e6055000 {
@@ -245,7 +245,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio6: gpio at e6055400 {
@@ -259,7 +259,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		gpio7: gpio at e6055800 {
@@ -273,7 +273,7 @@
 			#interrupt-cells = <2>;
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		pmu_a57 {
@@ -342,7 +342,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 502>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -374,7 +374,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 501>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -396,7 +396,7 @@
 				      GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 		};
 
 		dmac0: dma-controller at e6700000 {
@@ -427,7 +427,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -460,7 +460,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -493,7 +493,7 @@
 					"ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -535,7 +535,7 @@
 					  "ch20", "ch21", "ch22", "ch23",
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -552,7 +552,7 @@
 			clock-names = "clkp1", "clkp2", "can_clk";
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -567,7 +567,7 @@
 			clock-names = "clkp1", "clkp2", "can_clk";
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -583,7 +583,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -599,7 +599,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -615,7 +615,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -631,7 +631,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -647,7 +647,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -662,7 +662,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -677,7 +677,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -692,7 +692,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -707,7 +707,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -722,7 +722,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -737,7 +737,7 @@
 			clock-names = "fck", "brg_int", "scif_clk";
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
 			dma-names = "tx", "rx";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -748,7 +748,7 @@
 			reg = <0 0xe6500000 0 0x40>;
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -760,7 +760,7 @@
 			reg = <0 0xe6508000 0 0x40>;
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -772,7 +772,7 @@
 			reg = <0 0xe6510000 0 0x40>;
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -784,7 +784,7 @@
 			reg = <0 0xe66d0000 0 0x40>;
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -796,7 +796,7 @@
 			reg = <0 0xe66d8000 0 0x40>;
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -808,7 +808,7 @@
 			reg = <0 0xe66e0000 0 0x40>;
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -820,7 +820,7 @@
 			reg = <0 0xe66e8000 0 0x40>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -870,7 +870,7 @@
 				      "src.1", "src.0",
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 
 			rcar_sound,dvc {
@@ -1004,7 +1004,7 @@
 			reg = <0 0xee000000 0 0xc00>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1013,7 +1013,7 @@
 			reg = <0 0xee040000 0 0xc00>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 327>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1025,7 +1025,7 @@
 				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1038,7 +1038,7 @@
 				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1048,7 +1048,7 @@
 			reg = <0 0xee100000 0 0x2000>;
 			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 314>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1057,7 +1057,7 @@
 			reg = <0 0xee120000 0 0x2000>;
 			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 313>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1066,7 +1066,7 @@
 			reg = <0 0xee140000 0 0x2000>;
 			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 312>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			cap-mmc-highspeed;
 			status = "disabled";
 		};
@@ -1076,7 +1076,7 @@
 			reg = <0 0xee160000 0 0x2000>;
 			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 311>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			cap-mmc-highspeed;
 			status = "disabled";
 		};
@@ -1086,7 +1086,7 @@
 			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1095,7 +1095,7 @@
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 702>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1104,7 +1104,7 @@
 			compatible = "renesas,usb2-phy-r8a7795";
 			reg = <0 0xee0c0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 701>;
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1116,7 +1116,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1127,7 +1127,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1138,7 +1138,7 @@
 			clocks = <&cpg CPG_MOD 701>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1149,7 +1149,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1160,7 +1160,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1171,7 +1171,7 @@
 			clocks = <&cpg CPG_MOD 701>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 		pciec0: pcie at fe000000 {
@@ -1195,7 +1195,7 @@
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 
@@ -1220,7 +1220,7 @@
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
-			power-domains = <&cpg>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			status = "disabled";
 		};
 	};
-- 
2.7.0.rc3.207.g0ac5344
