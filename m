From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Sep 2014 13:22:18 +0900
Subject: [PATCH 2/2] ARM: shmobile: Initial r8a7794 SoC support
In-Reply-To: <cover.1410235571.git.horms+renesas@verge.net.au>
References: <cover.1410235571.git.horms+renesas@verge.net.au>
Message-ID: <5923abb205e05773e0bb16c7ca4c0b41dbeec40e.1410235571.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Initial support for the r8a7794 SoC, based on work by Hisashi Nakamura.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig         |  4 ++++
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/setup-r8a7794.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index e15dff7..05f4cc0 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -41,6 +41,10 @@ config ARCH_R8A7791
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 
+config ARCH_R8A7794
+	bool "R-Car E2 (R8A77940)"
+	select ARCH_RCAR_GEN2
+
 comment "Renesas ARM SoCs Board Type"
 
 config MACH_GENMAI
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index a6a1dc0..6b61d69 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o setup-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o setup-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
new file mode 100644
index 0000000..05e970c
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r8a7794.c
@@ -0,0 +1,35 @@
+/*
+ * r8a7794 processor support
+ *
+ * Copyright (C) 2014  Renesas Electronics Corporation
+ * Copyright (C) 2014  Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of_platform.h>
+#include "common.h"
+#include "rcar-gen2.h"
+#include <asm/mach/arch.h>
+
+#ifdef CONFIG_USE_OF
+
+static const char * const r8a7794_boards_compat_dt[] __initconst = {
+	"renesas,r8a7794",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.init_time	= rcar_gen2_timer_init,
+	.dt_compat	= r8a7794_boards_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
-- 
2.0.1
