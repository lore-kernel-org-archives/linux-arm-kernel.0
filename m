From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Sep 2017 13:53:30 +0200
Subject: [PATCH 38/48] ARM: dts: r8a7793: Add reset control properties
In-Reply-To: <cover.1506683482.git.horms+renesas@verge.net.au>
References: <cover.1506683482.git.horms+renesas@verge.net.au>
Message-ID: <84fb19e1d201ba862cf25995cdb7c061c9d938ea.1506683482.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7793.dtsi | 62 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index d48b97c853cd..aa19b93494bf 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -111,6 +111,7 @@
 		clocks = <&cpg CPG_MOD 408>;
 		clock-names = "clk";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 408>;
 	};
 
 	gpio0: gpio at e6050000 {
@@ -124,6 +125,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 912>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 912>;
 	};
 
 	gpio1: gpio at e6051000 {
@@ -137,6 +139,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 911>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 911>;
 	};
 
 	gpio2: gpio at e6052000 {
@@ -150,6 +153,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 910>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 910>;
 	};
 
 	gpio3: gpio at e6053000 {
@@ -163,6 +167,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 909>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 909>;
 	};
 
 	gpio4: gpio at e6054000 {
@@ -176,6 +181,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 908>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 908>;
 	};
 
 	gpio5: gpio at e6055000 {
@@ -189,6 +195,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 907>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 907>;
 	};
 
 	gpio6: gpio at e6055400 {
@@ -202,6 +209,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 905>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 905>;
 	};
 
 	gpio7: gpio at e6055800 {
@@ -215,6 +223,7 @@
 		interrupt-controller;
 		clocks = <&cpg CPG_MOD 904>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 904>;
 	};
 
 	thermal: thermal at e61f0000 {
@@ -225,6 +234,7 @@
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 522>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 522>;
 		#thermal-sensor-cells = <0>;
 	};
 
@@ -244,6 +254,7 @@
 		clocks = <&cpg CPG_MOD 124>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 124>;
 
 		renesas,channels-mask = <0x60>;
 
@@ -264,6 +275,7 @@
 		clocks = <&cpg CPG_MOD 329>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 329>;
 
 		renesas,channels-mask = <0xff>;
 
@@ -287,6 +299,7 @@
 			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 407>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 407>;
 	};
 
 	dmac0: dma-controller at e6700000 {
@@ -316,6 +329,7 @@
 		clocks = <&cpg CPG_MOD 219>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 219>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -347,6 +361,7 @@
 		clocks = <&cpg CPG_MOD 218>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 218>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
 	};
@@ -376,6 +391,7 @@
 		clocks = <&cpg CPG_MOD 502>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 502>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -405,6 +421,7 @@
 		clocks = <&cpg CPG_MOD 501>;
 		clock-names = "fck";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 501>;
 		#dma-cells = <1>;
 		dma-channels = <13>;
 	};
@@ -418,6 +435,7 @@
 		interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 931>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 931>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -430,6 +448,7 @@
 		interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 930>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 930>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -442,6 +461,7 @@
 		interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 929>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 929>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -454,6 +474,7 @@
 		interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 928>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 928>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -466,6 +487,7 @@
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 927>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 927>;
 		i2c-scl-internal-delay-ns = <6>;
 		status = "disabled";
 	};
@@ -479,6 +501,7 @@
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 925>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 925>;
 		i2c-scl-internal-delay-ns = <110>;
 		status = "disabled";
 	};
@@ -496,6 +519,7 @@
 		       <&dmac1 0x77>, <&dmac1 0x78>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 926>;
 		status = "disabled";
 	};
 
@@ -511,6 +535,7 @@
 		       <&dmac1 0x61>, <&dmac1 0x62>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 318>;
 		status = "disabled";
 	};
 
@@ -526,6 +551,7 @@
 		       <&dmac1 0x65>, <&dmac1 0x66>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 323>;
 		status = "disabled";
 	};
 
@@ -544,6 +570,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <195000000>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 314>;
 		status = "disabled";
 	};
 
@@ -557,6 +584,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 312>;
 		status = "disabled";
 	};
 
@@ -570,6 +598,7 @@
 		dma-names = "tx", "rx", "tx", "rx";
 		max-frequency = <97500000>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 311>;
 		status = "disabled";
 	};
 
