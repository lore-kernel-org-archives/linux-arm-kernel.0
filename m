From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 17:38:12 +0100
Subject: [PATCH 15/47] ARM: dts: r8a7792: sort subnodes of soc node
In-Reply-To: <cover.1521218085.git.horms+renesas@verge.net.au>
References: <cover.1521218085.git.horms+renesas@verge.net.au>
Message-ID: <3758e51b4b1e9cfd98be29b32b374582a00873c3.1521218085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the subnodes of the soc node to improve maintainability.
The sort key is the address on the bus with instances of the same
IP block grouped together.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7792.dtsi | 498 ++++++++++++++++++++---------------------
 1 file changed, 249 insertions(+), 249 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 3be15a158bad..268987ff0201 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -101,63 +101,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		apmu at e6152000 {
-			compatible = "renesas,r8a7792-apmu", "renesas,apmu";
-			reg = <0 0xe6152000 0 0x188>;
-			cpus = <&cpu0 &cpu1>;
-		};
-
-		gic: interrupt-controller at f1001000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0 0xf1001000 0 0x1000>,
-			      <0 0xf1002000 0 0x2000>,
-			      <0 0xf1004000 0 0x2000>,
-			      <0 0xf1006000 0 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
-				      IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
-		irqc: interrupt-controller at e61c0000 {
-			compatible = "renesas,irqc-r8a7792", "renesas,irqc";
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			reg = <0 0xe61c0000 0 0x200>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 407>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 407>;
-		};
-
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7792-rst";
-			reg = <0 0xe6160000 0 0x0100>;
-		};
-
-		prr: chipid at ff000044 {
-			compatible = "renesas,prr";
-			reg = <0 0xff000044 0 4>;
-		};
-
-		sysc: system-controller at e6180000 {
-			compatible = "renesas,r8a7792-sysc";
-			reg = <0 0xe6180000 0 0x0200>;
-			#power-domain-cells = <1>;
-		};
-
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a7792";
-			reg = <0 0xe6060000 0 0x144>;
-		};
-
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7792",
 				     "renesas,rcar-gen2-gpio";
@@ -338,6 +281,155 @@
 			resets = <&cpg 913>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7792";
