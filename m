From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 16 Mar 2017 15:07:23 +0100
Subject: [PATCH v2 1/4] arm64: dts: r8a7795: Add reset control properties
In-Reply-To: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
References: <1489673246-11015-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1489673246-11015-2-git-send-email-geert+renesas@glider.be>
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
  - Postpone adding resets and reset-names properties for complex
    devices (du, rcar_sound),
  - Add reset properties to recently added device nodes (i2c_dvfs,
    tsc).
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 93 ++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 55c09f1b89c94785..63598c237c187364 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -204,6 +204,7 @@
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		wdt0: watchdog at e6020000 {
@@ -211,6 +212,7 @@
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
 			status = "disabled";
 		};
 
@@ -226,6 +228,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 912>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio at e6051000 {
@@ -240,6 +243,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 911>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio at e6052000 {
@@ -254,6 +258,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 910>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio at e6053000 {
@@ -268,6 +273,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 909>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio at e6054000 {
@@ -282,6 +288,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 908>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio at e6055000 {
@@ -296,6 +303,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 907>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio at e6055400 {
@@ -310,6 +318,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 906>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
 		gpio7: gpio at e6055800 {
@@ -324,6 +333,7 @@
 			interrupt-controller;
 			clocks = <&cpg CPG_MOD 905>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		pmu_a57 {
@@ -369,6 +379,7 @@
 			clock-names = "extal", "extalr";
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
+			#reset-cells = <1>;
 		};
 
 		rst: reset-controller at e6160000 {
@@ -405,6 +416,7 @@
 				      GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 407>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
 		};
 
 		dmac0: dma-controller at e6700000 {
@@ -436,6 +448,7 @@
 			clocks = <&cpg CPG_MOD 219>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 219>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -469,6 +482,7 @@
 			clocks = <&cpg CPG_MOD 218>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 218>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -502,6 +516,7 @@
 			clocks = <&cpg CPG_MOD 217>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 217>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -535,6 +550,7 @@
 			clocks = <&cpg CPG_MOD 502>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 502>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -568,6 +584,7 @@
 			clocks = <&cpg CPG_MOD 501>;
 			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 501>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
@@ -610,6 +627,7 @@
 					  "ch24";
 			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
 			phy-mode = "rgmii-txid";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -628,6 +646,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
@@ -643,6 +662,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
@@ -659,6 +679,7 @@
 			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
 			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
 			status = "disabled";
 
 			channel0 {
@@ -683,6 +704,7 @@
 			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 520>;
 			status = "disabled";
 		};
 
@@ -699,6 +721,7 @@
 			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 519>;
 			status = "disabled";
 		};
 
@@ -715,6 +738,7 @@
 			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 518>;
 			status = "disabled";
 		};
 
@@ -731,6 +755,7 @@
 			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 517>;
 			status = "disabled";
 		};
 
@@ -747,6 +772,7 @@
 			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 516>;
 			status = "disabled";
 		};
 
@@ -762,6 +788,7 @@
 			dmas = <&dmac1 0x51>, <&dmac1 0x50>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
 			status = "disabled";
 		};
 
@@ -777,6 +804,7 @@
 			dmas = <&dmac1 0x53>, <&dmac1 0x52>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
 			status = "disabled";
 		};
 
@@ -792,6 +820,7 @@
 			dmas = <&dmac1 0x13>, <&dmac1 0x12>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
 			status = "disabled";
 		};
 
@@ -807,6 +836,7 @@
 			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
@@ -822,6 +852,7 @@
 			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
@@ -837,6 +868,7 @@
 			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>;
 			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
@@ -850,6 +882,7 @@
 			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 926>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 926>;
 			status = "disabled";
 		};
 
@@ -862,6 +895,7 @@
 			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
 			dmas = <&dmac1 0x91>, <&dmac1 0x90>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -877,6 +911,7 @@
 			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
 			dmas = <&dmac1 0x93>, <&dmac1 0x92>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
