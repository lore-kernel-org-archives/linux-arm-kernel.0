From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 10 Oct 2018 15:07:33 +0300
Subject: [PATCH v3 18/22] arm64: dts: ls104xa: set mask to drop TBU ID from
 StreamID
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
Message-ID: <20181010120737.30300-16-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The StreamID entering the SMMU is actually a concatenation of the
SMMU TBU ID and the ICID configured in software.
Since the TBU ID is internal to the SoC and since we want that the
actual the ICID configured in software to enter the SMMU witout any
additional set bits, mask out the TBU ID bits and leave only the
relevant ICID bits to enter SMMU.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7eea2bace171..1f9b385007a8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -226,6 +226,7 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x9000000 0 0x400000>;
 			dma-coherent;
+			stream-match-mask = <0x7f00>;
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 07a853a0aeaa..22bf3975492a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -232,6 +232,7 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x9000000 0 0x400000>;
 			dma-coherent;
+			stream-match-mask = <0x7f00>;
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1
