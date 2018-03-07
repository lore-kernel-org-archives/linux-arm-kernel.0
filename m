From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Mar 2018 10:40:46 +0100
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: sort subnodes of the soc
 node
In-Reply-To: <20180307094046.4907-1-horms+renesas@verge.net.au>
References: <20180307094046.4907-1-horms+renesas@verge.net.au>
Message-ID: <20180307094046.4907-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort subnodes of the soc node.
The primary key is the bus address.
The secondary key is the IP block.
The tertiary key is the node name.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1844 +++++++++++++++---------------
 1 file changed, 922 insertions(+), 922 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d2ecb1dfa487..abed81796ce5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -291,23 +291,6 @@
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
-					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		wdt0: watchdog at e6020000 {
 			compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
@@ -437,6 +420,11 @@
 			resets = <&cpg 905>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7795";
+			reg = <0 0xe6060000 0 0x50c>;
+		};
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7795-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -452,20 +440,25 @@
 			reg = <0 0xe6160000 0 0x0200>;
 		};
 
-		prr: chipid at fff00044 {
-			compatible = "renesas,prr";
-			reg = <0 0xfff00044 0 4>;
-		};
-
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7795-sysc";
 			reg = <0 0xe6180000 0 0x0400>;
 			#power-domain-cells = <1>;
 		};
 
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a7795";
-			reg = <0 0xe6060000 0 0x50c>;
+		tsc: thermal at e6198000 {
+			compatible = "renesas,r8a7795-thermal";
+			reg = <0 0xe6198000 0 0x100>,
+			      <0 0xe61a0000 0 0x100>,
+			      <0 0xe61a8000 0 0x100>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
+			#thermal-sensor-cells = <1>;
+			status = "okay";
 		};
 
 		intc_ex: interrupt-controller at e61c0000 {
@@ -484,144 +477,320 @@
 			resets = <&cpg 407>;
 		};
 
-		ipmmu_vi0: mmu at febd0000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfebd0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 14>;
+		i2c0: i2c at e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6500000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 931>;
+			dmas = <&dmac1 0x91>, <&dmac1 0x90>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
+			status = "disabled";
 		};
 
-		ipmmu_vi1: mmu at febe0000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfebe0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 15>;
+		i2c1: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 930>;
+			dmas = <&dmac1 0x93>, <&dmac1 0x92>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		ipmmu_vp0: mmu at fe990000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfe990000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 16>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			#iommu-cells = <1>;
+		i2c2: i2c at e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6510000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			dmas = <&dmac1 0x95>, <&dmac1 0x94>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		ipmmu_vp1: mmu at fe980000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfe980000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 17>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_vc0: mmu at fe6b0000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfe6b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 12>;
-			power-domains = <&sysc R8A7795_PD_A3VC>;
-			#iommu-cells = <1>;
+		i2c3: i2c at e66d0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66d0000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
-		ipmmu_vc1: mmu at fe6f0000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfe6f0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 13>;
-			power-domains = <&sysc R8A7795_PD_A3VC>;
-			#iommu-cells = <1>;
+		i2c4: i2c at e66d8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66d8000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 927>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 927>;
+			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
-		ipmmu_pv0: mmu at fd800000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfd800000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 6>;
+		i2c5: i2c at e66e0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66e0000 0 0x40>;
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 919>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 919>;
+			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
-		ipmmu_pv2: mmu at fd960000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfd960000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 8>;
+		i2c6: i2c at e66e8000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7795",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66e8000 0 0x40>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 918>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 918>;
+			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
 			status = "disabled";
 		};
 
-		ipmmu_pv3: mmu at fd970000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xfd970000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 9>;
+		i2c_dvfs: i2c at e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7795",
+				     "renesas,rcar-gen3-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 926>;
+			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-		ipmmu_ir: mmu at ff8b0000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xff8b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 3>;
-			power-domains = <&sysc R8A7795_PD_A3IR>;
-			#iommu-cells = <1>;
+		hscif0: serial at e6540000 {
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe6540000 0 96>;
+			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 520>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 520>;
 			status = "disabled";
 		};
 
-		ipmmu_hc: mmu at e6570000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xe6570000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 2>;
+		hscif1: serial at e6550000 {
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe6550000 0 96>;
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 519>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 519>;
 			status = "disabled";
 		};
 
