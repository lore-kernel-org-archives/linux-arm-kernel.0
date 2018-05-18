From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:49 +0200
Subject: [PATCH 027/102] arm64: dts: renesas: r8a77970: sort subnodes of the
 soc node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <2964d7546f71c793581382a518b3f2da7a2ad5b6.1526637994.git.horms+renesas@verge.net.au>
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
[simon: rebased; move fcpvd0 to after vspd0]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 388 +++++++++++++++---------------
 1 file changed, 194 insertions(+), 194 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index a194cb8d7d62..c06d7fbfb7be 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -83,23 +83,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		gic: interrupt-controller at f1010000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0 0xf1010000 0 0x1000>,
-			      <0 0xf1020000 0 0x20000>,
-			      <0 0xf1040000 0 0x20000>,
-			      <0 0xf1060000 0 0x20000>;
-			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(1) |
-				      IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a77970-wdt",
 				     "renesas,rcar-gen3-wdt";
@@ -110,75 +93,6 @@
 			status = "disabled";
 		};
 
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a77970-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&extalr_clk>;
-			clock-names = "extal", "extalr";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
-		};
-
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a77970-rst";
-			reg = <0 0xe6160000 0 0x200>;
-		};
-
-		sysc: system-controller at e6180000 {
-			compatible = "renesas,r8a77970-sysc";
-			reg = <0 0xe6180000 0 0x440>;
-			#power-domain-cells = <1>;
-		};
-
-		ipmmu_vi0: mmu at febd0000 {
-			compatible = "renesas,ipmmu-r8a77970";
-			reg = <0 0xfebd0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 9>;
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_ir: mmu at ff8b0000 {
-			compatible = "renesas,ipmmu-r8a77970";
-			reg = <0 0xff8b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 3>;
-			power-domains = <&sysc R8A77970_PD_A3IR>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_rt: mmu at ffc80000 {
-			compatible = "renesas,ipmmu-r8a77970";
-			reg = <0 0xffc80000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 7>;
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_ds1: mmu at e7740000 {
-			compatible = "renesas,ipmmu-r8a77970";
-			reg = <0 0xe7740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_mm: mmu at e67b0000 {
-			compatible = "renesas,ipmmu-r8a77970";
-			reg = <0 0xe67b0000 0 0x1000>;
-			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a77970";
-			reg = <0 0xe6060000 0 0x504>;
-		};
-
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a77970",
 				     "renesas,rcar-gen3-gpio";
@@ -269,6 +183,32 @@
 			resets = <&cpg 907>;
 		};
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77970";
+			reg = <0 0xe6060000 0 0x504>;
+		};
+
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a77970-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&extalr_clk>;
+			clock-names = "extal", "extalr";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
+
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a77970-rst";
+			reg = <0 0xe6160000 0 0x200>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a77970-sysc";
+			reg = <0 0xe6180000 0 0x440>;
+			#power-domain-cells = <1>;
+		};
+
 		intc_ex: interrupt-controller at e61c0000 {
 			compatible = "renesas,intc-ex-r8a77970", "renesas,irqc";
 			#interrupt-cells = <2>;
@@ -285,67 +225,6 @@
 			resets = <&cpg 407>;
 		};
 
-		prr: chipid at fff00044 {
-			compatible = "renesas,prr";
-			reg = <0 0xfff00044 0 4>;
-		};
-
-		dmac1: dma-controller at e7300000 {
-			compatible = "renesas,dmac-r8a77970",
-				     "renesas,rcar-dmac";
-			reg = <0 0xe7300000 0 0x10000>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7";
-			clocks = <&cpg CPG_MOD 218>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			resets = <&cpg 218>;
-			#dma-cells = <1>;
-			dma-channels = <8>;
-			iommus = <&ipmmu_ds1 0>, <&ipmmu_ds1 1>,
-			       <&ipmmu_ds1 2>, <&ipmmu_ds1 3>,
-			       <&ipmmu_ds1 4>, <&ipmmu_ds1 5>,
-			       <&ipmmu_ds1 6>, <&ipmmu_ds1 7>;
-		};
-
-		dmac2: dma-controller at e7310000 {
-			compatible = "renesas,dmac-r8a77970",
-				     "renesas,rcar-dmac";
-			reg = <0 0xe7310000 0 0x10000>;
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7";
-			clocks = <&cpg CPG_MOD 217>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			resets = <&cpg 217>;
-			#dma-cells = <1>;
-			dma-channels = <8>;
-			iommus = <&ipmmu_ds1 16>, <&ipmmu_ds1 17>,
-			       <&ipmmu_ds1 18>, <&ipmmu_ds1 19>,
-			       <&ipmmu_ds1 20>, <&ipmmu_ds1 21>,
-			       <&ipmmu_ds1 22>, <&ipmmu_ds1 23>;
-		};
-
 		i2c0: i2c at e6500000 {
 			compatible = "renesas,i2c-r8a77970",
 				     "renesas,rcar-gen3-i2c";
@@ -502,6 +381,51 @@
 			status = "disabled";
 		};
 
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a77970",
+				     "renesas,etheravb-rcar-gen3";
+			reg = <0 0xe6800000 0 0x800>;
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
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 812>;
+			phy-mode = "rgmii";
+			iommus = <&ipmmu_rt 3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a77970",
 				     "renesas,rcar-gen3-scif",
@@ -573,57 +497,120 @@
 			status = "disabled";
 		};
 
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a77970",
-				     "renesas,etheravb-rcar-gen3";
-			reg = <0 0xe6800000 0 0x800>;
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
+		dmac1: dma-controller at e7300000 {
+			compatible = "renesas,dmac-r8a77970",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7300000 0 0x10000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			resets = <&cpg 812>;
-			phy-mode = "rgmii";
-			iommus = <&ipmmu_rt 3>;
-			#address-cells = <1>;
-			#size-cells = <0>;
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <8>;
+			iommus = <&ipmmu_ds1 0>, <&ipmmu_ds1 1>,
+			       <&ipmmu_ds1 2>, <&ipmmu_ds1 3>,
+			       <&ipmmu_ds1 4>, <&ipmmu_ds1 5>,
+			       <&ipmmu_ds1 6>, <&ipmmu_ds1 7>;
 		};
 
