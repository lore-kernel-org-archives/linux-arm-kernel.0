From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed,  5 Oct 2016 13:31:29 +0300
Subject: [PATCH] ARM: shmobile: Consolidate R8A779[234] machine definitions
Message-ID: <1475663489-4789-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three SoCs use the exact same machine definition, consolidate them
into a single one.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/Makefile          |  3 ---
 arch/arm/mach-shmobile/setup-r8a7792.c   | 35 --------------------------------
 arch/arm/mach-shmobile/setup-r8a7793.c   | 33 ------------------------------
 arch/arm/mach-shmobile/setup-r8a7794.c   | 33 ------------------------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 20 ++++++++++++++++++
 5 files changed, 20 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7792.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c

I don't have access to any R8A779[234] board, I'd appreciate if someone could
test the patch series.

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 3fc48b02eb4f..64611a1b4276 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -13,9 +13,6 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
-obj-$(CONFIG_ARCH_R8A7792)	+= setup-r8a7792.o
-obj-$(CONFIG_ARCH_R8A7793)	+= setup-r8a7793.o
-obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7792.c b/arch/arm/mach-shmobile/setup-r8a7792.c
deleted file mode 100644
index a0910395da09..000000000000
--- a/arch/arm/mach-shmobile/setup-r8a7792.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * r8a7792 processor support
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- * Copyright (C) 2016 Cogent  Embedded, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "rcar-gen2.h"
-
-static const char * const r8a7792_boards_compat_dt[] __initconst = {
-	"renesas,r8a7792",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7792_DT, "Generic R8A7792 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
-	.init_late	= shmobile_init_late,
-	.init_time	= rcar_gen2_timer_init,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7792_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
deleted file mode 100644
index 5fce87f7f254..000000000000
--- a/arch/arm/mach-shmobile/setup-r8a7793.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * r8a7793 processor support
- *
- * Copyright (C) 2015  Ulrich Hecht
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "rcar-gen2.h"
-
-static const char * const r8a7793_boards_compat_dt[] __initconst = {
-	"renesas,r8a7793",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7793_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
deleted file mode 100644
index d2b093033132..000000000000
--- a/arch/arm/mach-shmobile/setup-r8a7794.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * r8a7794 processor support
- *
- * Copyright (C) 2014  Renesas Electronics Corporation
- * Copyright (C) 2014  Ulrich Hecht
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/of_platform.h>
-#include "common.h"
-#include "rcar-gen2.h"
-#include <asm/mach/arch.h>
-
-static const char * const r8a7794_boards_compat_dt[] __initconst = {
-	"renesas,r8a7794",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
-	.init_early	= shmobile_init_delay,
-	.init_late	= shmobile_init_late,
-	.init_time	= rcar_gen2_timer_init,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7794_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index afb9fdcd3d90..4d5052564f21 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -24,6 +24,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include "common.h"
 #include "rcar-gen2.h"
@@ -203,3 +204,22 @@ void __init rcar_gen2_reserve(void)
 	}
 #endif
 }
+
+static const char * const rcar_gen2_boards_compat_dt[] __initconst = {
+	/*
+	 * R8A7790 and R8A7791 can't be handled here as long as they need SMP
+	 * initialization fallback.
+	 */
+	"renesas,r8a7792",
+	"renesas,r8a7793",
+	"renesas,r8a7794",
+	NULL,
+};
+
+DT_MACHINE_START(RCAR_GEN2_DT, "Generic Gen2 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.init_time	= rcar_gen2_timer_init,
+	.reserve	= rcar_gen2_reserve,
+	.dt_compat	= rcar_gen2_boards_compat_dt,
+MACHINE_END
-- 
Regards,

Laurent Pinchart
