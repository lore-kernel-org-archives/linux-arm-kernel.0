From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:48 +0200
Subject: [PATCH 026/102] arm64: dts: renesas: r8a77965: sort subnodes of the
 soc node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <2af6f5a3fd585427fcab5848e87223a486e74c37.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Sort subnodes of the soc node.
- The primary key is the bus address.
- The secondary key is the IP block.
- The tertiary key is the node name.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 912 +++++++++++++++---------------
 1 file changed, 456 insertions(+), 456 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index d110382276b7..b12f41755aea 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -130,52 +130,9 @@
 		#size-cells = <2>;
 		ranges;
 
-		gic: interrupt-controller at f1010000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0x0 0xf1010000 0 0x1000>,
-			      <0x0 0xf1020000 0 0x20000>,
-			      <0x0 0xf1040000 0 0x20000>,
-			      <0x0 0xf1060000 0 0x20000>;
-			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 408>;
-		};
-
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a77965";
-			reg = <0 0xe6060000 0 0x50c>;
-		};
-
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a77965-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&extalr_clk>;
-			clock-names = "extal", "extalr";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
-		};
-
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a77965-rst";
-			reg = <0 0xe6160000 0 0x0200>;
-		};
-
-		prr: chipid at fff00044 {
-			compatible = "renesas,prr";
-			reg = <0 0xfff00044 0 4>;
-		};
-
-		sysc: system-controller at e6180000 {
-			compatible = "renesas,r8a77965-sysc";
-			reg = <0 0xe6180000 0 0x0400>;
-			#power-domain-cells = <1>;
+		wdt0: watchdog at e6020000 {
+			reg = <0 0xe6020000 0 0x0c>;
+			/* placeholder */
 		};
 
 		gpio0: gpio at e6050000 {
@@ -298,6 +255,32 @@
 			resets = <&cpg 905>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77965";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a77965-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77965-rst";
+			reg = <0 0xe6160000 0 0x0200>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a77965-sysc";
+			reg = <0 0xe6180000 0 0x0400>;
+			#power-domain-cells = <1>;
+		};
+
 		intc_ex: interrupt-controller at e61c0000 {
 			compatible = "renesas,intc-ex-r8a77965", "renesas,irqc";
 			#interrupt-cells = <2>;
@@ -314,6 +297,121 @@
 			resets = <&cpg 407>;
 		};
 
+		i2c0: i2c at e6500000 {
+			reg = <0 0xe6500000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c1: i2c at e6508000 {
+			reg = <0 0xe6508000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c2: i2c at e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0xe6510000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c3: i2c at e66d0000 {
+			reg = <0 0xe66d0000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c4: i2c at e66d8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0xe66d8000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c5: i2c at e66e0000 {
+			reg = <0 0xe66e0000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c6: i2c at e66e8000 {
+			reg = <0 0xe66e8000 0 0x40>;
+			/* placeholder */
+		};
+
+		i2c_dvfs: i2c at e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a77965",
+				     "renesas,rcar-gen3-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 926>;
+			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7796",
+				     "renesas,rcar-gen3-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 704>;
+			status = "disabled";
+		};
+
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a77965-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a77965-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb3_phy0: usb-phy at e65ee000 {
+			compatible = "renesas,r8a77965-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
+			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a77965",
 				     "renesas,rcar-dmac";
@@ -416,35 +514,150 @@
 			dma-channels = <16>;
 		};
 
-		scif0: serial at e6e60000 {
-			compatible = "renesas,scif-r8a77965",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e60000 0 64>;
-			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 207>,
-				 <&cpg CPG_CORE 20>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
-			       <&dmac2 0x51>, <&dmac2 0x50>;
-			dma-names = "tx", "rx", "tx", "rx";
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a77965",
+				     "renesas,etheravb-rcar-gen3";
+			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14", "ch15",
+					  "ch16", "ch17", "ch18", "ch19",
+					  "ch20", "ch21", "ch22", "ch23",
+					  "ch24";
+			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc 32>;
-			resets = <&cpg 207>;
+			resets = <&cpg 812>;
+			phy-mode = "rgmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		scif1: serial at e6e68000 {
-			compatible = "renesas,scif-r8a77965",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e68000 0 64>;
-			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 206>,
-				 <&cpg CPG_CORE 20>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
-			       <&dmac2 0x53>, <&dmac2 0x52>;
-			dma-names = "tx", "rx", "tx", "rx";
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
+			       <&dmac2 0x51>, <&dmac2 0x50>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 207>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a77965",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>,
+				 <&cpg CPG_CORE 20>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
+			       <&dmac2 0x53>, <&dmac2 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc 32>;
 			resets = <&cpg 206>;
 			status = "disabled";
@@ -513,69 +726,66 @@
 			status = "disabled";
 		};
 
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a77965",
-				     "renesas,etheravb-rcar-gen3";
-			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12", "ch13", "ch14", "ch15",
-					  "ch16", "ch17", "ch18", "ch19",
-					  "ch20", "ch21", "ch22", "ch23",
-					  "ch24";
-			clocks = <&cpg CPG_MOD 812>;
+		msiof0: spi at e6e90000 {
+			compatible = "renesas,msiof-r8a77965",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6e90000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 211>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
+			       <&dmac2 0x41>, <&dmac2 0x40>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc 32>;
-			resets = <&cpg 812>;
-			phy-mode = "rgmii";
+			resets = <&cpg 211>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		csi20: csi2 at fea80000 {
-			reg = <0 0xfea80000 0 0x10000>;
-			/* placeholder */
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+		msiof1: spi at e6ea0000 {
+			compatible = "renesas,msiof-r8a77965",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6ea0000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 210>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
+			       <&dmac2 0x43>, <&dmac2 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 210>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
-		csi40: csi2 at feaa0000 {
-			reg = <0 0xfeaa0000 0 0x10000>;
-			/* placeholder */
+		msiof2: spi at e6c00000 {
+			compatible = "renesas,msiof-r8a77965",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 209>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 209>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+		msiof3: spi at e6c10000 {
+			compatible = "renesas,msiof-r8a77965",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c10000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 208>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		vin0: video at e6ef0000 {
@@ -618,6 +828,58 @@
 			/* placeholder */
 		};
 
+		rcar_sound: sound at ec500000 {
+			reg =	<0 0xec500000 0 0x1000>, /* SCU */
+				<0 0xec5a0000 0 0x100>,  /* ADG */
+				<0 0xec540000 0 0x1000>, /* SSIU */
+				<0 0xec541000 0 0x280>,  /* SSI */
+				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+			/* placeholder */
+
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+				};
+				dvc1: dvc-1 {
+				};
+			};
+
+			rcar_sound,src {
+				src0: src-0 {
+				};
+				src1: src-1 {
+				};
+			};
+
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+				};
+				ssi1: ssi-1 {
+				};
+			};
+		};
+
+		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a77965",
+				     "renesas,rcar-gen3-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
+		usb3_peri0: usb at ee020000 {
+			compatible = "renesas,r8a77965-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
+			reg = <0 0xee020000 0 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
 		ohci0: usb at ee080000 {
 			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
@@ -630,6 +892,18 @@
 			status = "disabled";
 		};
 
+		ohci1: usb at ee0a0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
 		ehci0: usb at ee080100 {
 			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
@@ -643,6 +917,19 @@
 			status = "disabled";
 		};
 
+		ehci1: usb at ee0a0100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee0a0100 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
 		usb2_phy0: usb-phy at ee080200 {
 			compatible = "renesas,usb2-phy-r8a77965",
 				     "renesas,rcar-gen3-usb2-phy";
@@ -666,218 +953,71 @@
 			status = "disabled";
 		};
 
-		ohci1: usb at ee0a0000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee0a0000 0 0x100>;
-			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 702>;
-			phys = <&usb2_phy1>;
-			phy-names = "usb";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 702>;
-			status = "disabled";
-		};
-
-		ehci1: usb at ee0a0100 {
-			compatible = "generic-ehci";
-			reg = <0 0xee0a0100 0 0x100>;
-			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 702>;
-			phys = <&usb2_phy1>;
-			phy-names = "usb";
-			companion = <&ohci1>;
-			power-domains = <&sysc 32>;
-			resets = <&cpg 702>;
-			status = "disabled";
-		};
-
-		i2c0: i2c at e6500000 {
-			reg = <0 0xe6500000 0 0x40>;
+		sdhi0: sd at ee100000 {
+			reg = <0 0xee100000 0 0x2000>;
 			/* placeholder */
 		};
 
-		i2c1: i2c at e6508000 {
-			reg = <0 0xe6508000 0 0x40>;
+		sdhi1: sd at ee120000 {
+			reg = <0 0xee120000 0 0x2000>;
 			/* placeholder */
 		};
 
-		i2c2: i2c at e6510000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			reg = <0 0xe6510000 0 0x40>;
+		sdhi2: sd at ee140000 {
+			reg = <0 0xee140000 0 0x2000>;
 			/* placeholder */
 		};
 
-		i2c3: i2c at e66d0000 {
-			reg = <0 0xe66d0000 0 0x40>;
+		sdhi3: sd at ee160000 {
+			reg = <0 0xee160000 0 0x2000>;
 			/* placeholder */
 		};
 
-		i2c4: i2c at e66d8000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			reg = <0 0xe66d8000 0 0x40>;
-			/* placeholder */
+		gic: interrupt-controller at f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0x0 0xf1010000 0 0x1000>,
+			      <0x0 0xf1020000 0 0x20000>,
+			      <0x0 0xf1040000 0 0x20000>,
+			      <0x0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9
+					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 408>;
 		};
 
-		i2c5: i2c at e66e0000 {
-			reg = <0 0xe66e0000 0 0x40>;
+		pciec0: pcie at fe000000 {
+			reg = <0 0xfe000000 0 0x80000>;
 			/* placeholder */
 		};
 
-		i2c6: i2c at e66e8000 {
-			reg = <0 0xe66e8000 0 0x40>;
+		pciec1: pcie at ee800000 {
+			reg = <0 0xee800000 0 0x80000>;
 			/* placeholder */
 		};
 
-		i2c_dvfs: i2c at e60b0000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,iic-r8a77965",
-				     "renesas,rcar-gen3-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe60b0000 0 0x425>;
-			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 926>;
-			power-domains = <&sysc 32>;
-			resets = <&cpg 926>;
-			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		pwm0: pwm at e6e30000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e30000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		pwm1: pwm at e6e31000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e31000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		pwm2: pwm at e6e32000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e32000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		pwm3: pwm at e6e33000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e33000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		pwm4: pwm at e6e34000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e34000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		pwm5: pwm at e6e35000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e35000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		pwm6: pwm at e6e36000 {
-			compatible = "renesas,pwm-r8a77965", "renesas,pwm-rcar";
-			reg = <0 0xe6e36000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc 32>;
-			status = "disabled";
-		};
-
-		msiof0: spi at e6e90000 {
-			compatible = "renesas,msiof-r8a77965",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6e90000 0 0x0064>;
-			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 211>;
-			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
-			       <&dmac2 0x41>, <&dmac2 0x40>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 211>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
+		csi20: csi2 at fea80000 {
+			reg = <0 0xfea80000 0 0x10000>;
+			/* placeholder */
 
-		msiof1: spi at e6ea0000 {
-			compatible = "renesas,msiof-r8a77965",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6ea0000 0 0x0064>;
-			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 210>;
-			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
-			       <&dmac2 0x43>, <&dmac2 0x42>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 210>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
-		msiof2: spi at e6c00000 {
-			compatible = "renesas,msiof-r8a77965",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6c00000 0 0x0064>;
-			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 209>;
-			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
-			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 209>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
+		csi40: csi2 at feaa0000 {
+			reg = <0 0xfeaa0000 0 0x10000>;
+			/* placeholder */
 
-		msiof3: spi at e6c10000 {
-			compatible = "renesas,msiof-r8a77965",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6c10000 0 0x0064>;
-			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 208>;
-			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
-			dma-names = "tx", "rx";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 208>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		du: display at feb00000 {
@@ -907,149 +1047,9 @@
 			};
 		};
 
-		usb_dmac0: dma-controller at e65a0000 {
-			compatible = "renesas,r8a77965-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65a0000 0 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&sysc 32>;
-			resets = <&cpg 330>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
-		};
-
-		usb_dmac1: dma-controller at e65b0000 {
-			compatible = "renesas,r8a77965-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65b0000 0 0x100>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&sysc 32>;
-			resets = <&cpg 331>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
-		};
-
-		hsusb: usb at e6590000 {
-			compatible = "renesas,usbhs-r8a7796",
-				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
-			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
-			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
-			       <&usb_dmac1 0>, <&usb_dmac1 1>;
-			dma-names = "ch0", "ch1", "ch2", "ch3";
-			renesas,buswait = <11>;
-			phys = <&usb2_phy0>;
-			phy-names = "usb";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 704>;
-			status = "disabled";
-		};
-
-		pciec0: pcie at fe000000 {
-			reg = <0 0xfe000000 0 0x80000>;
-			/* placeholder */
-		};
-
-		pciec1: pcie at ee800000 {
-			reg = <0 0xee800000 0 0x80000>;
-			/* placeholder */
-		};
-
-		rcar_sound: sound at ec500000 {
-			reg =	<0 0xec500000 0 0x1000>, /* SCU */
-				<0 0xec5a0000 0 0x100>,  /* ADG */
-				<0 0xec540000 0 0x1000>, /* SSIU */
-				<0 0xec541000 0 0x280>,  /* SSI */
-				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
-			/* placeholder */
-
-			rcar_sound,dvc {
-				dvc0: dvc-0 {
-				};
-				dvc1: dvc-1 {
-				};
-			};
-
-			rcar_sound,src {
-				src0: src-0 {
-				};
-				src1: src-1 {
-				};
-			};
-
-			rcar_sound,ssi {
-				ssi0: ssi-0 {
-				};
-				ssi1: ssi-1 {
-				};
-			};
-		};
-
-		sdhi0: sd at ee100000 {
-			reg = <0 0xee100000 0 0x2000>;
-			/* placeholder */
-		};
-
-		sdhi1: sd at ee120000 {
-			reg = <0 0xee120000 0 0x2000>;
-			/* placeholder */
-		};
-
-		sdhi2: sd at ee140000 {
-			reg = <0 0xee140000 0 0x2000>;
-			/* placeholder */
-		};
-
-		sdhi3: sd at ee160000 {
-			reg = <0 0xee160000 0 0x2000>;
-			/* placeholder */
-		};
-
-		usb3_phy0: usb-phy at e65ee000 {
-			compatible = "renesas,r8a77965-usb3-phy",
-				     "renesas,rcar-gen3-usb3-phy";
-			reg = <0 0xe65ee000 0 0x90>;
-			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
-				 <&usb_extal_clk>;
-			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
-			power-domains = <&sysc 32>;
-			resets = <&cpg 328>;
-			#phy-cells = <0>;
-			status = "disabled";
-		};
-
-		usb3_peri0: usb at ee020000 {
-			compatible = "renesas,r8a77965-usb3-peri",
-				     "renesas,rcar-gen3-usb3-peri";
-			reg = <0 0xee020000 0 0x400>;
-			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc 32>;
-			resets = <&cpg 328>;
-			status = "disabled";
-		};
-
-		xhci0: usb at ee000000 {
-			compatible = "renesas,xhci-r8a77965",
-				     "renesas,rcar-gen3-xhci";
-			reg = <0 0xee000000 0 0xc00>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
-			power-domains = <&sysc 32>;
-			resets = <&cpg 328>;
-			status = "disabled";
-		};
-
-		wdt0: watchdog at e6020000 {
-			reg = <0 0xe6020000 0 0x0c>;
-			/* placeholder */
+		prr: chipid at fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
 		};
 	};
 
-- 
2.11.0
