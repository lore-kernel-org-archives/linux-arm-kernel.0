From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Jan 2017 15:08:23 +0100
Subject: [PATCH 5/8] arm64: dts: r8a7795: Add reset control properties
In-Reply-To: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1484921306-9967-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add properties to describe the reset topology for on-SoC devices:
  - Add the "#reset-cells" property to the CPG/MSSR device node,
  - Add resets and reset-names properties to the various device nodes.

This allows to reset SoC devices using the Reset Controller API.

Note that resets usually match the corresponding module clocks.
Exceptions are:
  - The audio module has resets for the Serial Sound Interfaces only,
  - The DU has only 2 resets, one per channel pair.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0627df2a0b810c86..cdb67944c34166bd 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -169,6 +169,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		wdt0: watchdog at e6020000 {
@@ -176,6 +177,7 @@
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
 			status = "disabled";
 		};
 
@@ -191,6 +193,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio at e6051000 {
@@ -205,6 +208,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio at e6052000 {
@@ -219,6 +223,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio at e6053000 {
@@ -233,6 +238,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio at e6054000 {
@@ -247,6 +253,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio at e6055000 {
@@ -261,6 +268,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio at e6055400 {
@@ -275,6 +283,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
 		gpio7: gpio at e6055800 {
@@ -289,6 +298,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		pmu_a57 {
@@ -322,6 +332,7 @@
 			clock-names = "extal", "extalr";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
 		rst: reset-controller at e6160000 {
@@ -369,6 +380,7 @@
 			clocks = <&cpg CPG_MOD 502>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -402,6 +414,7 @@
 			clocks = <&cpg CPG_MOD 501>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 501>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -424,6 +437,7 @@
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
 		};
 
 		dmac0: dma-controller at e6700000 {
@@ -455,6 +469,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -488,6 +503,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -521,6 +537,7 @@
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -563,6 +580,7 @@
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
 			phy-mode = "rgmii-id";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -580,6 +598,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
@@ -595,6 +614,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
@@ -611,6 +631,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
 			status = "disabled";
 
 			channel0 {
@@ -635,6 +656,7 @@
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 520>;
 			status = "disabled";
 		};
 
@@ -651,6 +673,7 @@
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 519>;
 			status = "disabled";
 		};
 
@@ -667,6 +690,7 @@
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 518>;
 			status = "disabled";
 		};
 
@@ -683,6 +707,7 @@
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 517>;
 			status = "disabled";
 		};
 
@@ -699,6 +724,7 @@
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 516>;
 			status = "disabled";
 		};
 
@@ -714,6 +740,7 @@
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
 			status = "disabled";
 		};
 
@@ -729,6 +756,7 @@
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
 			status = "disabled";
 		};
 
@@ -744,6 +772,7 @@
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
 			status = "disabled";
 		};
 
@@ -759,6 +788,7 @@
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
@@ -774,6 +804,7 @@
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
@@ -789,6 +820,7 @@
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
@@ -803,6 +835,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac1 0x91>, <&dmac1 0x90>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 931>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -818,6 +851,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac1 0x93>, <&dmac1 0x92>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 930>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -833,6 +867,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac1 0x95>, <&dmac1 0x94>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 929>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -848,6 +883,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 928>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -863,6 +899,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 927>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -878,6 +915,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 919>;
 			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
@@ -893,6 +931,7 @@
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
 			dma-names = "tx", "rx";
+			resets = <&cpg 918>;
 			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
@@ -902,6 +941,7 @@
 			reg = <0 0xe6e30000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -911,6 +951,7 @@
 			reg = <0 0xe6e31000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -920,6 +961,7 @@
 			reg = <0 0xe6e32000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -929,6 +971,7 @@
 			reg = <0 0xe6e33000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -938,6 +981,7 @@
 			reg = <0 0xe6e34000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -947,6 +991,7 @@
 			reg = <0 0xe6e35000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -956,6 +1001,7 @@
 			reg = <0 0xe6e36000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -1010,6 +1056,16 @@
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>,
+				 <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>,
+				 <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0";
 			status = "disabled";
 
 			rcar_sound,dvc {
@@ -1152,6 +1208,7 @@
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 815>;
 			status = "disabled";
 		};
 
@@ -1161,6 +1218,7 @@
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
 			status = "disabled";
 		};
 
@@ -1170,6 +1228,7 @@
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 327>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 327>;
 			status = "disabled";
 		};
 
@@ -1182,6 +1241,7 @@
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 330>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1195,6 +1255,7 @@
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 331>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1206,6 +1267,7 @@
 			clocks = <&cpg CPG_MOD 314>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
 			status = "disabled";
 		};
 
@@ -1216,6 +1278,7 @@
 			clocks = <&cpg CPG_MOD 313>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
 			status = "disabled";
 		};
 
@@ -1226,6 +1289,7 @@
 			clocks = <&cpg CPG_MOD 312>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
 			status = "disabled";
 		};
 
@@ -1236,6 +1300,7 @@
 			clocks = <&cpg CPG_MOD 311>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
 			status = "disabled";
 		};
 
