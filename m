From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:52:49 +0100
Subject: [PATCH 30/52] ARM: dts: r8a7745: Add IPMMU DT nodes
In-Reply-To: <cover.1521208546.git.horms+renesas@verge.net.au>
References: <cover.1521208546.git.horms+renesas@verge.net.au>
Message-ID: <0dcba3de58354e35c91a31dafe597e81e7c22294.1521208546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add the six IPMMU instances found in the r8a7745 to DT with a disabled
status.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 9c8d72c83bdc..413288b05515 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -288,6 +288,64 @@
 			resets = <&cpg 407>;
 		};
 
+		ipmmu_sy0: mmu at e6280000 {
+			compatible = "renesas,ipmmu-r8a7745",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6280000 0 0x1000>;
+			interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_sy1: mmu at e6290000 {
+			compatible = "renesas,ipmmu-r8a7745",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6290000 0 0x1000>;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a7745",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe6740000 0 0x1000>;
+			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mp: mmu at ec680000 {
+			compatible = "renesas,ipmmu-r8a7745",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xec680000 0 0x1000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mx: mmu at fe951000 {
+			compatible = "renesas,ipmmu-r8a7745",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xfe951000 0 0x1000>;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_gp: mmu at e62a0000 {
+			compatible = "renesas,ipmmu-r8a7745",
+				     "renesas,ipmmu-vmsa";
+			reg = <0 0xe62a0000 0 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		icram0:	sram at e63a0000 {
 			compatible = "mmio-sram";
 			reg = <0 0xe63a0000 0 0x12000>;
-- 
2.11.0
