From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Jan 2018 17:17:04 +0100
Subject: [PATCH v2 03/16] ARM: dts: r8a7790: sort subnodes of soc node
In-Reply-To: <20180117161717.14589-1-horms+renesas@verge.net.au>
References: <20180117161717.14589-1-horms+renesas@verge.net.au>
Message-ID: <20180117161717.14589-4-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort the subnodes of the soc node to improve maintainability.
The sort key is the addresss on the bus with instances of the same
IP block grouped together.

This patch should not introduce any functional change.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* Correct order of: qspi, msiof*, can*, and vin* nodes.
---
 arch/arm/boot/dts/r8a7790.dtsi | 1592 ++++++++++++++++++++--------------------
 1 file changed, 796 insertions(+), 796 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 1f4b3a4ed287..54c5a2d7ea89 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -166,32 +166,6 @@
 		#size-cells = <2>;
 		ranges;
 
-		apmu at e6151000 {
-			compatible = "renesas,r8a7790-apmu", "renesas,apmu";
-			reg = <0 0xe6151000 0 0x188>;
-			cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
-		};
-
-		apmu at e6152000 {
-			compatible = "renesas,r8a7790-apmu", "renesas,apmu";
-			reg = <0 0xe6152000 0 0x188>;
-			cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
-		};
-
-		gic: interrupt-controller at f1001000 {
-			compatible = "arm,gic-400";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
-			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
-			clocks = <&cpg CPG_MOD 408>;
-			clock-names = "clk";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 408>;
-		};
-
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7790",
 				     "renesas,rcar-gen2-gpio";
@@ -282,50 +256,42 @@
 			resets = <&cpg 907>;
 		};
 
-		thermal: thermal at e61f0000 {
-			compatible = "renesas,thermal-r8a7790",
-				     "renesas,rcar-gen2-thermal",
-				     "renesas,rcar-thermal";
-			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
-			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 522>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 522>;
-			#thermal-sensor-cells = <0>;
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a7790";
+			reg = <0 0xe6060000 0 0x250>;
 		};
 
