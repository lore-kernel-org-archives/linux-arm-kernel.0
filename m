From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:35:07 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77995: Add IPMMU device nodes
In-Reply-To: <20171101103508.7721-1-horms+renesas@verge.net.au>
References: <20171101103508.7721-1-horms+renesas@verge.net.au>
Message-ID: <20171101103508.7721-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add r8a77995 IPMMU nodes and keep all disabled by default.

Based on work for the r8a7795 and r8a7796 by Magnus Damm

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 788e3afae6e3..641c4ddf0647 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -108,6 +108,88 @@
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ipmmu_vi0: mmu at febd0000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfebd0000 0 0x1000>; /* IPMMU-VI0 */
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vp0: mmu at fe990000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfe990000 0 0x1000>; /* IPMMU-VP0 */
+			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_vc0: mmu at fe6b0000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfe6b0000 0 0x1000>; /* IPMMU-VC0 */
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_pv0: mmu at fd800000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xfd800000 0 0x1000>; /* IPMMU-PV0 */
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_hc: mmu at e6570000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe6570000 0 0x1000>; /* IPMMU-HC */
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_rt: mmu at ffc80000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xffc80000 0 0x1000>; /* IPMMU-RT */
+			renesas,ipmmu-main = <&ipmmu_mm 10>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mp: mmu at ec670000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xec670000 0 0x1000>; /* IPMMU-MP */
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds0: mmu at e6740000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe6740000 0 0x1000>; /* IPMMU-DS0 */
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_ds1: mmu at e7740000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe7740000 0 0x1000>; /* IPMMU-DS1 */
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+		ipmmu_mm: mmu at e67b0000 {
+			compatible = "renesas,ipmmu-r8a77995";
+			reg = <0 0xe67b0000 0 0x1000>; /* IPMMU-MM */
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
+
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a77995-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.11.0
