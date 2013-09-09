From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  8 Sep 2013 22:00:08 -0300
Subject: [PATCH 2/2] ARM: dts: Add imx6s-wandboard support
In-Reply-To: <1378688408-8689-1-git-send-email-festevam@gmail.com>
References: <1378688408-8689-1-git-send-email-festevam@gmail.com>
Message-ID: <1378688408-8689-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Wandboard comes with three mx6 flavours: quad, dual-lite and solo.

Qual and dual-lite boards are already supported.

Add support for the wandboard solo type.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/imx6s-wandboard.dts | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6s-wandboard.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 69193be..0e92eb2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -142,6 +142,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
 	imx6q-wandboard.dtb \
+	imx6s-wandboard.dtb \
 	imx6sl-evk.dtb \
 	vf610-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6s-wandboard.dts b/arch/arm/boot/dts/imx6s-wandboard.dts
new file mode 100644
index 0000000..2b75a94
--- /dev/null
+++ b/arch/arm/boot/dts/imx6s-wandboard.dts
@@ -0,0 +1,22 @@
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
+/dts-v1/;
+#include "imx6s.dtsi"
+#include "imx6qdl-wandboard.dtsi"
+
+/ {
+	model = "Wandboard i.MX6 Solo Board";
+	compatible = "wand,imx6s-wandboard", "fsl,imx6s";
+
+	memory {
+		reg = <0x10000000 0x20000000>;
+	};
+};
-- 
1.8.1.2
