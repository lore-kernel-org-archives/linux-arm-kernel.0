From: hannah@marvell.com (hannah at marvell.com)
Date: Mon, 15 Oct 2018 15:00:46 +0300
Subject: [PATCH 4/4] arm64: dts: marvell: add smmu node for Armada-AP806
In-Reply-To: <1539604846-21151-1-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
Message-ID: <1539604846-21151-5-git-send-email-hannah@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanna Hawa <hannah@marvell.com>

Add SMMU node for Marvell Armada-AP806 SOC.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 176e38d..b5758b6 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -97,6 +97,23 @@
 				interrupts = <17>;
 			};
 
+			smmu: iommu at 5000000 {
+				compatible = "marvell,mmu-500";
+				reg = <0x100000 0x100000>;
+				dma-coherent;
+				#iommu-cells = <1>;
+				#global-interrupts = <1>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					   <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			odmi: odmi at 300000 {
 				compatible = "marvell,odmi-controller";
 				interrupt-controller;
-- 
1.9.1
