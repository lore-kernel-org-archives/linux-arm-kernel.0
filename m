From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Jul 2018 21:51:18 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77980: move IPMMU nodes
In-Reply-To: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
References: <2368353.xfo5beGC5E@wasted.cogentembedded.com>
Message-ID: <5f7daa87-b0b3-faa7-0331-640c39961b4a@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPMMU nodes should follow the GEther node, not the CAN-FD node,
according to the <unit-address> part of the startng IPMMU-DS1 node.
While moving the nodes, also do sort them by label alphanumerically...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'renesas-devel-20180726-v4.18-rc6' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm64/boot/dts/renesas/r8a77980.dtsi |  126 +++++++++++++++---------------
 1 file changed, 63 insertions(+), 63 deletions(-)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -462,69 +462,6 @@
 			};
 		};
 
-		ipmmu_ds1: mmu at e7740000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xe7740000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 0>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_vip0: mmu at e7b00000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xe7b00000 0 0x1000>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_vip1: mmu at e7960000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xe7960000 0 0x1000>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_ir: mmu at ff8b0000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xff8b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 3>;
-			power-domains = <&sysc R8A77980_PD_A3IR>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_mm: mmu at e67b0000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xe67b0000 0 0x1000>;
-			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_rt: mmu at ffc80000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xffc80000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 10>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_vc0: mmu at fe6b0000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xfe6b0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 12>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
-		ipmmu_vi0: mmu at febd0000 {
-			compatible = "renesas,ipmmu-r8a77980";
-			reg = <0 0xfebd0000 0 0x1000>;
-			renesas,ipmmu-main = <&ipmmu_mm 14>;
-			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
-			#iommu-cells = <1>;
-		};
-
 		avb: ethernet at e6800000 {
 			compatible = "renesas,etheravb-r8a77980",
 				     "renesas,etheravb-rcar-gen3";
@@ -722,6 +659,69 @@
 			status = "disabled";
 		};
 
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ir: mmu at ff8b0000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xff8b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 3>;
+			power-domains = <&sysc R8A77980_PD_A3IR>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xffc80000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vip0: mmu at e7b00000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xe7b00000 0 0x1000>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vip1: mmu at e7960000 {
+			compatible = "renesas,ipmmu-r8a77980";
+			reg = <0 0xe7960000 0 0x1000>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
 		mmc0: mmc at ee140000 {
 			compatible = "renesas,sdhi-r8a77980",
 				     "renesas,rcar-gen3-sdhi";