-		ipmmu_rt: mmu at ffc80000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xffc80000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 10>;
+		hscif2: serial at e6560000 {
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe6560000 0 96>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 518>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 518>;
 			status = "disabled";
 		};
 
-		ipmmu_mp0: mmu at ec670000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xec670000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 4>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+		hscif3: serial at e66a0000 {
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe66a0000 0 96>;
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 517>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 517>;
 			status = "disabled";
 		};
 
-		ipmmu_ds0: mmu at e6740000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xe6740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
+		hscif4: serial at e66b0000 {
+			compatible = "renesas,hscif-r8a7795",
+				     "renesas,rcar-gen3-hscif",
+				     "renesas,hscif";
+			reg = <0 0xe66b0000 0 96>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 516>,
+				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 516>;
+			status = "disabled";
 		};
 
-		ipmmu_ds1: mmu at e7740000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xe7740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 1>;
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7795",
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
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 704>;
+			status = "disabled";
 		};
 
-		ipmmu_mm: mmu at e67b0000 {
-			compatible = "renesas,ipmmu-r8a7795";
-			reg = <0 0xe67b0000 0 0x1000>;
-			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+		hsusb3: usb at e659c000 {
+			compatible = "renesas,usbhs-r8a7795",
+				     "renesas,rcar-gen3-usbhs";
+			reg = <0 0xe659c000 0 0x100>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 705>;
+			dmas = <&usb_dmac2 0>, <&usb_dmac2 1>,
+			       <&usb_dmac3 0>, <&usb_dmac3 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <11>;
+			phys = <&usb2_phy3>;
+			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
+			resets = <&cpg 705>;
+			status = "disabled";
+		};
+
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a7795-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a7795-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac2: dma-controller at e6460000 {
+			compatible = "renesas,r8a7795-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe6460000 0 0x100>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 326>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 326>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac3: dma-controller at e6470000 {
+			compatible = "renesas,r8a7795-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe6470000 0 0x100>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 329>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb3_phy0: usb-phy at e65ee000 {
+			compatible = "renesas,r8a7795-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
+			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			#phy-cells = <0>;
+			status = "disabled";
 		};
 
 		dmac0: dma-controller at e6700000 {
@@ -750,457 +919,316 @@
 			       <&ipmmu_ds1 30>, <&ipmmu_ds1 31>;
 		};
 
-		audma0: dma-controller at ec700000 {
-			compatible = "renesas,dmac-r8a7795",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec700000 0 0x10000>;
-			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15";
-			clocks = <&cpg CPG_MOD 502>;
-			clock-names = "fck";
+		ipmmu_ds0: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 502>;
-			#dma-cells = <1>;
-			dma-channels = <16>;
-			iommus = <&ipmmu_mp0 0>, <&ipmmu_mp0 1>,
-			       <&ipmmu_mp0 2>, <&ipmmu_mp0 3>,
-			       <&ipmmu_mp0 4>, <&ipmmu_mp0 5>,
-			       <&ipmmu_mp0 6>, <&ipmmu_mp0 7>,
-			       <&ipmmu_mp0 8>, <&ipmmu_mp0 9>,
-			       <&ipmmu_mp0 10>, <&ipmmu_mp0 11>,
-			       <&ipmmu_mp0 12>, <&ipmmu_mp0 13>,
-			       <&ipmmu_mp0 14>, <&ipmmu_mp0 15>;
+			#iommu-cells = <1>;
 		};
 
-		audma1: dma-controller at ec720000 {
-			compatible = "renesas,dmac-r8a7795",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec720000 0 0x10000>;
-			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					"ch0", "ch1", "ch2", "ch3",
-					"ch4", "ch5", "ch6", "ch7",
-					"ch8", "ch9", "ch10", "ch11",
-					"ch12", "ch13", "ch14", "ch15";
-			clocks = <&cpg CPG_MOD 501>;
-			clock-names = "fck";
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 501>;
-			#dma-cells = <1>;
-			dma-channels = <16>;
-			iommus = <&ipmmu_mp0 16>, <&ipmmu_mp0 17>,
-			       <&ipmmu_mp0 18>, <&ipmmu_mp0 19>,
-			       <&ipmmu_mp0 20>, <&ipmmu_mp0 21>,
-			       <&ipmmu_mp0 22>, <&ipmmu_mp0 23>,
-			       <&ipmmu_mp0 24>, <&ipmmu_mp0 25>,
-			       <&ipmmu_mp0 26>, <&ipmmu_mp0 27>,
-			       <&ipmmu_mp0 28>, <&ipmmu_mp0 29>,
-			       <&ipmmu_mp0 30>, <&ipmmu_mp0 31>;
+			#iommu-cells = <1>;
 		};
 
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a7795",
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
+		ipmmu_hc: mmu at e6570000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 812>;
-			phy-mode = "rgmii";
-			iommus = <&ipmmu_ds0 16>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		can0: can at e6c30000 {
-			compatible = "renesas,can-r8a7795",
-				     "renesas,rcar-gen3-can";
-			reg = <0 0xe6c30000 0 0x1000>;
-			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>,
-			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 916>;
+		ipmmu_ir: mmu at ff8b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xff8b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			power-domains = <&sysc R8A7795_PD_A3IR>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		can1: can at e6c38000 {
-			compatible = "renesas,can-r8a7795",
-				     "renesas,rcar-gen3-can";
-			reg = <0 0xe6c38000 0 0x1000>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>,
-			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 915>;
-			status = "disabled";
+			#iommu-cells = <1>;
 		};
 
-		canfd: can at e66c0000 {
-			compatible = "renesas,r8a7795-canfd",
-				     "renesas,rcar-gen3-canfd";
-			reg = <0 0xe66c0000 0 0x8000>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
-				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 914>,
-			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "fck", "canfd", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
+		ipmmu_mp0: mmu at ec670000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 914>;
+			#iommu-cells = <1>;
 			status = "disabled";
-
-			channel0 {
-				status = "disabled";
-			};
-
-			channel1 {
-				status = "disabled";
-			};
 		};
 
-		drif00: rif at e6f40000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f40000 0 0x64>;
-			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 515>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x20>, <&dmac2 0x20>;
-			dma-names = "rx", "rx";
+		ipmmu_pv0: mmu at fd800000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 515>;
-			renesas,bonding = <&drif01>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		drif01: rif at e6f50000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f50000 0 0x64>;
-			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 514>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x22>, <&dmac2 0x22>;
-			dma-names = "rx", "rx";
+		ipmmu_pv2: mmu at fd960000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfd960000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 8>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 514>;
-			renesas,bonding = <&drif00>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		drif10: rif at e6f60000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f60000 0 0x64>;
-			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 513>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x24>, <&dmac2 0x24>;
-			dma-names = "rx", "rx";
+		ipmmu_pv3: mmu at fd970000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfd970000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 513>;
-			renesas,bonding = <&drif11>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		drif11: rif at e6f70000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f70000 0 0x64>;
-			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 512>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x26>, <&dmac2 0x26>;
-			dma-names = "rx", "rx";
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 10>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 512>;
-			renesas,bonding = <&drif10>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		drif20: rif at e6f80000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f80000 0 0x64>;
-			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 511>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x28>, <&dmac2 0x28>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 511>;
-			renesas,bonding = <&drif21>;
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			power-domains = <&sysc R8A7795_PD_A3VC>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		drif21: rif at e6f90000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f90000 0 0x64>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 510>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x2a>, <&dmac2 0x2a>;
-			dma-names = "rx", "rx";
+		ipmmu_vc1: mmu at fe6f0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe6f0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 13>;
+			power-domains = <&sysc R8A7795_PD_A3VC>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 510>;
-			renesas,bonding = <&drif20>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi1: mmu at febe0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfebe0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 15>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		drif30: rif at e6fa0000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6fa0000 0 0x64>;
-			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 509>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x2c>, <&dmac2 0x2c>;
-			dma-names = "rx", "rx";
+		ipmmu_vp0: mmu at fe990000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe990000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vp1: mmu at fe980000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xfe980000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 17>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			#iommu-cells = <1>;
+		};
+
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7795",
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
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 509>;
-			renesas,bonding = <&drif31>;
+			resets = <&cpg 812>;
+			phy-mode = "rgmii";
+			iommus = <&ipmmu_ds0 16>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		drif31: rif at e6fb0000 {
-			compatible = "renesas,r8a7795-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6fb0000 0 0x64>;
-			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 508>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x2e>, <&dmac2 0x2e>;
-			dma-names = "rx", "rx";
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a7795",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 508>;
-			renesas,bonding = <&drif30>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
-		hscif0: serial at e6540000 {
-			compatible = "renesas,hscif-r8a7795",
-				     "renesas,rcar-gen3-hscif",
-				     "renesas,hscif";
-			reg = <0 0xe6540000 0 96>;
-			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 520>,
-				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x31>, <&dmac1 0x30>;
-			dma-names = "tx", "rx";
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a7795",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 520>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
-		hscif1: serial at e6550000 {
-			compatible = "renesas,hscif-r8a7795",
-				     "renesas,rcar-gen3-hscif",
-				     "renesas,hscif";
-			reg = <0 0xe6550000 0 96>;
-			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 519>,
-				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x33>, <&dmac1 0x32>;
-			dma-names = "tx", "rx";
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a7795-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A7795_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7795_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 519>;
+			resets = <&cpg 914>;
 			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
 		};
 
-		hscif2: serial at e6560000 {
-			compatible = "renesas,hscif-r8a7795",
-				     "renesas,rcar-gen3-hscif",
-				     "renesas,hscif";
-			reg = <0 0xe6560000 0 96>;
-			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 518>,
-				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x35>, <&dmac1 0x34>;
-			dma-names = "tx", "rx";
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 518>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
-		hscif3: serial at e66a0000 {
-			compatible = "renesas,hscif-r8a7795",
-				     "renesas,rcar-gen3-hscif",
-				     "renesas,hscif";
-			reg = <0 0xe66a0000 0 96>;
-			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 517>,
-				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x37>, <&dmac0 0x36>;
-			dma-names = "tx", "rx";
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 517>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
-		hscif4: serial at e66b0000 {
-			compatible = "renesas,hscif-r8a7795",
-				     "renesas,rcar-gen3-hscif",
-				     "renesas,hscif";
-			reg = <0 0xe66b0000 0 96>;
-			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 516>,
-				 <&cpg CPG_CORE R8A7795_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x39>, <&dmac0 0x38>;
-			dma-names = "tx", "rx";
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 516>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
-		msiof0: spi at e6e90000 {
-			compatible = "renesas,msiof-r8a7795",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6e90000 0 0x0064>;
-			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 211>;
-			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
-			       <&dmac2 0x41>, <&dmac2 0x40>;
-			dma-names = "tx", "rx", "tx", "rx";
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 211>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
-		msiof1: spi at e6ea0000 {
-			compatible = "renesas,msiof-r8a7795",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6ea0000 0 0x0064>;
-			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 210>;
-			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
-			       <&dmac2 0x43>, <&dmac2 0x42>;
-			dma-names = "tx", "rx", "tx", "rx";
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 210>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
-		msiof2: spi at e6c00000 {
-			compatible = "renesas,msiof-r8a7795",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6c00000 0 0x0064>;
-			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 209>;
-			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
-			dma-names = "tx", "rx";
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 209>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
-		msiof3: spi at e6c10000 {
-			compatible = "renesas,msiof-r8a7795",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6c10000 0 0x0064>;
-			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 208>;
-			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
-			dma-names = "tx", "rx";
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			clocks = <&cpg CPG_MOD 523>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 208>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 523>;
+			#pwm-cells = <2>;
 			status = "disabled";
 		};
 
@@ -1300,201 +1328,185 @@
 			status = "disabled";
 		};
 
-		i2c_dvfs: i2c at e60b0000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,iic-r8a7795",
-				     "renesas,rcar-gen3-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe60b0000 0 0x425>;
-			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 926>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 926>;
-			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		i2c0: i2c at e6500000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe6500000 0 0x40>;
-			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 931>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 931>;
-			dmas = <&dmac1 0x91>, <&dmac1 0x90>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <110>;
-			status = "disabled";
-		};
-
-		i2c1: i2c at e6508000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe6508000 0 0x40>;
-			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 930>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 930>;
-			dmas = <&dmac1 0x93>, <&dmac1 0x92>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
-		};
-
-		i2c2: i2c at e6510000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe6510000 0 0x40>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 929>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 929>;
-			dmas = <&dmac1 0x95>, <&dmac1 0x94>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
-		};
-
-		i2c3: i2c at e66d0000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe66d0000 0 0x40>;
-			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 928>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 928>;
-			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <110>;
+		msiof0: spi at e6e90000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6e90000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 211>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
+			       <&dmac2 0x41>, <&dmac2 0x40>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 211>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		i2c4: i2c at e66d8000 {
+		msiof1: spi at e6ea0000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6ea0000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 210>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
+			       <&dmac2 0x43>, <&dmac2 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 210>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe66d8000 0 0x40>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 927>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 927>;
-			dmas = <&dmac0 0x99>, <&dmac0 0x98>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
-		i2c5: i2c at e66e0000 {
+		msiof2: spi at e6c00000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 209>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 209>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe66e0000 0 0x40>;
-			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 919>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 919>;
-			dmas = <&dmac0 0x9b>, <&dmac0 0x9a>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <110>;
 			status = "disabled";
 		};
 
-		i2c6: i2c at e66e8000 {
+		msiof3: spi at e6c10000 {
+			compatible = "renesas,msiof-r8a7795",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c10000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a7795",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe66e8000 0 0x40>;
-			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 918>;
+			status = "disabled";
+		};
+
+		drif00: rif at e6f40000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f40000 0 0x64>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 515>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x20>, <&dmac2 0x20>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 918>;
-			dmas = <&dmac0 0x9d>, <&dmac0 0x9c>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 515>;
+			renesas,bonding = <&drif01>;
 			status = "disabled";
 		};
 
-		pwm0: pwm at e6e30000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e30000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif01: rif at e6f50000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f50000 0 0x64>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 514>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x22>, <&dmac2 0x22>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 514>;
+			renesas,bonding = <&drif00>;
 			status = "disabled";
 		};
 
-		pwm1: pwm at e6e31000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e31000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif10: rif at e6f60000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f60000 0 0x64>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 513>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x24>, <&dmac2 0x24>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 513>;
+			renesas,bonding = <&drif11>;
 			status = "disabled";
 		};
 
-		pwm2: pwm at e6e32000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e32000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif11: rif at e6f70000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f70000 0 0x64>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 512>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x26>, <&dmac2 0x26>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 512>;
+			renesas,bonding = <&drif10>;
 			status = "disabled";
 		};
 
-		pwm3: pwm at e6e33000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e33000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif20: rif at e6f80000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f80000 0 0x64>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 511>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x28>, <&dmac2 0x28>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 511>;
+			renesas,bonding = <&drif21>;
 			status = "disabled";
 		};
 
-		pwm4: pwm at e6e34000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e34000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif21: rif at e6f90000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f90000 0 0x64>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 510>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x2a>, <&dmac2 0x2a>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 510>;
+			renesas,bonding = <&drif20>;
 			status = "disabled";
 		};
 
-		pwm5: pwm at e6e35000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e35000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif30: rif at e6fa0000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6fa0000 0 0x64>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 509>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x2c>, <&dmac2 0x2c>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 509>;
+			renesas,bonding = <&drif31>;
 			status = "disabled";
 		};
 
