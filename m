From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 15 Feb 2018 17:24:44 +0530
Subject: [PATCH 1/2][v2][RESEND] ARM: dts: Add big-endian for IFC on LS1021A
Message-ID: <20180215115444.23936-1-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the patch to update struct map_info's swap field based on device
characteristics defined in device tree, big-endian parameter is added
for LS1021A.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Due to patch series http://patchwork.ozlabs.org/project/linux-mtd/list/?series=28735
this patch is now independent of flash propoerty. So resending.

 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f0f1d8..babb086ad94f 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -145,6 +145,7 @@
 		ifc: ifc at 1530000 {
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
+			big-endian;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.14.1