@@ -1246,6 +1311,7 @@
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1256,6 +1322,7 @@
 			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 702>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1266,6 +1333,7 @@
 			reg = <0 0xee0c0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 701>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 701>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1278,6 +1346,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1289,6 +1358,7 @@
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
 		};
 
@@ -1300,6 +1370,7 @@
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 701>;
 			status = "disabled";
 		};
 
@@ -1311,6 +1382,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1322,6 +1394,7 @@
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
 		};
 
@@ -1333,6 +1406,7 @@
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 701>;
 			status = "disabled";
 		};
 
@@ -1349,6 +1423,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1375,6 +1450,7 @@
 			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
 			status = "disabled";
 		};
 
@@ -1401,6 +1477,7 @@
 			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
 			status = "disabled";
 		};
 
@@ -1410,6 +1487,7 @@
 			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 624>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 624>;
 
 			renesas,fcp = <&fcpvb1>;
 		};
@@ -1419,6 +1497,7 @@
 			reg = <0 0xfe92f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 606>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 606>;
 		};
 
 		fcpf0: fcp at fe950000 {
@@ -1426,6 +1505,7 @@
 			reg = <0 0xfe950000 0 0x200>;
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 615>;
 		};
 
 		fcpf1: fcp at fe951000 {
@@ -1433,6 +1513,7 @@
 			reg = <0 0xfe951000 0 0x200>;
 			clocks = <&cpg CPG_MOD 614>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 614>;
 		};
 
 		fcpf2: fcp at fe952000 {
@@ -1440,6 +1521,7 @@
 			reg = <0 0xfe952000 0 0x200>;
 			clocks = <&cpg CPG_MOD 613>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 613>;
 		};
 
 		vspbd: vsp at fe960000 {
@@ -1448,6 +1530,7 @@
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 626>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 626>;
 
 			renesas,fcp = <&fcpvb0>;
 		};
@@ -1457,6 +1540,7 @@
 			reg = <0 0xfe96f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 607>;
 		};
 
 		vspi0: vsp at fe9a0000 {
@@ -1465,6 +1549,7 @@
 			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 631>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 631>;
 
 			renesas,fcp = <&fcpvi0>;
 		};
@@ -1474,6 +1559,7 @@
 			reg = <0 0xfe9af000 0 0x200>;
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 611>;
 		};
 
 		vspi1: vsp at fe9b0000 {
@@ -1482,6 +1568,7 @@
 			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 630>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 630>;
 
 			renesas,fcp = <&fcpvi1>;
 		};
@@ -1491,6 +1578,7 @@
 			reg = <0 0xfe9bf000 0 0x200>;
 			clocks = <&cpg CPG_MOD 610>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 610>;
 		};
 
 		vspi2: vsp at fe9c0000 {
@@ -1499,6 +1587,7 @@
 			interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 629>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 629>;
 
 			renesas,fcp = <&fcpvi2>;
 		};
@@ -1508,6 +1597,7 @@
 			reg = <0 0xfe9cf000 0 0x200>;
 			clocks = <&cpg CPG_MOD 609>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 609>;
 		};
 
 		vspd0: vsp at fea20000 {
@@ -1516,6 +1606,7 @@
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
 
 			renesas,fcp = <&fcpvd0>;
 		};
@@ -1525,6 +1616,7 @@
 			reg = <0 0xfea27000 0 0x200>;
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
 		};
 
 		vspd1: vsp at fea28000 {
@@ -1533,6 +1625,7 @@
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 622>;
 
 			renesas,fcp = <&fcpvd1>;
 		};
@@ -1542,6 +1635,7 @@
 			reg = <0 0xfea2f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 602>;
 		};
 
 		vspd2: vsp at fea30000 {
@@ -1550,6 +1644,7 @@
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 621>;
 
 			renesas,fcp = <&fcpvd2>;
 		};
@@ -1559,6 +1654,7 @@
 			reg = <0 0xfea37000 0 0x200>;
 			clocks = <&cpg CPG_MOD 601>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 601>;
 		};
 
 		vspd3: vsp at fea38000 {
@@ -1567,6 +1663,7 @@
 			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 620>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 620>;
 
 			renesas,fcp = <&fcpvd3>;
 		};
@@ -1576,6 +1673,7 @@
 			reg = <0 0xfea3f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 600>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 600>;
 		};
 
 		fdp1 at fe940000 {
@@ -1584,6 +1682,7 @@
 			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 119>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 119>;
 			renesas,fcp = <&fcpf0>;
 		};
 
@@ -1593,6 +1692,7 @@
 			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 118>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 118>;
 			renesas,fcp = <&fcpf1>;
 		};
 
@@ -1602,6 +1702,7 @@
 			interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 117>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 117>;
 			renesas,fcp = <&fcpf2>;
 		};
 
@@ -1620,6 +1721,8 @@
 				 <&cpg CPG_MOD 721>,
 				 <&cpg CPG_MOD 727>;
 			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
+			resets = <&cpg 724>, <&cpg 722>, <&cpg 727>;
+			reset-names = "du.0-1", "du.2-3", "lvds.0";
 			status = "disabled";
 
 			vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
-- 
1.9.1
