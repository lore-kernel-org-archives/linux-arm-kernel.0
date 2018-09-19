From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Sep 2018 15:36:10 +0300
Subject: [PATCH 18/21] arm64: dts: ls104xa: set mask to drop TBU ID from
 StreamID
In-Reply-To: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
Message-ID: <20180919123613.15092-19-laurentiu.tudor@nxp.com>
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
index 8b3eba167508..90296b9fb171 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -226,6 +226,7 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x9000000 0 0x400000>;
 			dma-coherent;
+			stream-match-mask = <0x7f00>;
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			interrupts = <0 142 4>, /* global secure fault */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 06863d3e4a7d..15094dd8400e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -232,6 +232,7 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x9000000 0 0x400000>;
 			dma-coherent;
+			stream-match-mask = <0x7f00>;
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			interrupts = <0 142 4>, /* global secure fault */
-- 
2.17.1