@@ -892,6 +927,7 @@
 			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 929>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
 			dmas = <&dmac1 0x95>, <&dmac1 0x94>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
@@ -907,6 +943,7 @@
 			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 928>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
 			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -922,6 +959,7 @@
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 927>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
 			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -937,6 +975,7 @@
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 919>;
 			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <110>;
@@ -952,6 +991,7 @@
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 918>;
 			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
 			dma-names = "tx", "rx";
 			i2c-scl-internal-delay-ns = <6>;
@@ -963,6 +1003,7 @@
 			reg = <0 0xe6e30000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -972,6 +1013,7 @@
 			reg = <0 0xe6e31000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -981,6 +1023,7 @@
 			reg = <0 0xe6e32000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -990,6 +1033,7 @@
 			reg = <0 0xe6e33000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -999,6 +1043,7 @@
 			reg = <0 0xe6e34000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -1008,6 +1053,7 @@
 			reg = <0 0xe6e35000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -1017,6 +1063,7 @@
 			reg = <0 0xe6e36000 0 0x8>;
 			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 523>;
 			#pwm-cells = <2>;
 			status = "disabled";
 		};
@@ -1213,6 +1260,7 @@
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 815>;
 			status = "disabled";
 		};
 
@@ -1222,6 +1270,7 @@
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 328>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
 			status = "disabled";
 		};
 
@@ -1231,6 +1280,7 @@
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 327>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 327>;
 			status = "disabled";
 		};
 
@@ -1243,6 +1293,7 @@
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 330>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1256,6 +1307,7 @@
 			interrupt-names = "ch0", "ch1";
 			clocks = <&cpg CPG_MOD 331>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
 			#dma-cells = <1>;
 			dma-channels = <2>;
 		};
@@ -1267,6 +1319,7 @@
 			clocks = <&cpg CPG_MOD 314>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
 			status = "disabled";
 		};
 
@@ -1277,6 +1330,7 @@
 			clocks = <&cpg CPG_MOD 313>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
 			status = "disabled";
 		};
 
@@ -1287,6 +1341,7 @@
 			clocks = <&cpg CPG_MOD 312>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
 			status = "disabled";
 		};
 
@@ -1297,6 +1352,7 @@
 			clocks = <&cpg CPG_MOD 311>;
 			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
 			status = "disabled";
 		};
 
@@ -1307,6 +1363,7 @@
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1317,6 +1374,7 @@
 			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 702>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1327,6 +1385,7 @@
 			reg = <0 0xee0c0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 701>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 701>;
 			#phy-cells = <0>;
 			status = "disabled";
 		};
@@ -1339,6 +1398,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1350,6 +1410,7 @@
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
 		};
 
@@ -1361,6 +1422,7 @@
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 701>;
 			status = "disabled";
 		};
 
@@ -1372,6 +1434,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
 			status = "disabled";
 		};
 
@@ -1383,6 +1446,7 @@
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
 		};
 
@@ -1394,6 +1458,7 @@
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 701>;
 			status = "disabled";
 		};
 
@@ -1410,6 +1475,7 @@
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 704>;
 			status = "disabled";
 		};
 
@@ -1436,6 +1502,7 @@
 			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
 			status = "disabled";
 		};
 
@@ -1462,6 +1529,7 @@
 			clocks = <&cpg CPG_MOD 318>, <&pcie_bus_clk>;
 			clock-names = "pcie", "pcie_bus";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 318>;
 			status = "disabled";
 		};
 
@@ -1471,6 +1539,7 @@
 			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 624>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 624>;
 
 			renesas,fcp = <&fcpvb1>;
 		};