-		pwm6: pwm at e6e36000 {
-			compatible = "renesas,pwm-r8a7795", "renesas,pwm-rcar";
-			reg = <0 0xe6e36000 0 0x8>;
-			clocks = <&cpg CPG_MOD 523>;
+		drif31: rif at e6fb0000 {
+			compatible = "renesas,r8a7795-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6fb0000 0 0x64>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 508>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x2e>, <&dmac2 0x2e>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 523>;
-			#pwm-cells = <2>;
+			resets = <&cpg 508>;
+			renesas,bonding = <&drif30>;
 			status = "disabled";
 		};
 
@@ -1694,29 +1706,88 @@
 			};
 		};
 
-		sata: sata at ee300000 {
-			compatible = "renesas,sata-r8a7795",
-				     "renesas,rcar-gen3-sata";
-			reg = <0 0xee300000 0 0x200000>;
-			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 815>;
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,dmac-r8a7795",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 815>;
-			status = "disabled";
-			iommus = <&ipmmu_hc 2>;
+			resets = <&cpg 502>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			iommus = <&ipmmu_mp0 0>, <&ipmmu_mp0 1>,
+			       <&ipmmu_mp0 2>, <&ipmmu_mp0 3>,
+			       <&ipmmu_mp0 4>, <&ipmmu_mp0 5>,
+			       <&ipmmu_mp0 6>, <&ipmmu_mp0 7>,
+			       <&ipmmu_mp0 8>, <&ipmmu_mp0 9>,
+			       <&ipmmu_mp0 10>, <&ipmmu_mp0 11>,
+			       <&ipmmu_mp0 12>, <&ipmmu_mp0 13>,
+			       <&ipmmu_mp0 14>, <&ipmmu_mp0 15>;
 		};
 
