From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:28 +0200
Subject: [PATCH 36/48] ARM: dts: r8a7791: Add reset control properties
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <be5ae56e5f2d1f4eff1c2eca3d8e7d801085a6e2.1506683482.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7791.dtsi | 82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e984b106dd1a..5a8a15847076 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -120,6 +120,7 @@
 		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 408>;
 	};
 
 	gpio0: gpio at e6050000 {
@@ -133,6 +134,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 912>;
 	};
 
 	gpio1: gpio at e6051000 {
@@ -146,6 +148,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 911>;
 	};
 
 	gpio2: gpio at e6052000 {
@@ -159,6 +162,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 910>;
 	};
 
 	gpio3: gpio at e6053000 {
@@ -172,6 +176,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 909>;
 	};
 
 	gpio4: gpio at e6054000 {
@@ -185,6 +190,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 908>;
 	};
 
 	gpio5: gpio at e6055000 {
@@ -198,6 +204,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 907>;
 	};
 
 	gpio6: gpio at e6055400 {
@@ -211,6 +218,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 905>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 905>;
 	};
 
 	gpio7: gpio at e6055800 {
@@ -224,6 +232,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 904>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 904>;
 	};
 
 	thermal: thermal at e61f0000 {
@@ -234,6 +243,7 @@
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 522>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -253,6 +263,7 @@
 		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 124>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -273,6 +284,7 @@
 		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 329>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -296,6 +308,7 @@
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 407>;
 	};
 
 	dmac0: dma-controller at e6700000 {
@@ -325,6 +338,7 @@
 		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 219>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -356,6 +370,7 @@
 		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 218>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -385,6 +400,7 @@
 		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 502>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -414,6 +430,7 @@
 		clocks = <&cpg CPG_MOD 501>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 501>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -426,6 +443,7 @@
 		interrupt-names = "ch0", "ch1";
 		clocks = <&cpg CPG_MOD 330>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 330>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -438,6 +456,7 @@
 		interrupt-names = "ch0", "ch1";
 		clocks = <&cpg CPG_MOD 331>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 331>;
 		#dma-cells = <1>;
 		dma-channels = <2>;
 	};
@@ -451,6 +470,7 @@
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 931>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -463,6 +483,7 @@
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 930>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -475,6 +496,7 @@
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 929>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -487,6 +509,7 @@
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 928>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -499,6 +522,7 @@
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 927>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 927>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -512,6 +536,7 @@
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 925>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 925>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -529,6 +554,7 @@
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 926>;
 		status = "disabled";
 	};
 
@@ -544,6 +570,7 @@
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 318>;
 		status = "disabled";
 	};
 
@@ -559,6 +586,7 @@
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 323>;
 		status = "disabled";
 	};
 
@@ -576,6 +604,7 @@
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 315>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -591,6 +620,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 314>;
 		status = "disabled";
 	};
 
@@ -604,6 +634,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 312>;
 		status = "disabled";
 	};
 
@@ -617,6 +648,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 311>;
 		status = "disabled";
 	};
 
@@ -631,6 +663,7 @@
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 204>;
 		status = "disabled";
 	};
 
@@ -645,6 +678,7 @@
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 203>;
 		status = "disabled";
 	};
 
@@ -659,6 +693,7 @@
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 202>;
 		status = "disabled";
 	};
 
@@ -673,6 +708,7 @@
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 1106>;
 		status = "disabled";
 	};
 
@@ -687,6 +723,7 @@
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 1107>;
 		status = "disabled";
 	};
 
@@ -701,6 +738,7 @@
 		       <&dmac1 0x23>, <&dmac1 0x24>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 1108>;
 		status = "disabled";
 	};
 
@@ -715,6 +753,7 @@
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 206>;
 		status = "disabled";
 	};
 
@@ -729,6 +768,7 @@
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 207>;
 		status = "disabled";
 	};
 
@@ -743,6 +783,7 @@
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 216>;
 		status = "disabled";
 	};
 
@@ -758,6 +799,7 @@
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 721>;
 		status = "disabled";
 	};
 
