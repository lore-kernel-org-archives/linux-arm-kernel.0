From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 15 Feb 2017 17:55:20 +0100
Subject: [PATCH 03/11] ARM: Prepare Actions Semi S500
In-Reply-To: <20170215165528.10052-1-afaerber@suse.de>
References: <20170215165528.10052-1-afaerber@suse.de>
Message-ID: <20170215165528.10052-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_OWL and mach-owl for "acts,s500".

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/Kconfig           |  2 ++
 arch/arm/Makefile          |  1 +
 arch/arm/mach-owl/Kconfig  |  9 +++++++++
 arch/arm/mach-owl/Makefile |  1 +
 arch/arm/mach-owl/owl.c    | 28 ++++++++++++++++++++++++++++
 5 files changed, 41 insertions(+)
 create mode 100644 arch/arm/mach-owl/Kconfig
 create mode 100644 arch/arm/mach-owl/Makefile
 create mode 100644 arch/arm/mach-owl/owl.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71cea9e..1ea1e54 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -795,6 +795,8 @@ source "arch/arm/mach-omap2/Kconfig"
 
 source "arch/arm/mach-orion5x/Kconfig"
 
+source "arch/arm/mach-owl/Kconfig"
+
 source "arch/arm/mach-picoxcell/Kconfig"
 
 source "arch/arm/mach-pxa/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ab30cc6..de7fccf 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -195,6 +195,7 @@ machine-$(CONFIG_ARCH_OXNAS)		+= oxnas
 machine-$(CONFIG_ARCH_OMAP1)		+= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
+machine-$(CONFIG_ARCH_OWL)		+= owl
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
diff --git a/arch/arm/mach-owl/Kconfig b/arch/arm/mach-owl/Kconfig
new file mode 100644
index 0000000..8ecceda
--- /dev/null
+++ b/arch/arm/mach-owl/Kconfig
@@ -0,0 +1,9 @@
+menuconfig ARCH_OWL
+	bool "Actions Semi Owl family SoCs"
+	depends on ARCH_MULTI_V7
+	select GENERIC_IRQ_CHIP
+	select ARM_GIC
+	select CACHE_L2X0
+	select COMMON_CLK
+	help
+	  This enables support for the Actions Semiconductor S500 SoC family.
diff --git a/arch/arm/mach-owl/Makefile b/arch/arm/mach-owl/Makefile
new file mode 100644
index 0000000..96ab18d
--- /dev/null
+++ b/arch/arm/mach-owl/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_OWL) += owl.o
diff --git a/arch/arm/mach-owl/owl.c b/arch/arm/mach-owl/owl.c
new file mode 100644
index 0000000..2ada318
--- /dev/null
+++ b/arch/arm/mach-owl/owl.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright (C) 2017 Andreas F?rber
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+
+static const char * const owl_dt_compat[] = {
+	"acts,s500",
+	NULL
+};
+
+DT_MACHINE_START(MESON, "Actions Semi Owl platform")
+	.dt_compat	= owl_dt_compat,
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
+MACHINE_END
-- 
2.10.2