-		usb3_phy0: usb-phy at e65ee000 {
-			compatible = "renesas,r8a7795-usb3-phy",
-				     "renesas,rcar-gen3-usb3-phy";
-			reg = <0 0xe65ee000 0 0x90>;
-			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
-				 <&usb_extal_clk>;
-			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+		audma1: dma-controller at ec720000 {
+			compatible = "renesas,dmac-r8a7795",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+			clocks = <&cpg CPG_MOD 501>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
-			#phy-cells = <0>;
-			status = "disabled";
+			resets = <&cpg 501>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			iommus = <&ipmmu_mp0 16>, <&ipmmu_mp0 17>,
+			       <&ipmmu_mp0 18>, <&ipmmu_mp0 19>,
+			       <&ipmmu_mp0 20>, <&ipmmu_mp0 21>,
+			       <&ipmmu_mp0 22>, <&ipmmu_mp0 23>,
+			       <&ipmmu_mp0 24>, <&ipmmu_mp0 25>,
+			       <&ipmmu_mp0 26>, <&ipmmu_mp0 27>,
+			       <&ipmmu_mp0 28>, <&ipmmu_mp0 29>,
+			       <&ipmmu_mp0 30>, <&ipmmu_mp0 31>;
 		};
 
 		xhci0: usb at ee000000 {
@@ -1740,153 +1811,51 @@
 			status = "disabled";
 		};
 
-		usb_dmac0: dma-controller at e65a0000 {
-			compatible = "renesas,r8a7795-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65a0000 0 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 330>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
-		};
-
-		usb_dmac1: dma-controller at e65b0000 {
-			compatible = "renesas,r8a7795-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65b0000 0 0x100>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 331>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
-		};
-
-		usb_dmac2: dma-controller at e6460000 {
-			compatible = "renesas,r8a7795-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe6460000 0 0x100>;
-			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 326>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 326>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
-		};
-
-		usb_dmac3: dma-controller at e6470000 {
-			compatible = "renesas,r8a7795-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe6470000 0 0x100>;
-			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 329>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 329>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
-		};
-
-		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7795",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee100000 0 0x2000>;
-			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 314>;
-			max-frequency = <200000000>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 314>;
-			status = "disabled";
-		};
-
-		sdhi1: sd at ee120000 {
-			compatible = "renesas,sdhi-r8a7795",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee120000 0 0x2000>;
-			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 313>;
-			max-frequency = <200000000>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 313>;
-			status = "disabled";
-		};
-
-		sdhi2: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7795",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee140000 0 0x2000>;
-			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
-			max-frequency = <200000000>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 312>;
-			status = "disabled";
-		};
-
-		sdhi3: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7795",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee160000 0 0x2000>;
-			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 311>;
-			max-frequency = <200000000>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 311>;
-			status = "disabled";
-		};
-
-		usb2_phy0: usb-phy at ee080200 {
-			compatible = "renesas,usb2-phy-r8a7795",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee080200 0 0x700>;
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
-			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		usb2_phy1: usb-phy at ee0a0200 {
-			compatible = "renesas,usb2-phy-r8a7795",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee0a0200 0 0x700>;
+		ohci1: usb at ee0a0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
-			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		usb2_phy2: usb-phy at ee0c0200 {
-			compatible = "renesas,usb2-phy-r8a7795",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee0c0200 0 0x700>;
+		ohci2: usb at ee0c0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0c0000 0 0x100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 701>;
+			phys = <&usb2_phy2>;
+			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 701>;
-			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		usb2_phy3: usb-phy at ee0e0200 {
-			compatible = "renesas,usb2-phy-r8a7795",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee0e0200 0 0x700>;
+		ohci3: usb at ee0e0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0e0000 0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 700>;
+			phys = <&usb2_phy3>;
+			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 700>;
-			#phy-cells = <0>;
 			status = "disabled";
 		};
 
@@ -1942,86 +1911,110 @@
 			status = "disabled";
 		};
 
-		ohci0: usb at ee080000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee080000 0 0x100>;
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a7795",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
-			phys = <&usb2_phy0>;
-			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
+			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		ohci1: usb at ee0a0000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee0a0000 0 0x100>;
-			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		usb2_phy1: usb-phy at ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a7795",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0a0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 702>;
-			phys = <&usb2_phy1>;
-			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 702>;
+			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		ohci2: usb at ee0c0000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee0c0000 0 0x100>;
-			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		usb2_phy2: usb-phy at ee0c0200 {
+			compatible = "renesas,usb2-phy-r8a7795",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0c0200 0 0x700>;
 			clocks = <&cpg CPG_MOD 701>;
-			phys = <&usb2_phy2>;
-			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
 			resets = <&cpg 701>;
+			#phy-cells = <0>;
 			status = "disabled";
 		};
 
-		ohci3: usb at ee0e0000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee0e0000 0 0x100>;
+		usb2_phy3: usb-phy at ee0e0200 {
+			compatible = "renesas,usb2-phy-r8a7795",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0e0200 0 0x700>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 700>;
-			phys = <&usb2_phy3>;
-			phy-names = "usb";
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 700>;
+			resets = <&cpg 700>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7795",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a7795",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7795",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
 			status = "disabled";
 		};
 
-		hsusb: usb at e6590000 {
-			compatible = "renesas,usbhs-r8a7795",
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
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7795",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 311>;
 			status = "disabled";
 		};
 
-		hsusb3: usb at e659c000 {
-			compatible = "renesas,usbhs-r8a7795",
-				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe659c000 0 0x100>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 705>;
-			dmas = <&usb_dmac2 0>, <&usb_dmac2 1>,
-			       <&usb_dmac3 0>, <&usb_dmac3 1>;
-			dma-names = "ch0", "ch1", "ch2", "ch3";
-			renesas,buswait = <11>;
-			phys = <&usb2_phy3>;
-			phy-names = "usb";
+		sata: sata at ee300000 {
+			compatible = "renesas,sata-r8a7795",
+				     "renesas,rcar-gen3-sata";
+			reg = <0 0xee300000 0 0x200000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 815>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 705>;
+			resets = <&cpg 815>;
 			status = "disabled";
+			iommus = <&ipmmu_hc 2>;
 		};
 
 		pciec0: pcie at fe000000 {
@@ -2078,6 +2071,23 @@
 			status = "disabled";
 		};
 
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
+					(GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
 		imr-lx4 at fe860000 {
 			compatible = "renesas,r8a7795-imr-lx4",
 				     "renesas,imr-lx4";
@@ -2118,24 +2128,24 @@
 			resets = <&cpg 820>;
 		};
 
-		vspbc: vsp at fe920000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe920000 0 0x8000>;
-			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 624>;
+		fdp1 at fe940000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe940000 0 0x2400>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 119>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 624>;
-
-			renesas,fcp = <&fcpvb1>;
+			resets = <&cpg 119>;
+			renesas,fcp = <&fcpf0>;
 		};
 
-		fcpvb1: fcp at fe92f000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfe92f000 0 0x200>;
-			clocks = <&cpg CPG_MOD 606>;
+		fdp1 at fe944000 {
+			compatible = "renesas,fdp1";
+			reg = <0 0xfe944000 0 0x2400>;
+			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 118>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 606>;
-			iommus = <&ipmmu_vp1 7>;
+			resets = <&cpg 118>;
+			renesas,fcp = <&fcpf1>;
 		};
 
 		fcpf0: fcp at fe950000 {
@@ -2156,17 +2166,6 @@
 			iommus = <&ipmmu_vp1 1>;
 		};
 
-		vspbd: vsp at fe960000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe960000 0 0x8000>;
-			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 626>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 626>;
-
-			renesas,fcp = <&fcpvb0>;
-		};
-
 		fcpvb0: fcp at fe96f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
@@ -2176,15 +2175,13 @@
 			iommus = <&ipmmu_vp0 5>;
 		};
 
-		vspi0: vsp at fe9a0000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe9a0000 0 0x8000>;
-			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 631>;
+		fcpvb1: fcp at fe92f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfe92f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 606>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 631>;
-
-			renesas,fcp = <&fcpvi0>;
+			resets = <&cpg 606>;
+			iommus = <&ipmmu_vp1 7>;
 		};
 
 		fcpvi0: fcp at fe9af000 {
@@ -2196,17 +2193,6 @@
 			iommus = <&ipmmu_vp0 8>;
 		};
 
