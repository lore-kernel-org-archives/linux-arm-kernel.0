From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:17 +0200
Subject: [PATCH 02/21] ARM: shmobile: Add basic RZ/A2 SoC support
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <332df9828e94d4288825584638b7df6ad4c1ff38.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Brandt <chris.brandt@renesas.com>

Add the RZ/A2 SoC to the Renesas SoC collection.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig         |  6 ++++++
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/setup-r7s9210.c | 27 +++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/setup-r7s9210.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index aeb2eed08598..94e9431d92b8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -55,6 +55,12 @@ config ARCH_R7S72100
 	select SYS_SUPPORTS_SH_MTU2
 	select RENESAS_OSTM
 
+config ARCH_R7S9210
+	bool "RZ/A2 (R7S9210)"
+	select PM
+	select PM_GENERIC_DOMAINS
+	select RENESAS_OSTM
+
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
 	select ARCH_RMOBILE
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b33dc59d8698..5591646cb9bb 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
+obj-$(CONFIG_ARCH_R7S9210)	+= setup-r7s9210.o
 
 # CPU reset vector handling objects
 cpu-y				:= platsmp.o headsmp.o
diff --git a/arch/arm/mach-shmobile/setup-r7s9210.c b/arch/arm/mach-shmobile/setup-r7s9210.c
new file mode 100644
index 000000000000..573fb9955e7e
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r7s9210.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * r7s9210 processor support
+ *
+ * Copyright (C) 2018  Renesas Electronics Corporation
+ * Copyright (C) 2018  Chris Brandt
+ *
+ */
+
+#include <linux/kernel.h>
+
+#include <asm/mach/arch.h>
+
+#include "common.h"
+
+static const char *const r7s9210_boards_compat_dt[] __initconst = {
+	"renesas,r7s9210",
+	NULL,
+};
+
+DT_MACHINE_START(R7S72100_DT, "Generic R7S9210 (Flattened Device Tree)")
+	.l2c_aux_val    = 0,
+	.l2c_aux_mask   = ~0,
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.dt_compat	= r7s9210_boards_compat_dt,
+MACHINE_END
-- 
2.11.0