@@ -582,6 +611,7 @@
 		       <&dmac1 0xd1>, <&dmac1 0xd2>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 315>;
 		reg-io-width = <4>;
 		status = "disabled";
 		max-frequency = <97500000>;
@@ -598,6 +628,7 @@
 		       <&dmac1 0x21>, <&dmac1 0x22>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 204>;
 		status = "disabled";
 	};
 
@@ -612,6 +643,7 @@
 		       <&dmac1 0x25>, <&dmac1 0x26>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 203>;
 		status = "disabled";
 	};
 
@@ -626,6 +658,7 @@
 		       <&dmac1 0x27>, <&dmac1 0x28>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 202>;
 		status = "disabled";
 	};
 
@@ -640,6 +673,7 @@
 		       <&dmac1 0x1b>, <&dmac1 0x1c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 1106>;
 		status = "disabled";
 	};
 
@@ -654,6 +688,7 @@
 		       <&dmac1 0x1f>, <&dmac1 0x20>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 1107>;
 		status = "disabled";
 	};
 
@@ -668,6 +703,7 @@
 		       <&dmac1 0x23>, <&dmac1 0x24>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 1108>;
 		status = "disabled";
 	};
 
@@ -682,6 +718,7 @@
 		       <&dmac1 0x3d>, <&dmac1 0x3e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 206>;
 		status = "disabled";
 	};
 
@@ -696,6 +733,7 @@
 		       <&dmac1 0x19>, <&dmac1 0x1a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 207>;
 		status = "disabled";
 	};
 
@@ -710,6 +748,7 @@
 		       <&dmac1 0x1d>, <&dmac1 0x1e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 216>;
 		status = "disabled";
 	};
 
@@ -725,6 +764,7 @@
 		       <&dmac1 0x29>, <&dmac1 0x2a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 721>;
 		status = "disabled";
 	};
 
@@ -740,6 +780,7 @@
 		       <&dmac1 0x2d>, <&dmac1 0x2e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 720>;
 		status = "disabled";
 	};
 
@@ -755,6 +796,7 @@
 		       <&dmac1 0x2b>, <&dmac1 0x2c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 719>;
 		status = "disabled";
 	};
 
@@ -770,6 +812,7 @@
 		       <&dmac1 0x2f>, <&dmac1 0x30>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 718>;
 		status = "disabled";
 	};
 
@@ -785,6 +828,7 @@
 		       <&dmac1 0xfb>, <&dmac1 0xfc>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 715>;
 		status = "disabled";
 	};
 
@@ -800,6 +844,7 @@
 		       <&dmac1 0xfd>, <&dmac1 0xfe>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 714>;
 		status = "disabled";
 	};
 
@@ -815,6 +860,7 @@
 		       <&dmac1 0x39>, <&dmac1 0x3a>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 717>;
 		status = "disabled";
 	};
 
@@ -830,6 +876,7 @@
 		       <&dmac1 0x4d>, <&dmac1 0x4e>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 716>;
 		status = "disabled";
 	};
 
@@ -845,6 +892,7 @@
 		       <&dmac1 0x3b>, <&dmac1 0x3c>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 713>;
 		status = "disabled";
 	};
 
@@ -872,6 +920,7 @@
 		interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 813>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 813>;
 		phy-mode = "rmii";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -884,6 +933,7 @@
 		interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 811>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 811>;
 		status = "disabled";
 	};
 
@@ -893,6 +943,7 @@
 		interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 810>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 810>;
 		status = "disabled";
 	};
 
@@ -902,6 +953,7 @@
 		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cpg CPG_MOD 809>;
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 809>;
 		status = "disabled";
 	};
 
@@ -914,6 +966,7 @@
 		       <&dmac1 0x17>, <&dmac1 0x18>;
 		dma-names = "tx", "rx", "tx", "rx";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
 		num-cs = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -958,6 +1011,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 916>;
 		status = "disabled";
 	};
 
@@ -969,6 +1023,7 @@
 			 <&can_clk>;
 		clock-names = "clkp1", "clkp2", "can_clk";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
+		resets = <&cpg 915>;
 		status = "disabled";
 	};
 
@@ -1147,6 +1202,13 @@
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
 		power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;
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
