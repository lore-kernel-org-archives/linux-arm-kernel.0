From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Tue, 28 Aug 2018 12:29:34 +0530
Subject: [PATCH] arm64: dts: remove big-endian filed from IFC controller
Message-ID: <20180828065936.8040-1-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per IFC binding, Absence of "little-endian" field causes registers
access in big-endian mode.
So no need to set explicit big-endian field IFC node for LS1043A and
LS1046A.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index b9f5d2ff4ff2..68af84a8ade8 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -3,6 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -280,7 +281,6 @@
 		ifc: ifc at 1530000 {
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
-			big-endian;
 			interrupts = <0 43 0x4>;
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 65ce1c3cb568..9f5acb4dfaf3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -4,6 +4,8 @@
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
  *
+ * Copyright 2018 NXP
+ *
  * Mingkai Hu <mingkai.hu@nxp.com>
  */
 
@@ -198,7 +200,6 @@
 		ifc: ifc at 1530000 {
 			compatible = "fsl,ifc", "simple-bus";
 			reg = <0x0 0x1530000 0x0 0x10000>;
-			big-endian;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.14.1