-		cmt0: timer at ffca0000 {
-			compatible = "renesas,r8a7790-cmt0",
-				     "renesas,rcar-gen2-cmt0";
-			reg = <0 0xffca0000 0 0x1004>;
-			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 124>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 124>;
+		cpg: clock-controller at e6150000 {
+			compatible = "renesas,r8a7790-cpg-mssr";
+			reg = <0 0xe6150000 0 0x1000>;
+			clocks = <&extal_clk>, <&usb_extal_clk>;
+			clock-names = "extal", "usb_extal";
+			#clock-cells = <2>;
+			#power-domain-cells = <0>;
+			#reset-cells = <1>;
+		};
 
-			status = "disabled";
+		apmu at e6151000 {
+			compatible = "renesas,r8a7790-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
 		};
 
-		cmt1: timer at e6130000 {
-			compatible = "renesas,r8a7790-cmt1",
-				     "renesas,rcar-gen2-cmt1";
-			reg = <0 0xe6130000 0 0x1004>;
-			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 329>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 329>;
+		apmu at e6152000 {
+			compatible = "renesas,r8a7790-apmu", "renesas,apmu";
+			reg = <0 0xe6152000 0 0x188>;
+			cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+		};
 
-			status = "disabled";
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7790-rst";
+			reg = <0 0xe6160000 0 0x0100>;
+		};
+
+		sysc: system-controller at e6180000 {
+			compatible = "renesas,r8a7790-sysc";
+			reg = <0 0xe6180000 0 0x0200>;
+			#power-domain-cells = <1>;
 		};
 
 		irqc0: interrupt-controller at e61c0000 {
@@ -342,160 +308,91 @@
 			resets = <&cpg 407>;
 		};
 
-		dmac0: dma-controller at e6700000 {
-			compatible = "renesas,dmac-r8a7790",
-				     "renesas,rcar-dmac";
-			reg = <0 0xe6700000 0 0x20000>;
-			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12", "ch13", "ch14";
-			clocks = <&cpg CPG_MOD 219>;
-			clock-names = "fck";
+		thermal: thermal at e61f0000 {
+			compatible = "renesas,thermal-r8a7790",
+				     "renesas,rcar-gen2-thermal",
+				     "renesas,rcar-thermal";
+			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 219>;
-			#dma-cells = <1>;
-			dma-channels = <15>;
+			resets = <&cpg 522>;
+			#thermal-sensor-cells = <0>;
 		};
 
-		dmac1: dma-controller at e6720000 {
-			compatible = "renesas,dmac-r8a7790",
-				     "renesas,rcar-dmac";
-			reg = <0 0xe6720000 0 0x20000>;
-			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12", "ch13", "ch14";
-			clocks = <&cpg CPG_MOD 218>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 218>;
-			#dma-cells = <1>;
-			dma-channels = <15>;
+		ipmmu_sy0: mmu at e6280000 {
+			compatible = "renesas,ipmmu-r8a7790",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6280000 0 0x1000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		audma0: dma-controller at ec700000 {
-			compatible = "renesas,dmac-r8a7790",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec700000 0 0x10000>;
-			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
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
-				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12";
-			clocks = <&cpg CPG_MOD 502>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 502>;
-			#dma-cells = <1>;
-			dma-channels = <13>;
+		ipmmu_sy1: mmu at e6290000 {
+			compatible = "renesas,ipmmu-r8a7790",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6290000 0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		audma1: dma-controller at ec720000 {
-			compatible = "renesas,dmac-r8a7790",
-				     "renesas,rcar-dmac";
-			reg = <0 0xec720000 0 0x10000>;
-			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "error",
-					  "ch0", "ch1", "ch2", "ch3",
-					  "ch4", "ch5", "ch6", "ch7",
-					  "ch8", "ch9", "ch10", "ch11",
-					  "ch12";
-			clocks = <&cpg CPG_MOD 501>;
-			clock-names = "fck";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 501>;
-			#dma-cells = <1>;
-			dma-channels = <13>;
+		ipmmu_ds: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a7790",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6740000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		usb_dmac0: dma-controller at e65a0000 {
-			compatible = "renesas,r8a7790-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65a0000 0 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 330>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 330>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
+		ipmmu_mp: mmu at ec680000 {
+			compatible = "renesas,ipmmu-r8a7790",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xec680000 0 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
 		};
 
-		usb_dmac1: dma-controller at e65b0000 {
-			compatible = "renesas,r8a7790-usb-dmac",
-				     "renesas,usb-dmac";
-			reg = <0 0xe65b0000 0 0x100>;
-			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
-				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "ch0", "ch1";
-			clocks = <&cpg CPG_MOD 331>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 331>;
-			#dma-cells = <1>;
-			dma-channels = <2>;
+		ipmmu_mx: mmu at fe951000 {
+			compatible = "renesas,ipmmu-r8a7790",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xfe951000 0 0x1000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a7790",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xffc80000 0 0x1000>;
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
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
 		};
 
 		i2c0: i2c at e6508000 {
@@ -622,107 +519,172 @@
 			status = "disabled";
 		};
 
-		mmcif0: mmc at ee200000 {
-			compatible = "renesas,mmcif-r8a7790",
-				     "renesas,sh-mmcif";
-			reg = <0 0xee200000 0 0x80>;
-			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 315>;
-			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
-			       <&dmac1 0xd1>, <&dmac1 0xd2>;
-			dma-names = "tx", "rx", "tx", "rx";
+		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7790",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 704>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 315>;
-			reg-io-width = <4>;
+			resets = <&cpg 704>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
 			status = "disabled";
-			max-frequency = <97500000>;
 		};
 
-		mmcif1: mmc at ee220000 {
-			compatible = "renesas,mmcif-r8a7790",
-				     "renesas,sh-mmcif";
-			reg = <0 0xee220000 0 0x80>;
-			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 305>;
-			dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
-			       <&dmac1 0xe1>, <&dmac1 0xe2>;
-			dma-names = "tx", "rx", "tx", "rx";
+		usbphy: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a7790",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&cpg CPG_MOD 704>;
+			clock-names = "usbhs";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 305>;
-			reg-io-width = <4>;
+			resets = <&cpg 704>;
 			status = "disabled";
-			max-frequency = <97500000>;
+
+			usb0: usb-channel at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+			usb2: usb-channel at 2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
 		};
 
-		pfc: pin-controller at e6060000 {
-			compatible = "renesas,pfc-r8a7790";
-			reg = <0 0xe6060000 0 0x250>;
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a7790-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 330>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 330>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
 		};
 
-		sdhi0: sd at ee100000 {
-			compatible = "renesas,sdhi-r8a7790",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee100000 0 0x328>;
-			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 314>;
-			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
-			       <&dmac1 0xcd>, <&dmac1 0xce>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <195000000>;
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a7790-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&cpg CPG_MOD 331>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 314>;
-			status = "disabled";
+			resets = <&cpg 331>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
 		};
 
-		sdhi1: sd at ee120000 {
-			compatible = "renesas,sdhi-r8a7790",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee120000 0 0x328>;
-			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 313>;
-			dmas = <&dmac0 0xc9>, <&dmac0 0xca>,
-			       <&dmac1 0xc9>, <&dmac1 0xca>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <195000000>;
+		dmac0: dma-controller at e6700000 {
+			compatible = "renesas,dmac-r8a7790",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6700000 0 0x20000>;
+			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&cpg CPG_MOD 219>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 313>;
-			status = "disabled";
+			resets = <&cpg 219>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
 		};
 
-		sdhi2: sd at ee140000 {
-			compatible = "renesas,sdhi-r8a7790",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee140000 0 0x100>;
-			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 312>;
-			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
-			       <&dmac1 0xc1>, <&dmac1 0xc2>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
+		dmac1: dma-controller at e6720000 {
+			compatible = "renesas,dmac-r8a7790",
+				     "renesas,rcar-dmac";
+			reg = <0 0xe6720000 0 0x20000>;
+			interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12", "ch13", "ch14";
+			clocks = <&cpg CPG_MOD 218>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 312>;
-			status = "disabled";
+			resets = <&cpg 218>;
+			#dma-cells = <1>;
+			dma-channels = <15>;
 		};
 
-		sdhi3: sd at ee160000 {
-			compatible = "renesas,sdhi-r8a7790",
-				     "renesas,rcar-gen2-sdhi";
-			reg = <0 0xee160000 0 0x100>;
-			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 311>;
-			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
-			       <&dmac1 0xd3>, <&dmac1 0xd4>;
-			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
+		avb: ethernet at e6800000 {
+			compatible = "renesas,etheravb-r8a7790",
+				     "renesas,etheravb-rcar-gen2";
+			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 812>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 311>;
+			resets = <&cpg 812>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		scifa0: serial at e6c40000 {
-			compatible = "renesas,scifa-r8a7790",
-				     "renesas,rcar-gen2-scifa", "renesas,scifa";
-			reg = <0 0xe6c40000 0 64>;
+		qspi: spi at e6b10000 {
+			compatible = "renesas,qspi-r8a7790", "renesas,qspi";
+			reg = <0 0xe6b10000 0 0x2c>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 917>;
+			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
+			       <&dmac1 0x17>, <&dmac1 0x18>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 917>;
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		scifa0: serial at e6c40000 {
+			compatible = "renesas,scifa-r8a7790",
+				     "renesas,rcar-gen2-scifa", "renesas,scifa";
+			reg = <0 0xe6c40000 0 64>;
 			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 204>;
 			clock-names = "fck";
@@ -892,110 +854,94 @@
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
-		ether: ethernet at ee700000 {
-			compatible = "renesas,ether-r8a7790",
-				     "renesas,rcar-gen2-ether";
-			reg = <0 0xee700000 0 0x400>;
-			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 813>;
+		msiof0: spi at e6e20000 {
+			compatible = "renesas,msiof-r8a7790",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6e20000 0 0x0064>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 0>;
+			dmas = <&dmac0 0x51>, <&dmac0 0x52>,
+			       <&dmac1 0x51>, <&dmac1 0x52>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 813>;
-			phy-mode = "rmii";
+			resets = <&cpg 0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		avb: ethernet at e6800000 {
-			compatible = "renesas,etheravb-r8a7790",
-				     "renesas,etheravb-rcar-gen2";
-			reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
-			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 812>;
+		msiof1: spi at e6e10000 {
+			compatible = "renesas,msiof-r8a7790",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6e10000 0 0x0064>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 208>;
+			dmas = <&dmac0 0x55>, <&dmac0 0x56>,
+			       <&dmac1 0x55>, <&dmac1 0x56>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 812>;
+			resets = <&cpg 208>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		sata0: sata at ee300000 {
-			compatible = "renesas,sata-r8a7790",
-				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee300000 0 0x2000>;
-			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 815>;
+		msiof2: spi at e6e00000 {
+			compatible = "renesas,msiof-r8a7790",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6e00000 0 0x0064>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 205>;
+			dmas = <&dmac0 0x41>, <&dmac0 0x42>,
+			       <&dmac1 0x41>, <&dmac1 0x42>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 815>;
+			resets = <&cpg 205>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		sata1: sata at ee500000 {
-			compatible = "renesas,sata-r8a7790",
-				     "renesas,rcar-gen2-sata";
-			reg = <0 0xee500000 0 0x2000>;
-			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 814>;
+		msiof3: spi at e6c90000 {
+			compatible = "renesas,msiof-r8a7790",
+				     "renesas,rcar-gen2-msiof";
+			reg = <0 0xe6c90000 0 0x0064>;
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 215>;
+			dmas = <&dmac0 0x45>, <&dmac0 0x46>,
+			       <&dmac1 0x45>, <&dmac1 0x46>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 814>;
+			resets = <&cpg 215>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			status = "disabled";
 		};
 
-		hsusb: usb at e6590000 {
-			compatible = "renesas,usbhs-r8a7790",
-				     "renesas,rcar-gen2-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
-			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 704>;
-			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
-			       <&usb_dmac1 0>, <&usb_dmac1 1>;
-			dma-names = "ch0", "ch1", "ch2", "ch3";
+		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7790",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e80000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A7790_CLK_RCAN>, <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
-			renesas,buswait = <4>;
-			phys = <&usb0 1>;
-			phy-names = "usb";
+			resets = <&cpg 916>;
 			status = "disabled";
 		};
 
-		usbphy: usb-phy at e6590100 {
-			compatible = "renesas,usb-phy-r8a7790",
-				     "renesas,rcar-gen2-usb-phy";
-			reg = <0 0xe6590100 0 0x100>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			clocks = <&cpg CPG_MOD 704>;
-			clock-names = "usbhs";
+		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7790",
+				     "renesas,rcar-gen2-can";
+			reg = <0 0xe6e88000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A7790_CLK_RCAN>, <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 704>;
+			resets = <&cpg 915>;
 			status = "disabled";
-
-			usb0: usb-channel at 0 {
-				reg = <0>;
-				#phy-cells = <1>;
-			};
-			usb2: usb-channel at 2 {
-				reg = <2>;
-				#phy-cells = <1>;
-			};
 		};
 
 		vin0: video at e6ef0000 {
@@ -1042,220 +988,267 @@
 			status = "disabled";
 		};
 
-		vsp at fe920000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe920000 0 0x8000>;
-			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 130>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 130>;
-		};
+		rcar_sound: sound at ec500000 {
+			/*
+			 * #sound-dai-cells is required
+			 *
+			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+			 */
+			compatible = "renesas,rcar_sound-r8a7790",
+				     "renesas,rcar_sound-gen2";
+			reg = <0 0xec500000 0 0x1000>, /* SCU */
+			      <0 0xec5a0000 0 0x100>,  /* ADG */
+			      <0 0xec540000 0 0x1000>, /* SSIU */
+			      <0 0xec541000 0 0x280>,  /* SSI */
+			      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
-		vsp at fe928000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe928000 0 0x8000>;
-			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 131>;
+			clocks = <&cpg CPG_MOD 1005>,
+				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
+				 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
+				 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
+				 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
+				 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
+				 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
+				 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
+				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
+				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
+				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
+				 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
+				 <&cpg CPG_CORE R8A7790_CLK_M2>;
+			clock-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0",
+				      "src.9", "src.8", "src.7", "src.6",
+				      "src.5", "src.4", "src.3", "src.2",
+				      "src.1", "src.0",
+				      "ctu.0", "ctu.1",
+				      "mix.0", "mix.1",
+				      "dvc.0", "dvc.1",
+				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 131>;
-		};
+			resets = <&cpg 1005>,
+				 <&cpg 1006>, <&cpg 1007>,
+				 <&cpg 1008>, <&cpg 1009>,
+				 <&cpg 1010>, <&cpg 1011>,
+				 <&cpg 1012>, <&cpg 1013>,
+				 <&cpg 1014>, <&cpg 1015>;
+			reset-names = "ssi-all",
+				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
+				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
+				      "ssi.1", "ssi.0";
 
-		vsp at fe930000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe930000 0 0x8000>;
-			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 128>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 128>;
-		};
+			status = "disabled";
 
-		vsp at fe938000 {
-			compatible = "renesas,vsp1";
-			reg = <0 0xfe938000 0 0x8000>;
-			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 127>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 127>;
-		};
+			rcar_sound,dvc {
+				dvc0: dvc-0 {
+					dmas = <&audma1 0xbc>;
+					dma-names = "tx";
+				};
+				dvc1: dvc-1 {
+					dmas = <&audma1 0xbe>;
+					dma-names = "tx";
+				};
+			};
 
-		du: display at feb00000 {
-			compatible = "renesas,du-r8a7790";
-			reg = <0 0xfeb00000 0 0x70000>,
-			      <0 0xfeb90000 0 0x1c>,
-			      <0 0xfeb94000 0 0x1c>;
-			reg-names = "du", "lvds.0", "lvds.1";
-			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
-				 <&cpg CPG_MOD 722>, <&cpg CPG_MOD 726>,
-				 <&cpg CPG_MOD 725>;
-			clock-names = "du.0", "du.1", "du.2", "lvds.0",
-				      "lvds.1";
-			status = "disabled";
+			rcar_sound,mix {
+				mix0: mix-0 { };
+				mix1: mix-1 { };
+			};
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
+			rcar_sound,ctu {
+				ctu00: ctu-0 { };
+				ctu01: ctu-1 { };
+				ctu02: ctu-2 { };
+				ctu03: ctu-3 { };
+				ctu10: ctu-4 { };
+				ctu11: ctu-5 { };
+				ctu12: ctu-6 { };
+				ctu13: ctu-7 { };
+			};
 
-				port at 0 {
-					reg = <0>;
-					du_out_rgb: endpoint {
-					};
+			rcar_sound,src {
+				src0: src-0 {
+					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x85>, <&audma1 0x9a>;
+					dma-names = "rx", "tx";
 				};
-				port at 1 {
-					reg = <1>;
-					du_out_lvds0: endpoint {
-					};
+				src1: src-1 {
+					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x87>, <&audma1 0x9c>;
+					dma-names = "rx", "tx";
 				};
-				port at 2 {
-					reg = <2>;
-					du_out_lvds1: endpoint {
-					};
+				src2: src-2 {
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x89>, <&audma1 0x9e>;
+					dma-names = "rx", "tx";
+				};
+				src3: src-3 {
+					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
+					dma-names = "rx", "tx";
+				};
+				src4: src-4 {
+					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
+					dma-names = "rx", "tx";
+				};
+				src5: src-5 {
+					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
+					dma-names = "rx", "tx";
+				};
+				src6: src-6 {
+					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x91>, <&audma1 0xb4>;
+					dma-names = "rx", "tx";
+				};
+				src7: src-7 {
+					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x93>, <&audma1 0xb6>;
+					dma-names = "rx", "tx";
+				};
+				src8: src-8 {
+					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x95>, <&audma1 0xb8>;
+					dma-names = "rx", "tx";
+				};
+				src9: src-9 {
+					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x97>, <&audma1 0xba>;
+					dma-names = "rx", "tx";
 				};
 			};
-		};
-
-		can0: can at e6e80000 {
-			compatible = "renesas,can-r8a7790",
-				     "renesas,rcar-gen2-can";
-			reg = <0 0xe6e80000 0 0x1000>;
-			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>,
-				 <&cpg CPG_CORE R8A7790_CLK_RCAN>, <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 916>;
-			status = "disabled";
-		};
-
-		can1: can at e6e88000 {
-			compatible = "renesas,can-r8a7790",
-				     "renesas,rcar-gen2-can";
-			reg = <0 0xe6e88000 0 0x1000>;
-			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>,
-				 <&cpg CPG_CORE R8A7790_CLK_RCAN>, <&can_clk>;
-			clock-names = "clkp1", "clkp2", "can_clk";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 915>;
-			status = "disabled";
-		};
-
-		jpu: jpeg-codec at fe980000 {
-			compatible = "renesas,jpu-r8a7790",
-				     "renesas,rcar-gen2-jpu";
-			reg = <0 0xfe980000 0 0x10300>;
-			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 106>;
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 106>;
-		};
-
-		cpg: clock-controller at e6150000 {
-			compatible = "renesas,r8a7790-cpg-mssr";
-			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>, <&usb_extal_clk>;
-			clock-names = "extal", "usb_extal";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
-		};
-
-		prr: chipid at ff000044 {
-			compatible = "renesas,prr";
-			reg = <0 0xff000044 0 4>;
-		};
-
-		rst: reset-controller at e6160000 {
-			compatible = "renesas,r8a7790-rst";
-			reg = <0 0xe6160000 0 0x0100>;
-		};
-
-		sysc: system-controller at e6180000 {
-			compatible = "renesas,r8a7790-sysc";
-			reg = <0 0xe6180000 0 0x0200>;
-			#power-domain-cells = <1>;
-		};
-
-		qspi: spi at e6b10000 {
-			compatible = "renesas,qspi-r8a7790", "renesas,qspi";
-			reg = <0 0xe6b10000 0 0x2c>;
-			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 917>;
-			dmas = <&dmac0 0x17>, <&dmac0 0x18>,
-			       <&dmac1 0x17>, <&dmac1 0x18>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 917>;
-			num-cs = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
 
-		msiof0: spi at e6e20000 {
-			compatible = "renesas,msiof-r8a7790",
-				     "renesas,rcar-gen2-msiof";
-			reg = <0 0xe6e20000 0 0x0064>;
-			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 0>;
-			dmas = <&dmac0 0x51>, <&dmac0 0x52>,
-			       <&dmac1 0x51>, <&dmac1 0x52>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		msiof1: spi at e6e10000 {
-			compatible = "renesas,msiof-r8a7790",
-				     "renesas,rcar-gen2-msiof";
-			reg = <0 0xe6e10000 0 0x0064>;
-			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 208>;
-			dmas = <&dmac0 0x55>, <&dmac0 0x56>,
-			       <&dmac1 0x55>, <&dmac1 0x56>;
-			dma-names = "tx", "rx", "tx", "rx";
-			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 208>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			rcar_sound,ssi {
+				ssi0: ssi-0 {
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x01>, <&audma1 0x02>,
+					       <&audma0 0x15>, <&audma1 0x16>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi1: ssi-1 {
+					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x03>, <&audma1 0x04>,
+					       <&audma0 0x49>, <&audma1 0x4a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi2: ssi-2 {
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x05>, <&audma1 0x06>,
+					       <&audma0 0x63>, <&audma1 0x64>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi3: ssi-3 {
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x07>, <&audma1 0x08>,
+					       <&audma0 0x6f>, <&audma1 0x70>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi4: ssi-4 {
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x09>, <&audma1 0x0a>,
+					       <&audma0 0x71>, <&audma1 0x72>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi5: ssi-5 {
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0b>, <&audma1 0x0c>,
+					       <&audma0 0x73>, <&audma1 0x74>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi6: ssi-6 {
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0d>, <&audma1 0x0e>,
+					       <&audma0 0x75>, <&audma1 0x76>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi7: ssi-7 {
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x0f>, <&audma1 0x10>,
+					       <&audma0 0x79>, <&audma1 0x7a>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi8: ssi-8 {
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x11>, <&audma1 0x12>,
+					       <&audma0 0x7b>, <&audma1 0x7c>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+				ssi9: ssi-9 {
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
+					dmas = <&audma0 0x13>, <&audma1 0x14>,
+					       <&audma0 0x7d>, <&audma1 0x7e>;
+					dma-names = "rx", "tx", "rxu", "txu";
+				};
+			};
 		};
 
-		msiof2: spi at e6e00000 {
-			compatible = "renesas,msiof-r8a7790",
-				     "renesas,rcar-gen2-msiof";
-			reg = <0 0xe6e00000 0 0x0064>;
-			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 205>;
-			dmas = <&dmac0 0x41>, <&dmac0 0x42>,
-			       <&dmac1 0x41>, <&dmac1 0x42>;
-			dma-names = "tx", "rx", "tx", "rx";
+		audma0: dma-controller at ec700000 {
+			compatible = "renesas,dmac-r8a7790",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec700000 0 0x10000>;
+			interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
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
+				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12";
+			clocks = <&cpg CPG_MOD 502>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 205>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			resets = <&cpg 502>;
+			#dma-cells = <1>;
+			dma-channels = <13>;
 		};
-
-		msiof3: spi at e6c90000 {
-			compatible = "renesas,msiof-r8a7790",
-				     "renesas,rcar-gen2-msiof";
-			reg = <0 0xe6c90000 0 0x0064>;
-			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 215>;
-			dmas = <&dmac0 0x45>, <&dmac0 0x46>,
-			       <&dmac1 0x45>, <&dmac1 0x46>;
-			dma-names = "tx", "rx", "tx", "rx";
+
+		audma1: dma-controller at ec720000 {
+			compatible = "renesas,dmac-r8a7790",
+				     "renesas,rcar-dmac";
+			reg = <0 0xec720000 0 0x10000>;
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					  "ch0", "ch1", "ch2", "ch3",
+					  "ch4", "ch5", "ch6", "ch7",
+					  "ch8", "ch9", "ch10", "ch11",
+					  "ch12";
+			clocks = <&cpg CPG_MOD 501>;
+			clock-names = "fck";
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 215>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
+			resets = <&cpg 501>;
+			#dma-cells = <1>;
+			dma-channels = <13>;
 		};
 
 		xhci: usb at ee000000 {
@@ -1364,6 +1357,148 @@
 			};
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a7790",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a7790",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee120000 0 0x328>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			dmas = <&dmac0 0xc9>, <&dmac0 0xca>,
+			       <&dmac1 0xc9>, <&dmac1 0xca>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <195000000>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
+		sdhi2: sd at ee140000 {
+			compatible = "renesas,sdhi-r8a7790",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee140000 0 0x100>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 312>;
+			dmas = <&dmac0 0xc1>, <&dmac0 0xc2>,
+			       <&dmac1 0xc1>, <&dmac1 0xc2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 312>;
+			status = "disabled";
+		};
+
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a7790",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee160000 0 0x100>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
+		mmcif0: mmc at ee200000 {
+			compatible = "renesas,mmcif-r8a7790",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee200000 0 0x80>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 315>;
+			dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
+			       <&dmac1 0xd1>, <&dmac1 0xd2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 315>;
+			reg-io-width = <4>;
+			status = "disabled";
+			max-frequency = <97500000>;
+		};
+
+		mmcif1: mmc at ee220000 {
+			compatible = "renesas,mmcif-r8a7790",
+				     "renesas,sh-mmcif";
+			reg = <0 0xee220000 0 0x80>;
+			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 305>;
+			dmas = <&dmac0 0xe1>, <&dmac0 0xe2>,
+			       <&dmac1 0xe1>, <&dmac1 0xe2>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 305>;
+			reg-io-width = <4>;
+			status = "disabled";
+			max-frequency = <97500000>;
+		};
+
+		sata0: sata at ee300000 {
+			compatible = "renesas,sata-r8a7790",
+				     "renesas,rcar-gen2-sata";
+			reg = <0 0xee300000 0 0x2000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 815>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 815>;
+			status = "disabled";
+		};
+
+		sata1: sata at ee500000 {
+			compatible = "renesas,sata-r8a7790",
+				     "renesas,rcar-gen2-sata";
+			reg = <0 0xee500000 0 0x2000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 814>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 814>;
+			status = "disabled";
+		};
+
+		ether: ethernet at ee700000 {
+			compatible = "renesas,ether-r8a7790",
+				     "renesas,rcar-gen2-ether";
+			reg = <0 0xee700000 0 0x400>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 813>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 813>;
+			phy-mode = "rmii";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at f1001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg = <0 0xf1001000 0 0x1000>, <0 0xf1002000 0 0x2000>,
+			      <0 0xf1004000 0 0x2000>, <0 0xf1006000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			clocks = <&cpg CPG_MOD 408>;
+			clock-names = "clk";
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 408>;
+		};
+
 		pciec: pcie at fe000000 {
 			compatible = "renesas,pcie-r8a7790",
 				     "renesas,pcie-rcar-gen2";
@@ -1392,261 +1527,126 @@
 			status = "disabled";
 		};
 
-		rcar_sound: sound at ec500000 {
-			/*
-			 * #sound-dai-cells is required
-			 *
-			 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
-			 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
-			 */
-			compatible = "renesas,rcar_sound-r8a7790",
-				     "renesas,rcar_sound-gen2";
-			reg = <0 0xec500000 0 0x1000>, /* SCU */
-			      <0 0xec5a0000 0 0x100>,  /* ADG */
-			      <0 0xec540000 0 0x1000>, /* SSIU */
-			      <0 0xec541000 0 0x280>,  /* SSI */
-			      <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
-			reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
+		vsp at fe920000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe920000 0 0x8000>;
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 130>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 130>;
+		};
 
-			clocks = <&cpg CPG_MOD 1005>,
-				 <&cpg CPG_MOD 1006>, <&cpg CPG_MOD 1007>,
-				 <&cpg CPG_MOD 1008>, <&cpg CPG_MOD 1009>,
-				 <&cpg CPG_MOD 1010>, <&cpg CPG_MOD 1011>,
-				 <&cpg CPG_MOD 1012>, <&cpg CPG_MOD 1013>,
-				 <&cpg CPG_MOD 1014>, <&cpg CPG_MOD 1015>,
-				 <&cpg CPG_MOD 1022>, <&cpg CPG_MOD 1023>,
-				 <&cpg CPG_MOD 1024>, <&cpg CPG_MOD 1025>,
-				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
-				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
-				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
-				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
-				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
-				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
-				 <&audio_clk_a>, <&audio_clk_b>, <&audio_clk_c>,
-				 <&cpg CPG_CORE R8A7790_CLK_M2>;
-			clock-names = "ssi-all",
-				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
-				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
-				      "ssi.1", "ssi.0",
-				      "src.9", "src.8", "src.7", "src.6",
-				      "src.5", "src.4", "src.3", "src.2",
-				      "src.1", "src.0",
-				      "ctu.0", "ctu.1",
-				      "mix.0", "mix.1",
-				      "dvc.0", "dvc.1",
-				      "clk_a", "clk_b", "clk_c", "clk_i";
+		vsp at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 131>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 131>;
+		};
+
+		vsp at fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 128>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 128>;
+		};
+
+		vsp at fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 127>;
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 127>;
+		};
+
+		jpu: jpeg-codec at fe980000 {
+			compatible = "renesas,jpu-r8a7790",
+				     "renesas,rcar-gen2-jpu";
+			reg = <0 0xfe980000 0 0x10300>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 106>;
 			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
-			resets = <&cpg 1005>,
-				 <&cpg 1006>, <&cpg 1007>,
-				 <&cpg 1008>, <&cpg 1009>,
-				 <&cpg 1010>, <&cpg 1011>,
-				 <&cpg 1012>, <&cpg 1013>,
-				 <&cpg 1014>, <&cpg 1015>;
-			reset-names = "ssi-all",
-				      "ssi.9", "ssi.8", "ssi.7", "ssi.6",
-				      "ssi.5", "ssi.4", "ssi.3", "ssi.2",
-				      "ssi.1", "ssi.0";
+			resets = <&cpg 106>;
+		};
 
+		du: display at feb00000 {
+			compatible = "renesas,du-r8a7790";
+			reg = <0 0xfeb00000 0 0x70000>,
+			      <0 0xfeb90000 0 0x1c>,
+			      <0 0xfeb94000 0 0x1c>;
+			reg-names = "du", "lvds.0", "lvds.1";
+			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>, <&cpg CPG_MOD 723>,
+				 <&cpg CPG_MOD 722>, <&cpg CPG_MOD 726>,
+				 <&cpg CPG_MOD 725>;
+			clock-names = "du.0", "du.1", "du.2", "lvds.0",
+				      "lvds.1";
 			status = "disabled";
 
-			rcar_sound,dvc {
-				dvc0: dvc-0 {
-					dmas = <&audma1 0xbc>;
-					dma-names = "tx";
-				};
-				dvc1: dvc-1 {
-					dmas = <&audma1 0xbe>;
-					dma-names = "tx";
-				};
-			};
-
-			rcar_sound,mix {
-				mix0: mix-0 { };
-				mix1: mix-1 { };
-			};
-
-			rcar_sound,ctu {
-				ctu00: ctu-0 { };
-				ctu01: ctu-1 { };
-				ctu02: ctu-2 { };
-				ctu03: ctu-3 { };
-				ctu10: ctu-4 { };
-				ctu11: ctu-5 { };
-				ctu12: ctu-6 { };
-				ctu13: ctu-7 { };
-			};
-
-			rcar_sound,src {
-				src0: src-0 {
-					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x85>, <&audma1 0x9a>;
-					dma-names = "rx", "tx";
-				};
-				src1: src-1 {
-					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x87>, <&audma1 0x9c>;
-					dma-names = "rx", "tx";
-				};
-				src2: src-2 {
-					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x89>, <&audma1 0x9e>;
-					dma-names = "rx", "tx";
-				};
-				src3: src-3 {
-					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
-					dma-names = "rx", "tx";
-				};
-				src4: src-4 {
-					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
-					dma-names = "rx", "tx";
-				};
-				src5: src-5 {
-					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
-					dma-names = "rx", "tx";
-				};
-				src6: src-6 {
-					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x91>, <&audma1 0xb4>;
-					dma-names = "rx", "tx";
-				};
-				src7: src-7 {
-					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x93>, <&audma1 0xb6>;
-					dma-names = "rx", "tx";
-				};
-				src8: src-8 {
-					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x95>, <&audma1 0xb8>;
-					dma-names = "rx", "tx";
-				};
-				src9: src-9 {
-					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x97>, <&audma1 0xba>;
-					dma-names = "rx", "tx";
-				};
-			};
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			rcar_sound,ssi {
-				ssi0: ssi-0 {
-					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x01>, <&audma1 0x02>,
-					       <&audma0 0x15>, <&audma1 0x16>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi1: ssi-1 {
-					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x03>, <&audma1 0x04>,
-					       <&audma0 0x49>, <&audma1 0x4a>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi2: ssi-2 {
-					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x05>, <&audma1 0x06>,
-					       <&audma0 0x63>, <&audma1 0x64>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi3: ssi-3 {
-					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x07>, <&audma1 0x08>,
-					       <&audma0 0x6f>, <&audma1 0x70>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi4: ssi-4 {
-					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x09>, <&audma1 0x0a>,
-					       <&audma0 0x71>, <&audma1 0x72>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi5: ssi-5 {
-					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0b>, <&audma1 0x0c>,
-					       <&audma0 0x73>, <&audma1 0x74>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi6: ssi-6 {
-					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0d>, <&audma1 0x0e>,
-					       <&audma0 0x75>, <&audma1 0x76>;
-					dma-names = "rx", "tx", "rxu", "txu";
-				};
-				ssi7: ssi-7 {
-					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x0f>, <&audma1 0x10>,
-					       <&audma0 0x79>, <&audma1 0x7a>;
-					dma-names = "rx", "tx", "rxu", "txu";
+				port at 0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
 				};
-				ssi8: ssi-8 {
-					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x11>, <&audma1 0x12>,
-					       <&audma0 0x7b>, <&audma1 0x7c>;
-					dma-names = "rx", "tx", "rxu", "txu";
+				port at 1 {
+					reg = <1>;
+					du_out_lvds0: endpoint {
+					};
 				};
-				ssi9: ssi-9 {
-					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
-					dmas = <&audma0 0x13>, <&audma1 0x14>,
-					       <&audma0 0x7d>, <&audma1 0x7e>;
-					dma-names = "rx", "tx", "rxu", "txu";
+				port at 2 {
+					reg = <2>;
+					du_out_lvds1: endpoint {
+					};
 				};
 			};
 		};
 
-		ipmmu_sy0: mmu at e6280000 {
-			compatible = "renesas,ipmmu-r8a7790",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe6280000 0 0x1000>;
-			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
-
-		ipmmu_sy1: mmu at e6290000 {
-			compatible = "renesas,ipmmu-r8a7790",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe6290000 0 0x1000>;
-			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
+		prr: chipid at ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
 		};
 
-		ipmmu_ds: mmu at e6740000 {
-			compatible = "renesas,ipmmu-r8a7790",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xe6740000 0 0x1000>;
-			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,r8a7790-cmt0",
+				     "renesas,rcar-gen2-cmt0";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 124>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 124>;
 
-		ipmmu_mp: mmu at ec680000 {
-			compatible = "renesas,ipmmu-r8a7790",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xec680000 0 0x1000>;
-			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
 			status = "disabled";
 		};
 
-		ipmmu_mx: mmu at fe951000 {
-			compatible = "renesas,ipmmu-r8a7790",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xfe951000 0 0x1000>;
-			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
-			status = "disabled";
-		};
+		cmt1: timer at e6130000 {
+			compatible = "renesas,r8a7790-cmt1",
+				     "renesas,rcar-gen2-cmt1";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 329>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
+			resets = <&cpg 329>;
 
-		ipmmu_rt: mmu at ffc80000 {
-			compatible = "renesas,ipmmu-r8a7790",
-				     "renesas,ipmmu-vmsa";
-			reg = <0 0xffc80000 0 0x1000>;
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			#iommu-cells = <1>;
 			status = "disabled";
 		};
 	};
-- 
2.11.0