-		vspi1: vsp at fe9b0000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe9b0000 0 0x8000>;
-			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 630>;
-			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 630>;
-
-			renesas,fcp = <&fcpvi1>;
-		};
-
 		fcpvi1: fcp at fe9bf000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe9bf000 0 0x200>;
@@ -2216,6 +2202,55 @@
 			iommus = <&ipmmu_vp1 9>;
 		};
 
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
+		};
+
+		fcpvd1: fcp at fea2f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea2f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 602>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
+		};
+
+		fcpvd2: fcp at fea37000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea37000 0 0x200>;
+			clocks = <&cpg CPG_MOD 601>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 601>;
+			iommus = <&ipmmu_vi1 10>;
+		};
+
+		vspbd: vsp at fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 626>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 626>;
+
+			renesas,fcp = <&fcpvb0>;
+		};
+
+		vspbc: vsp at fe920000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe920000 0 0x8000>;
+			interrupts = <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 624>;
+			power-domains = <&sysc R8A7795_PD_A3VP>;
+			resets = <&cpg 624>;
+
+			renesas,fcp = <&fcpvb1>;
+		};
+
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea20000 0 0x8000>;
@@ -2227,15 +2262,6 @@
 			renesas,fcp = <&fcpvd0>;
 		};
 
