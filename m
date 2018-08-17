From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Fri, 17 Aug 2018 15:49:20 +0530
Subject: [PATCH 3/3] arm64: dts: Add big-endian in nor node for ls104xa
In-Reply-To: <20180817101920.20503-1-prabhakar.kushwaha@nxp.com>
References: <20180817101920.20503-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180817101920.20503-3-prabhakar.kushwaha@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NOR and IFC controller connectivity is big-endian.
So add big-endian field in nor device tree node allowing
IFC controller to read/write data from/to the flash correctly.

Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 2 ++
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index c7b8d2c009cd..dff3d648172e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -3,6 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -50,6 +51,7 @@
 	nor at 0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
+		big-endian;
 		bank-width = <2>;
 		device-width = <1>;
 	};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index 7b01ba8d3b7e..17ca357e854f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -3,6 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1043A family SoC.
  *
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
  *
  * Mingkai Hu <Mingkai.hu@freescale.com>
  */
@@ -65,6 +66,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x0 0x0 0x8000000>;
+			big-endian;
 			bank-width = <2>;
 			device-width = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
index e69306e6b0b1..e58a8ca1386c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts
@@ -3,6 +3,7 @@
  * Device Tree Include file for Freescale Layerscape-1046A family SoC.
  *
  * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
  *
  * Shaohui Xie <Shaohui.Xie@nxp.com>
  */
@@ -141,6 +142,7 @@
 	nor at 0,0 {
 		compatible = "cfi-flash";
 		reg = <0x0 0x0 0x8000000>;
+		big-endian;
 		bank-width = <2>;
 		device-width = <1>;
 	};
-- 
2.14.1
