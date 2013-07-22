From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Jul 2013 18:54:16 -0300
Subject: [PATCH v2 2/2] ARM: dts: mx6: Add support for imx6dl nitrogen board
In-Reply-To: <1374530056-31335-1-git-send-email-festevam@gmail.com>
References: <1374530056-31335-1-git-send-email-festevam@gmail.com>
Message-ID: <1374530056-31335-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/imx6dl-nitrogen.dts | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eeb2275..3f1a75d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -124,6 +124,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx53-mba53.dtb \
 	imx53-qsb.dtb \
 	imx53-smd.dtb \
+	imx6dl-nitrogen.dtb \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-nitrogen.dts b/arch/arm/boot/dts/imx6dl-nitrogen.dts
new file mode 100644
index 0000000..d1ba3fc
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-nitrogen.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Fabio Estevam <fabio.estevam@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+/dts-v1/;
+#include "imx6q.dtsi"
+#include "imx6qdl-nitrogen.dtsi"
+
+/ {
+	model = "Boundary Devices i.MX6 Dual Lite Nitrogen Board";
+	compatible = "boundary,imx6dl-nitrogen", "fsl,imx6dl";
+
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+};
+
+&sata {
+	status = "okay";
+};
-- 
1.8.1.2