-		fcpvd0: fcp at fea27000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea27000 0 0x200>;
-			clocks = <&cpg CPG_MOD 603>;
+		dmac2: dma-controller at e7310000 {
+			compatible = "renesas,dmac-r8a77970",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe7310000 0 0x10000>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7";
+			clocks = <&cpg CPG_MOD 217>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
-			resets = <&cpg 603>;
+			resets = <&cpg 217>;
+			#dma-cells = <1>;
+			dma-channels = <8>;
+			iommus = <&ipmmu_ds1 16>, <&ipmmu_ds1 17>,
+			       <&ipmmu_ds1 18>, <&ipmmu_ds1 19>,
+			       <&ipmmu_ds1 20>, <&ipmmu_ds1 21>,
+			       <&ipmmu_ds1 22>, <&ipmmu_ds1 23>;
+		};
+
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ir: mmu at ff8b0000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xff8b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			power-domains = <&sysc R8A77970_PD_A3IR>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 7>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a77970";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at f1010000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1010000 0 0x1000>,
+			      <0 0xf1020000 0 0x20000>,
+			      <0 0xf1040000 0 0x20000>,
+			      <0 0xf1060000 0 0x20000>;
+			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(1) |
+				      IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
 		};
 
 		vspd0: vsp at fea20000 {
@@ -636,6 +623,14 @@
 			renesas,fcp = <&fcpvd0>;
 		};
 
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A77970_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a77970";
 			reg = <0 0xfeb00000 0 0x80000>;
@@ -692,6 +687,11 @@
 				};
 			};
 		};
+
+		prr: chipid at fff00044 {
+			compatible = "renesas,prr";
+			reg = <0 0xfff00044 0 4>;
+		};
 	};
 
 	timer {
-- 
2.11.0
