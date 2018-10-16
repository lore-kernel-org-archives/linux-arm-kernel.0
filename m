From: pramod.kumar_1@nxp.com (Pramod Kumar)
Date: Tue, 16 Oct 2018 07:40:29 +0000
Subject: [PATCH] arm64: dts: ls1012a: Add FRWY-LS1012A board support
Message-ID: <20181016074102.10126-1-pramod.kumar_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1012A-FRWY is an ls1012a based SoC board.
Key features of this board are  Micro SD, USB 3.0,
upto 1GB DDR, UART

Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/fsl-ls1012a-frwy.dts   | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86e18adb695a..25a9fb766438 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frdm.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-frwy.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1012a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
new file mode 100644
index 000000000000..8749634c55ee
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
@@ -0,0 +1,25 @@
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
+	compatible = "fsl,ls1012a-frwy", "fsl,ls1012a";
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