-		fcpvd0: fcp at fea27000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea27000 0 0x200>;
-			clocks = <&cpg CPG_MOD 603>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 603>;
-			iommus = <&ipmmu_vi0 8>;
-		};
-
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea28000 0 0x8000>;
@@ -2247,15 +2273,6 @@
 			renesas,fcp = <&fcpvd1>;
 		};
 
-		fcpvd1: fcp at fea2f000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea2f000 0 0x200>;
-			clocks = <&cpg CPG_MOD 602>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 602>;
-			iommus = <&ipmmu_vi0 9>;
-		};
-
 		vspd2: vsp at fea30000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea30000 0 0x8000>;
@@ -2267,33 +2284,26 @@
 			renesas,fcp = <&fcpvd2>;
 		};
 
-		fcpvd2: fcp at fea37000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea37000 0 0x200>;
-			clocks = <&cpg CPG_MOD 601>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 601>;
-			iommus = <&ipmmu_vi1 10>;
-		};
-
-		fdp1 at fe940000 {
-			compatible = "renesas,fdp1";
-			reg = <0 0xfe940000 0 0x2400>;
-			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 119>;
+		vspi0: vsp at fe9a0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9a0000 0 0x8000>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 631>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 119>;
-			renesas,fcp = <&fcpf0>;
+			resets = <&cpg 631>;
+
+			renesas,fcp = <&fcpvi0>;
 		};
 
-		fdp1 at fe944000 {
-			compatible = "renesas,fdp1";
-			reg = <0 0xfe944000 0 0x2400>;
-			interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 118>;
+		vspi1: vsp at fe9b0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9b0000 0 0x8000>;
+			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 630>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
-			resets = <&cpg 118>;
-			renesas,fcp = <&fcpf1>;
+			resets = <&cpg 630>;
+
+			renesas,fcp = <&fcpvi1>;
 		};
 
 		hdmi0: hdmi at fead0000 {
@@ -2393,19 +2403,9 @@
 			};
 		};
 
-		tsc: thermal at e6198000 {
-			compatible = "renesas,r8a7795-thermal";
-			reg = <0 0xe6198000 0 0x100>,
-			      <0 0xe61a0000 0 0x100>,
-			      <0 0xe61a8000 0 0x100>;
-			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 522>;
-			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-			resets = <&cpg 522>;
-			#thermal-sensor-cells = <1>;
-			status = "okay";
+		prr: chipid at fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
 		};
 	};
 
-- 
2.11.0
