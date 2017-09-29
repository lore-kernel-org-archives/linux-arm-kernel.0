From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:31 +0200
Subject: [PATCH 39/48] ARM: dts: r8a7794: Add reset control properties
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <615beb759ca494a4b1a202f571af41549064dc2f.1506683482.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7794.dtsi | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index a4c35d29f77c..035c33715b65 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -78,6 +78,7 @@
 		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 408>;
 	};
 
 	gpio0: gpio at e6050000 {
@@ -91,6 +92,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 912>;
 	};
 
 	gpio1: gpio at e6051000 {
@@ -104,6 +106,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 911>;
 	};
 
 	gpio2: gpio at e6052000 {
@@ -117,6 +120,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 910>;
 	};
 
 	gpio3: gpio at e6053000 {
@@ -130,6 +134,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 909>;
 	};
 
 	gpio4: gpio at e6054000 {
@@ -143,6 +148,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 908>;
 	};
 
 	gpio5: gpio at e6055000 {
@@ -156,6 +162,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 907>;
 	};
 
 	gpio6: gpio at e6055400 {
@@ -169,6 +176,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 905>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 905>;
 	};
 
 	cmt0: timer at ffca0000 {
@@ -179,6 +187,7 @@
 		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 124>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -199,6 +208,7 @@
 		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 329>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -230,6 +240,7 @@
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 407>;
 	};
 
 	pfc: pin-controller at e6060000 {
@@ -264,6 +275,7 @@
 		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 219>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -295,6 +307,7 @@
 		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 218>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -323,6 +336,7 @@
 		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 502>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -338,6 +352,7 @@
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 204>;
 		status = "disabled";
 	};
 
@@ -352,6 +367,7 @@
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 203>;
 		status = "disabled";
 	};
 
@@ -366,6 +382,7 @@
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 202>;
 		status = "disabled";
 	};
 
@@ -380,6 +397,7 @@
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 1106>;
 		status = "disabled";
 	};
 
@@ -394,6 +412,7 @@
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 1107>;
 		status = "disabled";
 	};
 
@@ -408,6 +427,7 @@
 		       <&dmac1 0x23>, <&dmac1 0x24>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 1108>;
 		status = "disabled";
 	};
 
@@ -422,6 +442,7 @@
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 206>;
 		status = "disabled";
 	};
 
@@ -436,6 +457,7 @@
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 207>;
 		status = "disabled";
 	};
 
@@ -450,6 +472,7 @@
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 216>;
 		status = "disabled";
 	};
 
@@ -465,6 +488,7 @@
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 721>;
 		status = "disabled";
 	};
 
@@ -480,6 +504,7 @@
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 720>;
 		status = "disabled";
 	};
 
@@ -495,6 +520,7 @@
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 719>;
 		status = "disabled";
 	};
 
@@ -510,6 +536,7 @@
 		       <&dmac1 0x2f>, <&dmac1 0x30>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 718>;
 		status = "disabled";
 	};
 
@@ -525,6 +552,7 @@
 		       <&dmac1 0xfb>, <&dmac1 0xfc>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 715>;
 		status = "disabled";
 	};
 
@@ -540,6 +568,7 @@
 		       <&dmac1 0xfd>, <&dmac1 0xfe>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 714>;
 		status = "disabled";
 	};
 
@@ -555,6 +584,7 @@
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 717>;
 		status = "disabled";
 	};
 
@@ -570,6 +600,7 @@
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 716>;
 		status = "disabled";
 	};
 
@@ -585,6 +616,7 @@
 		       <&dmac1 0x3b>, <&dmac1 0x3c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 713>;
 		status = "disabled";
 	};
 
@@ -612,6 +644,7 @@
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 813>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -625,6 +658,7 @@
 		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 812>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 812>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -637,6 +671,7 @@
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 931>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -649,6 +684,7 @@
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 930>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -661,6 +697,7 @@
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 929>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -673,6 +710,7 @@
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 928>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -685,6 +723,7 @@
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 927>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 927>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -697,6 +736,7 @@
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 925>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 925>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c-scl-internal-delay-ns = <6>;
@@ -713,6 +753,7 @@
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 318>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -728,6 +769,7 @@
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 323>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -742,6 +784,7 @@
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 315>;
 		reg-io-width = <4>;
 		status = "disabled";
 	};
@@ -756,6 +799,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 314>;
 		status = "disabled";
 	};
 
@@ -769,6 +813,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 312>;
 		status = "disabled";
 	};
 
@@ -782,6 +827,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 311>;
 		status = "disabled";
 	};
 
@@ -794,6 +840,7 @@
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -806,6 +853,7 @@
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 811>;
 		status = "disabled";
 	};
 
@@ -815,6 +863,7 @@
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 810>;
 		status = "disabled";
 	};
 
@@ -826,6 +875,7 @@
 		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		status = "disabled";
 
 		bus-range = <0 0>;
@@ -859,6 +909,7 @@
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 703>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 703>;
 		status = "disabled";
 
 		bus-range = <1 1>;
@@ -890,6 +941,7 @@
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 704>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 704>;
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
@@ -905,6 +957,7 @@
 		clocks = <&cpg CPG_MOD 704>;
 		clock-names = "usbhs";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 704>;
 		status = "disabled";
 
 		usb0: usb-channel at 0 {
@@ -923,6 +976,7 @@
 		interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 131>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 131>;
 	};
 
 	vsp1 at fe930000 {
@@ -931,6 +985,7 @@
 		interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 128>;
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 128>;
 	};
 
 	du: display at feb00000 {
@@ -968,6 +1023,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 916>;
 		status = "disabled";
 	};
 
@@ -979,6 +1035,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
+		resets = <&cpg 915>;
 		status = "disabled";
 	};
 
@@ -1151,6 +1208,13 @@
 			      "dvc.0", "dvc.1",
 			      "clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;
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