@@ -1480,6 +1549,7 @@
 			reg = <0 0xfe92f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 606>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 606>;
 		};
 
 		fcpf0: fcp at fe950000 {
@@ -1487,6 +1557,7 @@
 			reg = <0 0xfe950000 0 0x200>;
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 615>;
 		};
 
 		fcpf1: fcp at fe951000 {
@@ -1494,6 +1565,7 @@
 			reg = <0 0xfe951000 0 0x200>;
 			clocks = <&cpg CPG_MOD 614>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 614>;
 		};
 
 		fcpf2: fcp at fe952000 {
@@ -1501,6 +1573,7 @@
 			reg = <0 0xfe952000 0 0x200>;
 			clocks = <&cpg CPG_MOD 613>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 613>;
 		};
 
 		vspbd: vsp at fe960000 {
@@ -1509,6 +1582,7 @@
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 626>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 626>;
 
 			renesas,fcp = <&fcpvb0>;
 		};
@@ -1518,6 +1592,7 @@
 			reg = <0 0xfe96f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 607>;
 		};
 
 		vspi0: vsp at fe9a0000 {
@@ -1526,6 +1601,7 @@
 			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 631>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 631>;
 
 			renesas,fcp = <&fcpvi0>;
 		};
@@ -1535,6 +1611,7 @@
 			reg = <0 0xfe9af000 0 0x200>;
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 611>;
 		};
 
 		vspi1: vsp at fe9b0000 {
@@ -1543,6 +1620,7 @@
 			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 630>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 630>;
 
 			renesas,fcp = <&fcpvi1>;
 		};
@@ -1552,6 +1630,7 @@
 			reg = <0 0xfe9bf000 0 0x200>;
 			clocks = <&cpg CPG_MOD 610>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 610>;
 		};
 
 		vspi2: vsp at fe9c0000 {
@@ -1560,6 +1639,7 @@
 			interrupts = <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 629>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 629>;
 
 			renesas,fcp = <&fcpvi2>;
 		};
@@ -1569,6 +1649,7 @@
 			reg = <0 0xfe9cf000 0 0x200>;
 			clocks = <&cpg CPG_MOD 609>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 609>;
 		};
 
 		vspd0: vsp at fea20000 {
@@ -1577,6 +1658,7 @@
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 623>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 623>;
 
 			renesas,fcp = <&fcpvd0>;
 		};
@@ -1586,6 +1668,7 @@
 			reg = <0 0xfea27000 0 0x200>;
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
 		};
 
 		vspd1: vsp at fea28000 {
@@ -1594,6 +1677,7 @@
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 622>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 622>;
 
 			renesas,fcp = <&fcpvd1>;
 		};
@@ -1603,6 +1687,7 @@
 			reg = <0 0xfea2f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 602>;
 		};
 
 		vspd2: vsp at fea30000 {
@@ -1611,6 +1696,7 @@
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 621>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 621>;
 
 			renesas,fcp = <&fcpvd2>;
 		};
@@ -1620,6 +1706,7 @@
 			reg = <0 0xfea37000 0 0x200>;
 			clocks = <&cpg CPG_MOD 601>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 601>;
 		};
 
 		vspd3: vsp at fea38000 {
@@ -1628,6 +1715,7 @@
 			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 620>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 620>;
 
 			renesas,fcp = <&fcpvd3>;
 		};
@@ -1637,6 +1725,7 @@
 			reg = <0 0xfea3f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 600>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 600>;
 		};
 
 		fdp1 at fe940000 {
@@ -1645,6 +1734,7 @@
 			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 119>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 119>;
 			renesas,fcp = <&fcpf0>;
 		};
 
@@ -1654,6 +1744,7 @@
 			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 118>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 118>;
 			renesas,fcp = <&fcpf1>;
 		};
 
@@ -1663,6 +1754,7 @@
 			interrupts = <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 117>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 117>;
 			renesas,fcp = <&fcpf2>;
 		};
 
@@ -1722,6 +1814,7 @@
 				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 522>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
 			#thermal-sensor-cells = <1>;
 			status = "okay";
 		};
-- 
2.7.4
