From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Sep 2018 15:36:09 +0300
Subject: [PATCH 17/21] arm64: dts: ls1043a: add smmu node
In-Reply-To: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
References: <20180919123613.15092-1-laurentiu.tudor@nxp.com>
Message-ID: <20180919123613.15092-18-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

This allows for the SMMU device to be probed by the SMMU kernel driver.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 7881e3d81a9a..8b3eba167508 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -222,6 +222,48 @@
 			clocks = <&sysclk>;
 		};
 
+		mmu: iommu at 9000000 {
+			compatible = "arm,mmu-500";
+			reg = <0 0x9000000 0 0x400000>;
+			dma-coherent;
+			#global-interrupts = <2>;
+			#iommu-cells = <1>;
+			interrupts = <0 142 4>, /* global secure fault */
+				     <0 143 4>, /* combined secure interrupt */
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>,
+				     <0 142 4>;
+		};
+
 		scfg: scfg at 1570000 {
 			compatible = "fsl,ls1043a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
-- 
2.17.1
