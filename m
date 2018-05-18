From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:32 +0200
Subject: [PATCH 010/102] arm64: dts: renesas: r8a7796: sort subnodes of the
 soc node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <3684a030bd0fded121bbce9af0d2126fe894d700.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort subnodes of the soc node.
- The primary key is the bus address.
- The secondary key is the IP block.
- The tertiary key is the node name.

This is part of an ongoing effort to provide consistent node
order in the DT of Renesas SoCs to improve maintainability.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 1824 +++++++++++++++---------------
 1 file changed, 912 insertions(+), 912 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 78fbb4fd34bf..55a64169d3d4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -269,23 +269,6 @@
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
-					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		wdt0: watchdog at e6020000 {
 			compatible = "renesas,r8a7796-wdt",
 				     "renesas,rcar-gen3-wdt";
@@ -421,100 +404,6 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
-		ipmmu_vi0: mmu at febd0000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xfebd0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 9>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_vc0: mmu at fe6b0000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xfe6b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 8>;
-			power-domains = <&sysc R8A7796_PD_A3VC>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_pv0: mmu at fd800000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xfd800000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 5>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_pv1: mmu at fd950000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xfd950000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 6>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_ir: mmu at ff8b0000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xff8b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 3>;
-			power-domains = <&sysc R8A7796_PD_A3IR>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_hc: mmu at e6570000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xe6570000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 2>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_rt: mmu at ffc80000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xffc80000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 7>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_mp: mmu at ec670000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xec670000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 4>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_ds0: mmu at e6740000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xe6740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_ds1: mmu at e7740000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xe7740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 1>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_mm: mmu at e67b0000 {
-			compatible = "renesas,ipmmu-r8a7796";
-			reg = <0 0xe67b0000 0 0x1000>;
-			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7796-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -530,17 +419,27 @@
 			reg = <0 0xe6160000 0 0x0200>;
 		};
 
-		prr: chipid at fff00044 {
-			compatible = "renesas,prr";
-			reg = <0 0xfff00044 0 4>;
-		};
-
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7796-sysc";
 			reg = <0 0xe6180000 0 0x0400>;
 			#power-domain-cells = <1>;
 		};
 
+		tsc: thermal at e6198000 {
+			compatible = "renesas,r8a7796-thermal";
+			reg = <0 0xe6198000 0 0x100>,
+			      <0 0xe61a0000 0 0x100>,
+			      <0 0xe61a8000 0 0x100>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
+			#thermal-sensor-cells = <1>;
+			status = "okay";
+		};
+
 		intc_ex: interrupt-controller at e61c0000 {
 			compatible = "renesas,intc-ex-r8a7796", "renesas,irqc";
 			#interrupt-cells = <2>;
@@ -557,92 +456,6 @@
 			resets = <&cpg 407>;
 		};
 
-		i2c_dvfs: i2c at e60b0000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,iic-r8a7796",
-				     "renesas,rcar-gen3-iic",
-				     "renesas,rmobile-iic";
-			reg = <0 0xe60b0000 0 0x425>;
-			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 926>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 926>;
-			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
-			dma-names = "tx", "rx";
-			status = "disabled";
-		};
-
-		pwm0: pwm at e6e30000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e30000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
-		pwm1: pwm at e6e31000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e31000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
-		pwm2: pwm at e6e32000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e32000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
-		pwm3: pwm at e6e33000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e33000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
-		pwm4: pwm at e6e34000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e34000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
-		pwm5: pwm at e6e35000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e35000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
-		pwm6: pwm at e6e36000 {
-			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
-			reg = <0 0xe6e36000 0 8>;
-			#pwm-cells = <2>;
-			clocks = <&cpg CPG_MOD 523>;
-			resets = <&cpg 523>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			status = "disabled";
-		};
-
 		i2c0: i2c at e6500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -758,226 +571,19 @@
 			status = "disabled";
 		};
 
