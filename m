From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 10 Oct 2018 15:07:35 +0300
Subject: [PATCH v3 20/22] arm64: dts: ls104x: add iommu-map to pci controllers
In-Reply-To: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
References: <20181010120737.30300-1-laurentiu.tudor@nxp.com>
Message-ID: <20181010120737.30300-18-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The pci controllers are also behind the smmu so add the iommu-map
property to reflect this. The bootloader needs to patch the stream id
ranges to some sane values.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 3 +++
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 0e8fc8f29997..ccadc40a36f4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -716,6 +716,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <4>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -741,6 +742,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -766,6 +768,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 29b07bdd4207..a12d33362554 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -685,6 +685,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <4>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -710,6 +711,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x48 0x00010000 0x0 0x00010000   /* downstream I/O */
@@ -735,6 +737,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
 			ranges = <0x81000000 0x0 0x00000000 0x50 0x00010000 0x0 0x00010000   /* downstream I/O */
-- 
2.17.1
