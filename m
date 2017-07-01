From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  1 Jul 2017 23:41:00 +0200
Subject: [PATCH] ARM: owl: Drop custom machine
In-Reply-To: <e36c9060-66fa-1893-fc19-bb0d44e37c4c@suse.de>
References: <e36c9060-66fa-1893-fc19-bb0d44e37c4c@suse.de>
Message-ID: <20170701214100.1086-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rely on the fallback to "Generic DT based system".
This change is visible in /proc/cpuinfo.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/mach-actions/Makefile |  1 -
 arch/arm/mach-actions/owl.c    | 28 ----------------------------
 2 files changed, 29 deletions(-)
 delete mode 100644 arch/arm/mach-actions/owl.c

diff --git a/arch/arm/mach-actions/Makefile b/arch/arm/mach-actions/Makefile
index eeb3896e4952..c0f116241da7 100644
--- a/arch/arm/mach-actions/Makefile
+++ b/arch/arm/mach-actions/Makefile
@@ -1,4 +1,3 @@
-obj-y += owl.o
 obj-${CONFIG_SMP} += platsmp.o headsmp.o
 
 AFLAGS_headsmp.o := -Wa,-march=armv7-a
diff --git a/arch/arm/mach-actions/owl.c b/arch/arm/mach-actions/owl.c
deleted file mode 100644
index 4ac4a860f3d6..000000000000
--- a/arch/arm/mach-actions/owl.c
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Copyright (C) 2017 Andreas F?rber
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#include <linux/of_platform.h>
-#include <asm/mach/arch.h>
-
-static const char * const owl_dt_compat[] = {
-	"actions,s500",
-	NULL
-};
-
-DT_MACHINE_START(OWL, "Actions Semi Owl platform")
-	.dt_compat	= owl_dt_compat,
-	.l2c_aux_val	= 0,
-	.l2c_aux_mask	= ~0,
-MACHINE_END
-- 
2.12.3
