From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 26 Sep 2018 16:22:46 +0300
Subject: [PATCH v2 21/22] arm64: dts: ls104x: make dma-coherent global to the
 SoC
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
Message-ID: <20180926132247.10971-22-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These SoCs are really completely dma coherent in their entirety so add
the dma-coherent property at the soc level in the device tree and drop
the instances where it's specifically added to a few select devices.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 5 +----
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index ccadc40a36f4..9fb3ac0fa87c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -215,6 +215,7 @@
 		#size-cells = <2>;
 		ranges;
 		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
+		dma-coherent;
 
 		clockgen: clocking at 1ee1000 {
 			compatible = "fsl,ls1043a-clockgen";
@@ -680,7 +681,6 @@
 			reg-names = "ahci", "sata-ecc";
 			interrupts = <0 69 0x4>;
 			clocks = <&clockgen 4 0>;
-			dma-coherent;
 		};
 
 		msi1: msi-controller1 at 1571000 {
@@ -715,7 +715,6 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <4>;
 			bus-range = <0x0 0xff>;
@@ -741,7 +740,6 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
@@ -767,7 +765,6 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			dma-coherent;
 			iommu-map = <0 &mmu 0 1>;
 			num-lanes = <2>;
 			bus-range = <0x0 0xff>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index a12d33362554..f19cf6087235 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -188,6 +188,7 @@
 		#size-cells = <2>;
 		ranges;
 		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
+		dma-coherent;
 
 		ddr: memory-controller at 1080000 {
 			compatible = "fsl,qoriq-memory-controller";
-- 
2.17.1
