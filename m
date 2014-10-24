From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 24 Oct 2014 18:08:46 +0800
Subject: [PATCHv5 RESEND 5/6] ARM: imx: Add initial support for Freescale
 LS1021A
In-Reply-To: <1414145327-23541-1-git-send-email-jingchang.lu@freescale.com>
References: <1414145327-23541-1-git-send-email-jingchang.lu@freescale.com>
Message-ID: <1414145327-23541-6-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingchang Lu <b35083@freescale.com>

The LS1021A SoC is a dual-core Cortex-A7 based processor,
this adds the initial support for it.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 arch/arm/mach-imx/Kconfig        | 14 ++++++++++++++
 arch/arm/mach-imx/Makefile       |  2 ++
 arch/arm/mach-imx/mach-ls1021a.c | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 arch/arm/mach-imx/mach-ls1021a.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 11b2957..49a0096 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -639,6 +639,20 @@ config SOC_VF610
 	help
 	  This enable support for Freescale Vybrid VF610 processor.
 
+config FSL_SOC
+	bool
+
+config SOC_LS1021A
+	bool "Freescale LS1021A support"
+	select ARM_GIC
+	select HAVE_ARM_ARCH_TIMER
+	select FSL_SOC
+	select PCI_DOMAINS if PCI
+	select ZONE_DMA if ARM_LPAE
+
+	help
+	  This enable support for Freescale LS1021A processor.
+
 endif
 
 source "arch/arm/mach-imx/devices/Kconfig"
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 6e4fcd8..ce137bc 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -110,4 +110,6 @@ obj-$(CONFIG_SOC_IMX53) += mach-imx53.o
 
 obj-$(CONFIG_SOC_VF610) += clk-vf610.o mach-vf610.o
 
+obj-$(CONFIG_SOC_LS1021A) += mach-ls1021a.o
+
 obj-y += devices/
diff --git a/arch/arm/mach-imx/mach-ls1021a.c b/arch/arm/mach-imx/mach-ls1021a.c
new file mode 100644
index 0000000..9d2034b
--- /dev/null
+++ b/arch/arm/mach-imx/mach-ls1021a.c
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2013-2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <asm/mach/arch.h>
+
+#include "common.h"
+
+static const char * const ls1021a_dt_compat[] __initconst = {
+	"fsl,ls1021a",
+	NULL,
+};
+
+DT_MACHINE_START(LS1021A, "Freescale LS1021A")
+	.dt_compat	= ls1021a_dt_compat,
+MACHINE_END
-- 
1.8.0