-		can0: can at e6c30000 {
-			compatible = "renesas,can-r8a7796",
-				     "renesas,rcar-gen3-can";
-			reg = <0 0xe6c30000 0 0x1000>;
-			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>,
-			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
+		i2c_dvfs: i2c at e60b0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7796",
+				     "renesas,rcar-gen3-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 926>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 916>;
-			status = "disabled";
-		};
-
-		can1: can at e6c38000 {
-			compatible = "renesas,can-r8a7796",
-				     "renesas,rcar-gen3-can";
-			reg = <0 0xe6c38000 0 0x1000>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>,
-			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 915>;
-			status = "disabled";
-		};
-
-		canfd: can at e66c0000 {
-			compatible = "renesas,r8a7796-canfd",
-				     "renesas,rcar-gen3-canfd";
-			reg = <0 0xe66c0000 0 0x8000>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
-				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 914>,
-			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "fck", "canfd", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 914>;
-			status = "disabled";
-
-			channel0 {
-				status = "disabled";
-			};
-
-			channel1 {
-				status = "disabled";
-			};
-		};
-
-		drif00: rif at e6f40000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f40000 0 0x64>;
-			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 515>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x20>, <&dmac2 0x20>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 515>;
-			renesas,bonding = <&drif01>;
-			status = "disabled";
-		};
-
-		drif01: rif at e6f50000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f50000 0 0x64>;
-			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 514>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x22>, <&dmac2 0x22>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 514>;
-			renesas,bonding = <&drif00>;
-			status = "disabled";
-		};
-
-		drif10: rif at e6f60000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f60000 0 0x64>;
-			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 513>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x24>, <&dmac2 0x24>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 513>;
-			renesas,bonding = <&drif11>;
-			status = "disabled";
-		};
-
-		drif11: rif at e6f70000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f70000 0 0x64>;
-			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 512>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x26>, <&dmac2 0x26>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 512>;
-			renesas,bonding = <&drif10>;
-			status = "disabled";
-		};
-
-		drif20: rif at e6f80000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f80000 0 0x64>;
-			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 511>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x28>, <&dmac2 0x28>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 511>;
-			renesas,bonding = <&drif21>;
-			status = "disabled";
-		};
-
-		drif21: rif at e6f90000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6f90000 0 0x64>;
-			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 510>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x2a>, <&dmac2 0x2a>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 510>;
-			renesas,bonding = <&drif20>;
-			status = "disabled";
-		};
-
-		drif30: rif at e6fa0000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6fa0000 0 0x64>;
-			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 509>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x2c>, <&dmac2 0x2c>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 509>;
-			renesas,bonding = <&drif31>;
-			status = "disabled";
-		};
-
-		drif31: rif at e6fb0000 {
-			compatible = "renesas,r8a7796-drif",
-				     "renesas,rcar-gen3-drif";
-			reg = <0 0xe6fb0000 0 0x64>;
-			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 508>;
-			clock-names = "fck";
-			dmas = <&dmac1 0x2e>, <&dmac2 0x2e>;
-			dma-names = "rx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 508>;
-			renesas,bonding = <&drif30>;
-			status = "disabled";
-		};
-
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a7796",
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
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 812>;
-			phy-mode = "rgmii";
-			iommus = <&ipmmu_ds0 16>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 926>;
+			dmas = <&dmac0 0x11>, <&dmac0 0x10>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -1069,162 +675,61 @@
 			status = "disabled";
 		};
 
-		scif0: serial at e6e60000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e60000 0 64>;
-			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 207>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
-			       <&dmac2 0x51>, <&dmac2 0x50>;
-			dma-names = "tx", "rx", "tx", "rx";
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
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 207>;
+			resets = <&cpg 704>;
 			status = "disabled";
 		};
 
-		scif1: serial at e6e68000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e68000 0 64>;
-			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 206>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
-			       <&dmac2 0x53>, <&dmac2 0x52>;
-			dma-names = "tx", "rx", "tx", "rx";
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a7796-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 206>;
-			status = "disabled";
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
 		};
 