+			reg = <0 0xe6060000 0 0x144>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7792-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>;
+			clock-names = "extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		apmu at e6152000 {
+			compatible = "renesas,r8a7792-apmu", "renesas,apmu";
+			reg = <0 0xe6152000 0 0x188>;
+			cpus = <&cpu0 &cpu1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7792-rst";
+			reg = <0 0xe6160000 0 0x0100>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7792-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
+		};
+
+		irqc: interrupt-controller at e61c0000 {
+			compatible = "renesas,irqc-r8a7792", "renesas,irqc";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <0 0xe61c0000 0 0x200>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 407>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 407>;
+		};
+
+		icram0:	sram at e63a0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63a0000 0 0x12000>;
+		};
+
+		icram1:	sram at e63c0000 {
+			compatible = "mmio-sram";
+			reg = <0 0xe63c0000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xe63c0000 0x1000>;
+
+			smp-sram at 0 {
+				compatible = "renesas,smp-sram";
+				reg = <0 0x10>;
+			};
+		};
+
+		/* I2C doesn't need pinmux */
+		i2c0: i2c at e6508000 {
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at e6518000 {
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at e6530000 {
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6530000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at e6540000 {
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at e6520000 {
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
+			i2c-scl-internal-delay-ns = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c at e6528000 {
+			compatible = "renesas,i2c-r8a7792",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6528000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 925>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 925>;
+			i2c-scl-internal-delay-ns = <110>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7792",
 				     "renesas,rcar-dmac";
@@ -404,6 +496,35 @@
 			dma-channels = <15>;
 		};
 
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7792",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7792", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a7792",
 				     "renesas,rcar-gen2-scif", "renesas,scif";
@@ -500,162 +621,6 @@
 			status = "disabled";
 		};
 
-		icram0:	sram at e63a0000 {
-			compatible = "mmio-sram";
-			reg = <0 0xe63a0000 0 0x12000>;
-		};
-
-		icram1:	sram at e63c0000 {
-			compatible = "mmio-sram";
-			reg = <0 0xe63c0000 0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0 0xe63c0000 0x1000>;
-
-			smp-sram at 0 {
-				compatible = "renesas,smp-sram";
-				reg = <0 0x10>;
-			};
-		};
-
-		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7792",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee100000 0 0x328>;
-			interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-			       <&dmac1 0xcd>, <&dmac1 0xce>;
-			dma-names = "tx", "rx", "tx", "rx";
-			clocks = <&cpg CPG_MOD 314>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 314>;
-			status = "disabled";
-		};
-
-		jpu: jpeg-codec at fe980000 {
-			compatible = "renesas,jpu-r8a7792",
-				     "renesas,rcar-gen2-jpu";
-			reg = <0 0xfe980000 0 0x10300>;
-			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 106>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 106>;
-		};
-
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a7792",
-				     "renesas,etheravb-rcar-gen2";
-			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
-			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 812>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 812>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		/* I2C doesn't need pinmux */
-		i2c0: i2c at e6508000 {
-			compatible = "renesas,i2c-r8a7792",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6508000 0 0x40>;
-			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 931>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 931>;
-			i2c-scl-internal-delay-ns = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c at e6518000 {
-			compatible = "renesas,i2c-r8a7792",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6518000 0 0x40>;
-			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 930>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 930>;
-			i2c-scl-internal-delay-ns = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c at e6530000 {
-			compatible = "renesas,i2c-r8a7792",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6530000 0 0x40>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 929>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 929>;
-			i2c-scl-internal-delay-ns = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c3: i2c at e6540000 {
-			compatible = "renesas,i2c-r8a7792",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6540000 0 0x40>;
-			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 928>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 928>;
-			i2c-scl-internal-delay-ns = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c4: i2c at e6520000 {
-			compatible = "renesas,i2c-r8a7792",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6520000 0 0x40>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 927>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 927>;
-			i2c-scl-internal-delay-ns = <6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c5: i2c at e6528000 {
-			compatible = "renesas,i2c-r8a7792",
-				     "renesas,rcar-gen2-i2c";
-			reg = <0 0xe6528000 0 0x40>;
-			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 925>;
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 925>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		qspi: spi at e6b10000 {
-			compatible = "renesas,qspi-r8a7792", "renesas,qspi";
-			reg = <0 0xe6b10000 0 0x2c>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 917>;
-			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
-			       <&dmac1 0x17>, <&dmac1 0x18>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
-			resets = <&cpg 917>;
-			num-cs = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
 		msiof0: spi at e6e20000 {
 			compatible = "renesas,msiof-r8a7792",
 				     "renesas,rcar-gen2-msiof";
@@ -688,34 +653,6 @@
 			status = "disabled";
 		};
 
-		du: display at feb00000 {
-			compatible = "renesas,du-r8a7792";
-			reg = <0 0xfeb00000 0 0x40000>;
-			reg-names = "du";
-			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>,
-				 <&cpg CPG_MOD 723>;
-			clock-names = "du.0", "du.1";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port at 0 {
-					reg = <0>;
-					du_out_rgb0: endpoint {
-					};
-				};
-				port at 1 {
-					reg = <1>;
-					du_out_rgb1: endpoint {
-					};
-				};
-			};
-		};
-
 		can0: can at e6e80000 {
 			compatible = "renesas,can-r8a7792",
 				     "renesas,rcar-gen2-can";
@@ -808,6 +745,36 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7792",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			clocks = <&cpg CPG_MOD 314>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>,
+			      <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>,
+			      <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
 		vsp at fe928000 {
 			compatible = "renesas,vsp1";
 			reg = <0 0xfe928000 0 0x8000>;
@@ -835,14 +802,47 @@
 			resets = <&cpg 127>;
 		};
 
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7792-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
-			clock-names = "extal";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
+		jpu: jpeg-codec at fe980000 {
+			compatible = "renesas,jpu-r8a7792",
+				     "renesas,rcar-gen2-jpu";
+			reg = <0 0xfe980000 0 0x10300>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 106>;
+			power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
+			resets = <&cpg 106>;
+		};
+
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a7792";
+			reg = <0 0xfeb00000 0 0x40000>;
+			reg-names = "du";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>;
+			clock-names = "du.0", "du.1";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					du_out_rgb0: endpoint {
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					du_out_rgb1: endpoint {
+					};
+				};
+			};
+		};
+
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
 		};
 	};
 
-- 
2.11.0
