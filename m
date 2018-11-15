From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 15 Nov 2018 16:11:38 +0100
Subject: [PATCH 9/9] ARM: EXYNOS: remove <mach/map.h> include
In-Reply-To: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
References: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20181115151247epcas2p4053da2cb28b2414156d2fd0530059c0d@epcas2p4.samsung.com>
Message-ID: <1542294698-17470-10-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove no longer needed <mach/map.h> include.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c           |  2 --
 arch/arm/mach-exynos/include/mach/map.h | 18 ------------------
 arch/arm/mach-exynos/platsmp.c          |  2 --
 3 files changed, 22 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index d98574c..d29f241 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -19,8 +19,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 static const struct soc_device_attribute exynos3250_soc_id[] = {
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
deleted file mode 100644
index 22ebe36..0000000
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * EXYNOS - Memory map definitions
- */
-
-#ifndef __ASM_ARCH_MAP_H
-#define __ASM_ARCH_MAP_H __FILE__
-
-#include <plat/map-base.h>
-
-#include <plat/map-s5p.h>
-
-#define EXYNOS_PA_CHIPID		0x10000000
-
-#endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index e2ba70f..56e2554 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -22,8 +22,6 @@
 #include <asm/smp_scu.h>
 #include <asm/firmware.h>
 
-#include <mach/map.h>
-
 #include "common.h"
 
 extern void exynos4_secondary_startup(void);
-- 
1.9.1
