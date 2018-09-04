From: pramod.kumar_1@nxp.com (Pramod Kumar)
Date: Tue,  4 Sep 2018 15:53:45 +0530
Subject: [PATCH v1] arm64: dts: ls1012a: Add FRWY-LS1012A board support
Message-ID: <20180904102345.1264-1-pramod.kumar_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>

FRWY-LS1012A is a different design from LS1012A-FRDM,
but has some common SoC features. Key feature on this
board is Micro SD, USB 3.0, DDR, UART.

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
---
 changes in v1:
 1. fix license identifier
 2. remove pcie node

 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-frwy.dts   | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86e18adb695a..d1161442ff2f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
new file mode 100644
index 000000000000..e75a8dc0dda5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for Freescale LS1012A FRWY Board.
+ *
+ * Copyright 2018 NXP
+ *
+ * Pramod Kumar <pramod.kumar_1@nxp.com>
+ *
+ */
+/dts-v1/;
+
+#include "fsl-ls1012a.dtsi"
+
+/ {
+	model = "LS1012A FRWY Board";
+	compatible = "fsl,frwy-ls1012a", "fsl,ls1012a";
+
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
-- 
2.17.1
