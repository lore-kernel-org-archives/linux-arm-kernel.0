From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:46 +0200
Subject: [PATCH 024/102] arm64: dts: renesas: r8a77995: sort subnodes of the
 soc node
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <7c55747fbe82237b4e22eaae3673e7d166c175d6.1526637994.git.horms+renesas@verge.net.au>
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
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 697 +++++++++++++++---------------
 1 file changed, 348 insertions(+), 349 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index cf476556504a..a97830589b0d 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -76,23 +76,6 @@
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
-					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a77995-wdt",
 				     "renesas,rcar-gen3-wdt";
@@ -103,88 +86,123 @@
 			status = "disabled";
 		};
 
-		ipmmu_vi0: mmu at febd0000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xfebd0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 14>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_vp0: mmu at fe990000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xfe990000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 16>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_vc0: mmu at fe6b0000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xfe6b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 12>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 9>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
-		ipmmu_pv0: mmu at fd800000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xfd800000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 6>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
-		ipmmu_hc: mmu at e6570000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xe6570000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 2>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
-		ipmmu_rt: mmu at ffc80000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xffc80000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 10>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 10>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
-		ipmmu_mp: mmu at ec670000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xec670000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 4>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
-		ipmmu_ds0: mmu at e6740000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xe6740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 21>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
-		ipmmu_ds1: mmu at e7740000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xe7740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 1>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a77995",
+				     "renesas,rcar-gen3-gpio",
+				     "renesas,gpio-rcar";
+			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 14>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 906>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
-		ipmmu_mm: mmu at e67b0000 {
-			compatible = "renesas,ipmmu-r8a77995";
-			reg = <0 0xe67b0000 0 0x1000>;
-			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77995";
+			reg = <0 0xe6060000 0 0x508>;
 		};
 
-
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77995-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -200,16 +218,6 @@
 			reg = <0 0xe6160000 0 0x0200>;
 		};
 
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a77995";
-			reg = <0 0xe6060000 0 0x508>;
-		};
-
-		prr: chipid at fff00044 {
-			compatible = "renesas,prr";
-			reg = <0 0xfff00044 0 4>;
-		};
-
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a77995-sysc";
 			reg = <0 0xe6180000 0 0x0400>;
@@ -232,6 +240,98 @@
 			resets = <&cpg 407>;
 		};
 
+		i2c0: i2c at e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77995",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6500000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 931>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 931>;
+			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
+			       <&dmac2 0x91>, <&dmac2 0x90>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77995",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 930>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 930>;
+			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
+			       <&dmac2 0x93>, <&dmac2 0x92>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77995",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe6510000 0 0x40>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 929>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 929>;
+			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
+			       <&dmac2 0x95>, <&dmac2 0x94>;
+			dma-names = "tx", "rx", "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at e66d0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77995",
+				     "renesas,rcar-gen3-i2c";
+			reg = <0 0xe66d0000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 928>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 928>;
+			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
+			dma-names = "tx", "rx";
+			i2c-scl-internal-delay-ns = <6>;
+			status = "disabled";
+		};
+
+		canfd: can at e66c0000 {
+			compatible = "renesas,r8a77995-canfd",
+				     "renesas,rcar-gen3-canfd";
+			reg = <0 0xe66c0000 0 0x8000>;
+			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 914>,
+			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "fck", "canfd", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
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
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a77995",
 				     "renesas,rcar-dmac";
@@ -304,173 +404,85 @@
 			dma-channels = <8>;
 		};
 