@@ -773,6 +815,7 @@
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 720>;
 		status = "disabled";
 	};
 
@@ -782,6 +825,7 @@
 		clocks = <&cpg CPG_MOD 901>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 901>;
 		status = "disabled";
 	};
 
@@ -797,6 +841,7 @@
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 719>;
 		status = "disabled";
 	};
 
@@ -812,6 +857,7 @@
 		       <&dmac1 0x2f>, <&dmac1 0x30>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 718>;
 		status = "disabled";
 	};
 
@@ -827,6 +873,7 @@
 		       <&dmac1 0xfb>, <&dmac1 0xfc>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 715>;
 		status = "disabled";
 	};
 
@@ -842,6 +889,7 @@
 		       <&dmac1 0xfd>, <&dmac1 0xfe>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 714>;
 		status = "disabled";
 	};
 
@@ -857,6 +905,7 @@
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 717>;
 		status = "disabled";
 	};
 
@@ -872,6 +921,7 @@
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 716>;
 		status = "disabled";
 	};
 
@@ -887,6 +937,7 @@
 		       <&dmac1 0x3b>, <&dmac1 0x3c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 713>;
 		status = "disabled";
 	};
 
@@ -914,6 +965,7 @@
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 813>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -927,6 +979,7 @@
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 812>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 812>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -938,6 +991,7 @@
 		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 815>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 815>;
 		status = "disabled";
 	};
 
@@ -947,6 +1001,7 @@
 		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 814>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 814>;
 		status = "disabled";
 	};
 
@@ -959,6 +1014,7 @@
 		       <&usb_dmac1 0>, <&usb_dmac1 1>;
 		dma-names = "ch0", "ch1", "ch2", "ch3";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 704>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -974,6 +1030,7 @@
 		clocks = <&cpg CPG_MOD 704>;
 		clock-names = "usbhs";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 704>;
 		status = "disabled";
 
 		usb0: usb-channel at 0 {
@@ -992,6 +1049,7 @@
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 811>;
 		status = "disabled";
 	};
 
@@ -1001,6 +1059,7 @@
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 810>;
 		status = "disabled";
 	};
 
@@ -1010,6 +1069,7 @@
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 809>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 809>;
 		status = "disabled";
 	};
 
@@ -1019,6 +1079,7 @@
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 131>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 131>;
 	};
 
 	vsp1 at fe930000 {
@@ -1027,6 +1088,7 @@
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 128>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 128>;
 	};
 
 	vsp1 at fe938000 {
@@ -1035,6 +1097,7 @@
 		interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 127>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 127>;
 	};
 
 	du: display at feb00000 {
@@ -1075,6 +1138,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 916>;
 		status = "disabled";
 	};
 
@@ -1086,6 +1150,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 915>;
 		status = "disabled";
 	};
 
@@ -1095,6 +1160,7 @@
 		interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 106>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 106>;
 	};
 
 	/* External root clock */
@@ -1163,6 +1229,7 @@
 		clock-names = "extal", "usb_extal";
 		#clock-cells = <2>;
 		#power-domain-cells = <0>;
+		#reset-cells = <1>;
 	};
 
 	rst: reset-controller at e6160000 {
@@ -1190,6 +1257,7 @@
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -1206,6 +1274,7 @@
 		       <&dmac1 0x51>, <&dmac1 0x52>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1221,6 +1290,7 @@
 		       <&dmac1 0x55>, <&dmac1 0x56>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 208>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1236,6 +1306,7 @@
 		       <&dmac1 0x41>, <&dmac1 0x42>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 205>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1247,6 +1318,7 @@
 		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 328>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 328>;
 		phys = <&usb2 1>;
 		phy-names = "usb";
 		status = "disabled";
@@ -1260,6 +1332,7 @@
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -1293,6 +1366,7 @@
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -1341,6 +1415,7 @@
 		clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
 		clock-names = "pcie", "pcie_bus";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+		resets = <&cpg 319>;
 		status = "disabled";
 	};
 
@@ -1445,6 +1520,13 @@
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
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
