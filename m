From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:27 +0200
Subject: [PATCH 35/48] ARM: dts: r8a7790: Add reset control properties
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <34fbd2b12761d11166414ca766637c7e6bbb39d7.1506683482.git.horms+renesas@verge.net.au>
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
  - The display module has only a single reset for all DU channels, but
    adding reset properties for the display is postponed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 76 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 70040c6c4cea..081cf5cdb13b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -188,6 +188,7 @@
 		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 408>;
 	};
 
 	gpio0: gpio at e6050000 {
@@ -201,6 +202,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 912>;
 	};
 
 	gpio1: gpio at e6051000 {
@@ -214,6 +216,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 911>;
 	};
 
 	gpio2: gpio at e6052000 {
@@ -227,6 +230,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 910>;
 	};
 
 	gpio3: gpio at e6053000 {
@@ -240,6 +244,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 909>;
 	};
 
 	gpio4: gpio at e6054000 {
@@ -253,6 +258,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 908>;
 	};
 
 	gpio5: gpio at e6055000 {
@@ -266,6 +272,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 907>;
 	};
 
 	thermal: thermal at e61f0000 {
@@ -276,6 +283,7 @@
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 522>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -295,6 +303,7 @@
 		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 124>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -315,6 +324,7 @@
 		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 329>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -332,6 +342,7 @@
 			     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 407>;
 	};
 
 	dmac0: dma-controller at e6700000 {
@@ -361,6 +372,7 @@
 		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 219>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -392,6 +404,7 @@
 		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 218>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -421,6 +434,7 @@
 		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 502>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -450,6 +464,7 @@
 		clocks = <&cpg CPG_MOD 501>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 501>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -462,6 +477,7 @@
 		interrupt-names = "ch0", "ch1";
 		clocks = <&cpg CPG_MOD 330>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 330>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -474,6 +490,7 @@
 		interrupt-names = "ch0", "ch1";
 		clocks = <&cpg CPG_MOD 331>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 331>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -486,6 +503,7 @@
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 931>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -498,6 +516,7 @@
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 930>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -510,6 +529,7 @@
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 929>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -522,6 +542,7 @@
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 928>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -538,6 +559,7 @@
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 318>;
 		status = "disabled";
 	};
 
@@ -553,6 +575,7 @@
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 323>;
 		status = "disabled";
 	};
 
@@ -568,6 +591,7 @@
 		       <&dmac1 0x69>, <&dmac1 0x6a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 300>;
 		status = "disabled";
 	};
 
@@ -583,6 +607,7 @@
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 926>;
 		status = "disabled";
 	};
 
@@ -595,6 +620,7 @@
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 315>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -609,6 +635,7 @@
 		       <&dmac1 0xe1>, <&dmac1 0xe2>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 305>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -629,6 +656,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 314>;
 		status = "disabled";
 	};
 
@@ -642,6 +670,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 313>;
 		status = "disabled";
 	};
 
@@ -655,6 +684,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 312>;
 		status = "disabled";
 	};
 
@@ -668,6 +698,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 311>;
 		status = "disabled";
 	};
 
@@ -682,6 +713,7 @@
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 204>;
 		status = "disabled";
 	};
 
@@ -696,6 +728,7 @@
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 203>;
 		status = "disabled";
 	};
 
@@ -710,6 +743,7 @@
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 202>;
 		status = "disabled";
 	};
 
@@ -724,6 +758,7 @@
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 206>;
 		status = "disabled";
 	};
 
@@ -738,6 +773,7 @@
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 207>;
 		status = "disabled";
 	};
 
@@ -752,6 +788,7 @@
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 216>;
 		status = "disabled";
 	};
 
@@ -767,6 +804,7 @@
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 721>;
 		status = "disabled";
 	};
 
@@ -782,6 +820,7 @@
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 720>;
 		status = "disabled";
 	};
 
@@ -797,6 +836,7 @@
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 310>;
 		status = "disabled";
 	};
 
@@ -812,6 +852,7 @@
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 717>;
 		status = "disabled";
 	};
 
@@ -827,6 +868,7 @@
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 716>;
 		status = "disabled";
 	};
 
@@ -854,6 +896,7 @@
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 813>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -867,6 +910,7 @@
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 812>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 812>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -878,6 +922,7 @@
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 815>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 815>;
 		status = "disabled";
 	};
 
@@ -887,6 +932,7 @@
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 814>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 814>;
 		status = "disabled";
 	};
 
@@ -899,6 +945,7 @@
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 704>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -914,6 +961,7 @@
 		clocks = <&cpg CPG_MOD 704>;
 		clock-names = "usbhs";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 704>;
 		status = "disabled";
 
 		usb0: usb-channel at 0 {
@@ -932,6 +980,7 @@
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 811>;
 		status = "disabled";
 	};
 
@@ -941,6 +990,7 @@
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 810>;
 		status = "disabled";
 	};
 
@@ -950,6 +1000,7 @@
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 809>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 809>;
 		status = "disabled";
 	};
 
@@ -959,6 +1010,7 @@
 		interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 808>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 808>;
 		status = "disabled";
 	};
 
@@ -968,6 +1020,7 @@
 		interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 130>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 130>;
 	};
 
 	vsp1 at fe928000 {
@@ -976,6 +1029,7 @@
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 131>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 131>;
 	};
 
 	vsp1 at fe930000 {
@@ -984,6 +1038,7 @@
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 128>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 128>;
 	};
 
 	vsp1 at fe938000 {
@@ -992,6 +1047,7 @@
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 127>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 127>;
 	};
 
 	du: display at feb00000 {
@@ -1039,6 +1095,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 916>;
 		status = "disabled";
 	};
 
@@ -1050,6 +1107,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 915>;
 		status = "disabled";
 	};
 
@@ -1059,6 +1117,7 @@
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 106>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 106>;
 	};
 
 	/* External root clock */
@@ -1154,6 +1213,7 @@
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1170,6 +1230,7 @@
 		       <&dmac1 0x51>, <&dmac1 0x52>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1185,6 +1246,7 @@
 		       <&dmac1 0x55>, <&dmac1 0x56>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 208>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1200,6 +1262,7 @@
 		       <&dmac1 0x41>, <&dmac1 0x42>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 205>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1215,6 +1278,7 @@
 		       <&dmac1 0x45>, <&dmac1 0x46>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 215>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1226,6 +1290,7 @@
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 328>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 328>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1239,6 +1304,7 @@
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1272,6 +1338,7 @@
 		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1290,6 +1357,7 @@
 		device_type = "pci";
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		reg = <0 0xee0d0000 0 0xc00>,
 		      <0 0xee0c0000 0 0x1100>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
@@ -1341,6 +1409,7 @@
 		clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 319>;
 		status = "disabled";
 	};
 
@@ -1385,6 +1454,13 @@
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+		resets = <&cpg 1005>,
+			 <&cpg 1006>, <&cpg 1007>, <&cpg 1008>, <&cpg 1009>,
+			 <&cpg 1010>, <&cpg 1011>, <&cpg 1012>, <&cpg 1013>,
+			 <&cpg 1014>, <&cpg 1015>;
+		reset-names = "ssi-all",
+			      "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
+			      "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0";
 
 		status = "disabled";
 
-- 
2.1.4