-		gpio0: gpio at e6050000 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6050000 0 0x50>;
-			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 0 9>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 912>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 912>;
-		};
-
-		gpio1: gpio at e6051000 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6051000 0 0x50>;
-			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 32 32>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 911>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 911>;
+		ipmmu_ds0: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		gpio2: gpio at e6052000 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6052000 0 0x50>;
-			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 64 32>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 910>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 910>;
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		gpio3: gpio at e6053000 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6053000 0 0x50>;
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 96 10>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 909>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 909>;
+		ipmmu_hc: mmu at e6570000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		gpio4: gpio at e6054000 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6054000 0 0x50>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 128 32>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 908>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 908>;
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		gpio5: gpio at e6055000 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6055000 0 0x50>;
-			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 160 21>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 907>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 907>;
+		ipmmu_mp: mmu at ec670000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		gpio6: gpio at e6055400 {
-			compatible = "renesas,gpio-r8a77995",
-				     "renesas,rcar-gen3-gpio",
-				     "renesas,gpio-rcar";
-			reg = <0 0xe6055400 0 0x50>;
-			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 192 14>;
-			#interrupt-cells = <2>;
-			interrupt-controller;
-			clocks = <&cpg CPG_MOD 906>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 906>;
+		ipmmu_pv0: mmu at fd800000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		can0: can at e6c30000 {
-			compatible = "renesas,can-r8a77995",
-				     "renesas,rcar-gen3-can";
-			reg = <0 0xe6c30000 0 0x1000>;
-			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>,
-			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 916>;
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		can1: can at e6c38000 {
-			compatible = "renesas,can-r8a77995",
-				     "renesas,rcar-gen3-can";
-			reg = <0 0xe6c38000 0 0x1000>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>,
-			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 915>;
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		canfd: can at e66c0000 {
-			compatible = "renesas,r8a77995-canfd",
-				     "renesas,rcar-gen3-canfd";
-			reg = <0 0xe66c0000 0 0x8000>;
-			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
-				   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 914>,
-			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
-			       <&can_clk>;
-			clock-names = "fck", "canfd", "can_clk";
-			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
-			assigned-clock-rates = <40000000>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 914>;
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			#iommu-cells = <1>;
 			status = "disabled";
+		};
 
-			channel0 {
-				status = "disabled";
-			};
-
-			channel1 {
-				status = "disabled";
-			};
+		ipmmu_vp0: mmu at fe990000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfe990000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
 		avb: ethernet at e6800000 {
@@ -519,87 +531,35 @@
 			status = "disabled";
 		};
 
-		scif2: serial at e6e88000 {
-			compatible = "renesas,scif-r8a77995",
-				     "renesas,rcar-gen3-scif", "renesas,scif";
-			reg = <0 0xe6e88000 0 64>;
-			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 310>,
-				 <&cpg CPG_CORE R8A77995_CLK_S3D1C>,
-				 <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
-			       <&dmac2 0x13>, <&dmac2 0x12>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 310>;
-			status = "disabled";
-		};
-
-		i2c0: i2c at e6500000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a77995",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe6500000 0 0x40>;
-			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 931>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 931>;
-			dmas = <&dmac1 0x91>, <&dmac1 0x90>,
-			       <&dmac2 0x91>, <&dmac2 0x90>;
-			dma-names = "tx", "rx", "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
-		};
-
-		i2c1: i2c at e6508000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a77995",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe6508000 0 0x40>;
-			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 930>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 930>;
-			dmas = <&dmac1 0x93>, <&dmac1 0x92>,
-			       <&dmac2 0x93>, <&dmac2 0x92>;
-			dma-names = "tx", "rx", "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
-			status = "disabled";
-		};
-
-		i2c2: i2c at e6510000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a77995",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe6510000 0 0x40>;
-			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 929>;
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a77995",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 929>;
-			dmas = <&dmac1 0x95>, <&dmac1 0x94>,
-			       <&dmac2 0x95>, <&dmac2 0x94>;
-			dma-names = "tx", "rx", "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
-		i2c3: i2c at e66d0000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "renesas,i2c-r8a77995",
-				     "renesas,rcar-gen3-i2c";
-			reg = <0 0xe66d0000 0 0x40>;
-			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 928>;
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a77995",
+				     "renesas,rcar-gen3-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+			       <&cpg CPG_CORE R8A77995_CLK_CANFD>,
+			       <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			assigned-clocks = <&cpg CPG_CORE R8A77995_CLK_CANFD>;
+			assigned-clock-rates = <40000000>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 928>;
-			dmas = <&dmac0 0x97>, <&dmac0 0x96>;
-			dma-names = "tx", "rx";
-			i2c-scl-internal-delay-ns = <6>;
+			resets = <&cpg 915>;
 			status = "disabled";
 		};
 
@@ -643,38 +603,43 @@
 			status = "disabled";
 		};
 
-		sdhi2: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a77995",
-				     "renesas,rcar-gen3-sdhi";
-			reg = <0 0xee140000 0 0x2000>;
-			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
-			max-frequency = <200000000>;
+		scif2: serial at e6e88000 {
+			compatible = "renesas,scif-r8a77995",
+				     "renesas,rcar-gen3-scif", "renesas,scif";
+			reg = <0 0xe6e88000 0 64>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 310>,
+				 <&cpg CPG_CORE R8A77995_CLK_S3D1C>,
+				 <&scif_clk>;
+			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac1 0x13>, <&dmac1 0x12>,
+			       <&dmac2 0x13>, <&dmac2 0x12>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 312>;
+			resets = <&cpg 310>;
 			status = "disabled";
 		};
 
-		ehci0: usb at ee080100 {
-			compatible = "generic-ehci";
-			reg = <0 0xee080100 0 0x100>;
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			companion = <&ohci0>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
 		};
 
-		ohci0: usb at ee080000 {
-			compatible = "generic-ohci";
-			reg = <0 0xee080000 0 0x100>;
+		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
+			companion = <&ohci0>;
 			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
 			resets = <&cpg 703>;
 			status = "disabled";
@@ -692,6 +657,35 @@
 			status = "disabled";
 		};
 
+		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a77995",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee140000 0 0x2000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
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
+					(GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
 		vspbs: vsp at fe960000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfe960000 0 0x8000>;
@@ -702,15 +696,6 @@
 			renesas,fcp = <&fcpvb0>;
 		};
 
-		fcpvb0: fcp at fe96f000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfe96f000 0 0x200>;
-			clocks = <&cpg CPG_MOD 607>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 607>;
-			iommus = <&ipmmu_vp0 5>;
-		};
-
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea20000 0 0x8000>;
@@ -721,15 +706,6 @@
 			renesas,fcp = <&fcpvd0>;
 		};
 
-		fcpvd0: fcp at fea27000 {
-			compatible = "renesas,fcpv";
-			reg = <0 0xfea27000 0 0x200>;
-			clocks = <&cpg CPG_MOD 603>;
-			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
-			resets = <&cpg 603>;
-			iommus = <&ipmmu_vi0 8>;
-		};
-
 		vspd1: vsp at fea28000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea28000 0 0x8000>;
@@ -740,6 +716,24 @@
 			renesas,fcp = <&fcpvd1>;
 		};
 
+		fcpvb0: fcp at fe96f000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfe96f000 0 0x200>;
+			clocks = <&cpg CPG_MOD 607>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 607>;
+			iommus = <&ipmmu_vp0 5>;
+		};
+
+		fcpvd0: fcp at fea27000 {
+			compatible = "renesas,fcpv";
+			reg = <0 0xfea27000 0 0x200>;
+			clocks = <&cpg CPG_MOD 603>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			resets = <&cpg 603>;
+			iommus = <&ipmmu_vi0 8>;
+		};
+
 		fcpvd1: fcp at fea2f000 {
 			compatible = "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
@@ -783,6 +777,11 @@
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
