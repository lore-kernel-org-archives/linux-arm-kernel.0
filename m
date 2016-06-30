From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 30 Jun 2016 16:16:17 +0200
Subject: [PATCH 1/8] ARM: shmobile: r8a7792: basic SoC support
In-Reply-To: <cover.1467293089.git.horms+renesas@verge.net.au>
References: <cover.1467293089.git.horms+renesas@verge.net.au>
Message-ID: <a57ac4c16b261d63b5c957353acdca92628b2ca5.1467293089.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add minimal support for the R-Car V2H (R8A7792) SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig         |  4 ++++
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/setup-r8a7792.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index fe4ccb52f921..88e91583f3fb 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -86,6 +86,10 @@ config ARCH_R8A7791
 	select ARCH_RCAR_GEN2
 	select I2C
 
+config ARCH_R8A7792
+	bool "R-Car V2H (R8A77920)"
+	select ARCH_RCAR_GEN2
+
 config ARCH_R8A7793
 	bool "R-Car M2-N (R8A7793)"
 	select ARCH_RCAR_GEN2
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fc95f7bd2dd9..3fc48b02eb4f 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7792)	+= setup-r8a7792.o
 obj-$(CONFIG_ARCH_R8A7793)	+= setup-r8a7793.o
 obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
diff --git a/arch/arm/mach-shmobile/setup-r8a7792.c b/arch/arm/mach-shmobile/setup-r8a7792.c
new file mode 100644
index 000000000000..a0910395da09
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r8a7792.c
@@ -0,0 +1,35 @@
+/*
+ * r8a7792 processor support
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2016 Cogent  Embedded, Inc.
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
+
+#include <asm/mach/arch.h>
+
+#include "common.h"
+#include "rcar-gen2.h"
+
+static const char * const r8a7792_boards_compat_dt[] __initconst = {
+	"renesas,r8a7792",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7792_DT, "Generic R8A7792 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.init_time	= rcar_gen2_timer_init,
+	.reserve	= rcar_gen2_reserve,
+	.dt_compat	= r8a7792_boards_compat_dt,
+MACHINE_END
-- 
2.7.0.rc3.207.g0ac5344