-		scif2: serial at e6e88000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e88000 0 64>;
-			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 310>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 310>;
-			status = "disabled";
-		};
-
-		scif3: serial at e6c50000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6c50000 0 64>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 204>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
-			dma-names = "tx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 204>;
-			status = "disabled";
-		};
-
-		scif4: serial at e6c40000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6c40000 0 64>;
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 203>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
-			dma-names = "tx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 203>;
-			status = "disabled";
-		};
-
-		scif5: serial at e6f30000 {
-			compatible = "renesas,scif-r8a7796",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6f30000 0 64>;
-			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 202>,
-				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
-			       <&dmac2 0x5b>, <&dmac2 0x5a>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 202>;
-			status = "disabled";
-		};
-
-		msiof0: spi at e6e90000 {
-			compatible = "renesas,msiof-r8a7796",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6e90000 0 0x0064>;
-			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 211>;
-			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
-			       <&dmac2 0x41>, <&dmac2 0x40>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 211>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		msiof1: spi at e6ea0000 {
-			compatible = "renesas,msiof-r8a7796",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6ea0000 0 0x0064>;
-			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 210>;
-			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
-			       <&dmac2 0x43>, <&dmac2 0x42>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 210>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		msiof2: spi at e6c00000 {
-			compatible = "renesas,msiof-r8a7796",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6c00000 0 0x0064>;
-			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 209>;
-			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
-			dma-names = "tx", "rx";
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a7796-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 209>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
 		};
 
-		msiof3: spi at e6c10000 {
-			compatible = "renesas,msiof-r8a7796",
-				     "renesas,rcar-gen3-msiof";
-			reg = <0 0xe6c10000 0 0x0064>;
-			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 208>;
-			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
-			dma-names = "tx", "rx";
+		usb3_phy0: usb-phy at e65ee000 {
+			compatible = "renesas,r8a7796-usb3-phy",
+				     "renesas,rcar-gen3-usb3-phy";
+			reg = <0 0xe65ee000 0 0x90>;
+			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
+				 <&usb_extal_clk>;
+			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 208>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 328>;
+			#phy-cells = <0>;
 			status = "disabled";
 		};
 
@@ -1354,304 +859,550 @@
 			       <&ipmmu_ds1 30>, <&ipmmu_ds1 31>;
 		};
 
-		audma0: dma-controller at ec700000 {
-			compatible = "renesas,dmac-r8a7796",
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
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 502>;
-			#dma-cells = <1>;
-			dma-channels = <16>;
-			iommus = <&ipmmu_mp 0>, <&ipmmu_mp 1>,
-			       <&ipmmu_mp 2>, <&ipmmu_mp 3>,
-			       <&ipmmu_mp 4>, <&ipmmu_mp 5>,
-			       <&ipmmu_mp 6>, <&ipmmu_mp 7>,
-			       <&ipmmu_mp 8>, <&ipmmu_mp 9>,
-			       <&ipmmu_mp 10>, <&ipmmu_mp 11>,
-			       <&ipmmu_mp 12>, <&ipmmu_mp 13>,
-			       <&ipmmu_mp 14>, <&ipmmu_mp 15>;
+			#iommu-cells = <1>;
 		};
 
-		audma1: dma-controller at ec720000 {
-			compatible = "renesas,dmac-r8a7796",
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
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 501>;
-			#dma-cells = <1>;
-			dma-channels = <16>;
-			iommus = <&ipmmu_mp 16>, <&ipmmu_mp 17>,
-			       <&ipmmu_mp 18>, <&ipmmu_mp 19>,
-			       <&ipmmu_mp 20>, <&ipmmu_mp 21>,
-			       <&ipmmu_mp 22>, <&ipmmu_mp 23>,
-			       <&ipmmu_mp 24>, <&ipmmu_mp 25>,
-			       <&ipmmu_mp 26>, <&ipmmu_mp 27>,
-			       <&ipmmu_mp 28>, <&ipmmu_mp 29>,
-			       <&ipmmu_mp 30>, <&ipmmu_mp 31>;
+			#iommu-cells = <1>;
 		};
 
-		usb_dmac0: dma-controller at e65a0000 {
-			compatible = "renesas,r8a7796-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65a0000 0 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 330>;
+		ipmmu_hc: mmu at e6570000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 330>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		usb_dmac1: dma-controller at e65b0000 {
-			compatible = "renesas,r8a7796-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65b0000 0 0x100>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 331>;
+		ipmmu_ir: mmu at ff8b0000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xff8b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			power-domains = <&sysc R8A7796_PD_A3IR>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 331>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
+			#iommu-cells = <1>;
 		};
 
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
+		ipmmu_mp: mmu at ec670000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv0: mmu at fd800000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 5>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv1: mmu at fd950000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xfd950000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 7>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 8>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a7796";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7796",
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
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			phy-mode = "rgmii";
+			iommus = <&ipmmu_ds0 16>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a7796",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 916>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a7796",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
+
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a7796-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A7796_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A7796_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 914>;
+			status = "disabled";
+
+			channel0 {
+				status = "disabled";
+			};
+
+			channel1 {
+				status = "disabled";
+			};
+		};
+
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		scif0: serial at e6e60000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e60000 0 64>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 207>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x51>, <&dmac1 0x50>,
+			       <&dmac2 0x51>, <&dmac2 0x50>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 207>;
+			status = "disabled";
+		};
+
+		scif1: serial at e6e68000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e68000 0 64>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 206>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x53>, <&dmac1 0x52>,
+			       <&dmac2 0x53>, <&dmac2 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 206>;
+			status = "disabled";
+		};
+
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 310>;
+			status = "disabled";
+		};
+
+		scif3: serial at e6c50000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c50000 0 64>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 204>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 204>;
 			status = "disabled";
 		};
 
