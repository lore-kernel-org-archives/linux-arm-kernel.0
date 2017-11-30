From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Thu, 30 Nov 2017 09:12:23 +0530
Subject: [PATCH 1/2][v2] ARM: dts: Add big-endian for IFC on LS1021A
In-Reply-To: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <1512013344-4042-2-git-send-email-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagdish Gediya <jagdish.gediya@nxp.com>

For the patch to update struct map_info's swap field based on device
characteristics defined in device tree, big-endian parameter is added
for LS1021A.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
Changes for v2: updated subject

 arch/arm/boot/dts/ls1021a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f..babb086 100644
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
1.9.1