-		usb3_phy0: usb-phy at e65ee000 {
-			compatible = "renesas,r8a7796-usb3-phy",
-				     "renesas,rcar-gen3-usb3-phy";
-			reg = <0 0xe65ee000 0 0x90>;
-			clocks = <&cpg CPG_MOD 328>, <&usb3s0_clk>,
-				 <&usb_extal_clk>;
-			clock-names = "usb3-if", "usb3s_clk", "usb_extal";
+		scif4: serial at e6c40000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6c40000 0 64>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 203>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x59>, <&dmac0 0x58>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
-			#phy-cells = <0>;
+			resets = <&cpg 203>;
 			status = "disabled";
 		};
 
-		xhci0: usb at ee000000 {
-			compatible = "renesas,xhci-r8a7796",
-				     "renesas,rcar-gen3-xhci";
-			reg = <0 0xee000000 0 0xc00>;
-			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
+		scif5: serial at e6f30000 {
+			compatible = "renesas,scif-r8a7796",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6f30000 0 64>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 202>,
+				 <&cpg CPG_CORE R8A7796_CLK_S3D1>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
+			       <&dmac2 0x5b>, <&dmac2 0x5a>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
+			resets = <&cpg 202>;
 			status = "disabled";
 		};
 
-		usb3_peri0: usb at ee020000 {
-			compatible = "renesas,r8a7796-usb3-peri",
-				     "renesas,rcar-gen3-usb3-peri";
-			reg = <0 0xee020000 0 0x400>;
-			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 328>;
+		msiof0: spi at e6e90000 {
+			compatible = "renesas,msiof-r8a7796",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6e90000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 211>;
+			dmas = <&dmac1 0x41>, <&dmac1 0x40>,
+			       <&dmac2 0x41>, <&dmac2 0x40>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 328>;
+			resets = <&cpg 211>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		ohci0: usb at ee080000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee080000 0 0x100>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
-			phys = <&usb2_phy0>;
-			phy-names = "usb";
+		msiof1: spi at e6ea0000 {
+			compatible = "renesas,msiof-r8a7796",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6ea0000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 210>;
+			dmas = <&dmac1 0x43>, <&dmac1 0x42>,
+			       <&dmac2 0x43>, <&dmac2 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 210>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		ehci0: usb at ee080100 {
-			compatible = "generic-ehci";
-			reg = <0 0xee080100 0 0x100>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
-			phys = <&usb2_phy0>;
-			phy-names = "usb";
-			companion= <&ohci0>;
+		msiof2: spi at e6c00000 {
+			compatible = "renesas,msiof-r8a7796",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 209>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x44>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
+			resets = <&cpg 209>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		usb2_phy0: usb-phy at ee080200 {
-			compatible = "renesas,usb2-phy-r8a7796",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee080200 0 0x700>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 703>;
+		msiof3: spi at e6c10000 {
+			compatible = "renesas,msiof-r8a7796",
+				     "renesas,rcar-gen3-msiof";
+			reg = <0 0xe6c10000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x47>, <&dmac0 0x46>;
+			dma-names = "tx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 703>;
-			#phy-cells = <0>;
+			resets = <&cpg 208>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		ohci1: usb at ee0a0000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee0a0000 0 0x100>;
-			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 702>;
-			phys = <&usb2_phy1>;
-			phy-names = "usb";
+		drif00: rif at e6f40000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f40000 0 0x64>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 515>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x20>, <&dmac2 0x20>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 702>;
+			resets = <&cpg 515>;
+			renesas,bonding = <&drif01>;
 			status = "disabled";
 		};
 
-		ehci1: usb at ee0a0100 {
-			compatible = "generic-ehci";
-			reg = <0 0xee0a0100 0 0x100>;
-			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 702>;
-			phys = <&usb2_phy1>;
-			phy-names = "usb";
-			companion= <&ohci1>;
+		drif01: rif at e6f50000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f50000 0 0x64>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 514>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x22>, <&dmac2 0x22>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 702>;
+			resets = <&cpg 514>;
+			renesas,bonding = <&drif00>;
 			status = "disabled";
 		};
 
-		usb2_phy1: usb-phy at ee0a0200 {
-			compatible = "renesas,usb2-phy-r8a7796",
-				     "renesas,rcar-gen3-usb2-phy";
-			reg = <0 0xee0a0200 0 0x700>;
-			clocks = <&cpg CPG_MOD 702>;
+		drif10: rif at e6f60000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f60000 0 0x64>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 513>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x24>, <&dmac2 0x24>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 702>;
-			#phy-cells = <0>;
+			resets = <&cpg 513>;
+			renesas,bonding = <&drif11>;
 			status = "disabled";
 		};
 
-		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7796",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee100000 0 0x2000>;
-			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 314>;
-			max-frequency = <200000000>;
+		drif11: rif at e6f70000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f70000 0 0x64>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 512>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x26>, <&dmac2 0x26>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 314>;
+			resets = <&cpg 512>;
+			renesas,bonding = <&drif10>;
 			status = "disabled";
 		};
 
-		sdhi1: sd at ee120000 {
-			compatible = "renesas,sdhi-r8a7796",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee120000 0 0x2000>;
-			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 313>;
-			max-frequency = <200000000>;
+		drif20: rif at e6f80000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f80000 0 0x64>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 511>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x28>, <&dmac2 0x28>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 313>;
+			resets = <&cpg 511>;
+			renesas,bonding = <&drif21>;
 			status = "disabled";
 		};
 
-		sdhi2: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7796",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee140000 0 0x2000>;
-			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
-			max-frequency = <200000000>;
+		drif21: rif at e6f90000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6f90000 0 0x64>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 510>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x2a>, <&dmac2 0x2a>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 312>;
+			resets = <&cpg 510>;
+			renesas,bonding = <&drif20>;
 			status = "disabled";
 		};
 
-		sdhi3: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7796",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee160000 0 0x2000>;
-			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 311>;
-			max-frequency = <200000000>;
+		drif30: rif at e6fa0000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6fa0000 0 0x64>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 509>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x2c>, <&dmac2 0x2c>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 311>;
+			resets = <&cpg 509>;
+			renesas,bonding = <&drif31>;
 			status = "disabled";
 		};
 
-		tsc: thermal at e6198000 {
-			compatible = "renesas,r8a7796-thermal";
-			reg = <0 0xe6198000 0 0x100>,
-			      <0 0xe61a0000 0 0x100>,
-			      <0 0xe61a8000 0 0x100>;
-			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 522>;
+		drif31: rif at e6fb0000 {
+			compatible = "renesas,r8a7796-drif",
+				     "renesas,rcar-gen3-drif";
+			reg = <0 0xe6fb0000 0 0x64>;
+			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 508>;
+			clock-names = "fck";
+			dmas = <&dmac1 0x2e>, <&dmac2 0x2e>;
+			dma-names = "rx", "rx";
 			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 522>;
-			#thermal-sensor-cells = <1>;
-			status = "okay";
+			resets = <&cpg 508>;
+			renesas,bonding = <&drif30>;
+			status = "disabled";
 		};
 
 		rcar_sound: sound at ec500000 {
@@ -1796,58 +1547,302 @@
 				};
 			};
 
-			rcar_sound,ssi {
-				ssi0: ssi-0 {
-					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi1: ssi-1 {
-					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi2: ssi-2 {
-					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi3: ssi-3 {
-					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi4: ssi-4 {
-					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi5: ssi-5 {
-					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi6: ssi-6 {
-					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi7: ssi-7 {
-					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi8: ssi-8 {
-					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi9: ssi-9 {
-					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-			};
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi1: ssi-1 {
+					interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi7: ssi-7 {
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi8: ssi-8 {
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi9: ssi-9 {
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+			};
+		};
+
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,dmac-r8a7796",
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
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 502>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			iommus = <&ipmmu_mp 0>, <&ipmmu_mp 1>,
+			       <&ipmmu_mp 2>, <&ipmmu_mp 3>,
+			       <&ipmmu_mp 4>, <&ipmmu_mp 5>,
+			       <&ipmmu_mp 6>, <&ipmmu_mp 7>,
+			       <&ipmmu_mp 8>, <&ipmmu_mp 9>,
+			       <&ipmmu_mp 10>, <&ipmmu_mp 11>,
+			       <&ipmmu_mp 12>, <&ipmmu_mp 13>,
+			       <&ipmmu_mp 14>, <&ipmmu_mp 15>;
+		};
+
+		audma1: dma-controller at ec720000 {
+			compatible = "renesas,dmac-r8a7796",
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
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 501>;
+			#dma-cells = <1>;
+			dma-channels = <16>;
+			iommus = <&ipmmu_mp 16>, <&ipmmu_mp 17>,
+			       <&ipmmu_mp 18>, <&ipmmu_mp 19>,
+			       <&ipmmu_mp 20>, <&ipmmu_mp 21>,
+			       <&ipmmu_mp 22>, <&ipmmu_mp 23>,
+			       <&ipmmu_mp 24>, <&ipmmu_mp 25>,
+			       <&ipmmu_mp 26>, <&ipmmu_mp 27>,
+			       <&ipmmu_mp 28>, <&ipmmu_mp 29>,
+			       <&ipmmu_mp 30>, <&ipmmu_mp 31>;
+		};
+
+		xhci0: usb at ee000000 {
+			compatible = "renesas,xhci-r8a7796",
+				     "renesas,rcar-gen3-xhci";
+			reg = <0 0xee000000 0 0xc00>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
+		usb3_peri0: usb at ee020000 {
+			compatible = "renesas,r8a7796-usb3-peri",
+				     "renesas,rcar-gen3-usb3-peri";
+			reg = <0 0xee020000 0 0x400>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 328>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 328>;
+			status = "disabled";
+		};
+
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
+		ohci1: usb at ee0a0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
+		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			companion= <&ohci0>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			status = "disabled";
+		};
+
+		ehci1: usb at ee0a0100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee0a0100 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			companion= <&ohci1>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			status = "disabled";
+		};
+
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a7796",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 703>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy at ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a7796",
+				     "renesas,rcar-gen3-usb2-phy";
+			reg = <0 0xee0a0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 702>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
+		};
+
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7796",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
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
+					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		pciec0: pcie at fe000000 {
@@ -1860,6 +1855,26 @@
 			/* placeholder */
 		};
 
+		imr-lx4 at fe860000 {
+			compatible = "renesas,r8a7796-imr-lx4",
+				     "renesas,imr-lx4";
+			reg = <0 0xfe860000 0 0x2000>;
+			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 823>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+			resets = <&cpg 823>;
+		};
+
+		imr-lx4 at fe870000 {
+			compatible = "renesas,r8a7796-imr-lx4",
+				     "renesas,imr-lx4";
+			reg = <0 0xfe870000 0 0x2000>;
+			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 822>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+			resets = <&cpg 822>;
+		};
+
 		fdp1 at fe940000 {
 			compatible = "renesas,fdp1";
 			reg = <0 0xfe940000 0 0x2400>;
@@ -1878,17 +1893,6 @@
 			resets = <&cpg 615>;
 		};
 
-		vspb: vsp at fe960000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe960000 0 0x8000>;
-			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 626>;
-			power-domains = <&sysc R8A7796_PD_A3VC>;
-			resets = <&cpg 626>;
-
-			renesas,fcp = <&fcpvb0>;
-		};
-
 		fcpvb0: fcp at fe96f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
@@ -1897,17 +1901,6 @@
 			resets = <&cpg 607>;
 		};
 
-		vspi0: vsp at fe9a0000 {
-			compatible = "renesas,vsp2";
-			reg = <0 0xfe9a0000 0 0x8000>;
-			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 631>;
-			power-domains = <&sysc R8A7796_PD_A3VC>;
-			resets = <&cpg 631>;
-
-			renesas,fcp = <&fcpvi0>;
-		};
-
 		fcpvi0: fcp at fe9af000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfe9af000 0 0x200>;
@@ -1917,6 +1910,44 @@
 			iommus = <&ipmmu_vc0 19>;
 		};
 
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
+		};
+
+		fcpvd1: fcp at fea2f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea2f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 602>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 602>;
+			iommus = <&ipmmu_vi0 9>;
+		};
+
+		fcpvd2: fcp at fea37000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea37000 0 0x200>;
+			clocks = <&cpg CPG_MOD 601>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 601>;
+			iommus = <&ipmmu_vi0 10>;
+		};
+
+		vspb: vsp at fe960000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe960000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 626>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+			resets = <&cpg 626>;
+
+			renesas,fcp = <&fcpvb0>;
+		};
+
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea20000 0 0x8000>;
@@ -1928,15 +1959,6 @@
 			renesas,fcp = <&fcpvd0>;
 		};
 
-		fcpvd0: fcp at fea27000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea27000 0 0x200>;
-			clocks = <&cpg CPG_MOD 603>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 603>;
-			iommus = <&ipmmu_vi0 8>;
-		};
-
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea28000 0 0x8000>;
@@ -1948,15 +1970,6 @@
 			renesas,fcp = <&fcpvd1>;
 		};
 
-		fcpvd1: fcp at fea2f000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea2f000 0 0x200>;
-			clocks = <&cpg CPG_MOD 602>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 602>;
-			iommus = <&ipmmu_vi0 9>;
-		};
-
 		vspd2: vsp at fea30000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea30000 0 0x8000>;
@@ -1968,13 +1981,15 @@
 			renesas,fcp = <&fcpvd2>;
 		};
 
-		fcpvd2: fcp at fea37000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea37000 0 0x200>;
-			clocks = <&cpg CPG_MOD 601>;
-			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
-			resets = <&cpg 601>;
-			iommus = <&ipmmu_vi0 10>;
+		vspi0: vsp at fe9a0000 {
+			compatible = "renesas,vsp2";
+			reg = <0 0xfe9a0000 0 0x8000>;
+			interrupts = <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 631>;
+			power-domains = <&sysc R8A7796_PD_A3VC>;
+			resets = <&cpg 631>;
+
+			renesas,fcp = <&fcpvi0>;
 		};
 
 		hdmi0: hdmi at fead0000 {
@@ -2042,24 +2057,9 @@
 			};
 		};
 
-		imr-lx4 at fe860000 {
-			compatible = "renesas,r8a7796-imr-lx4",
-				     "renesas,imr-lx4";
-			reg = <0 0xfe860000 0 0x2000>;
-			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 823>;
-			power-domains = <&sysc R8A7796_PD_A3VC>;
-			resets = <&cpg 823>;
-		};
-
-		imr-lx4 at fe870000 {
-			compatible = "renesas,r8a7796-imr-lx4",
-				     "renesas,imr-lx4";
-			reg = <0 0xfe870000 0 0x2000>;
-			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 822>;
-			power-domains = <&sysc R8A7796_PD_A3VC>;
-			resets = <&cpg 822>;
+		prr: chipid at fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
 		};
 	};
 
-- 
2.11.0
