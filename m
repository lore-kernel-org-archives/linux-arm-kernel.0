From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 02 Jan 2013 14:23:45 -0800
Subject: [PATCH 08/26] ARM: SAMSUNG: cleanup mach/regs-audss.h file
In-Reply-To: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
References: <1357165443-3716-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1357165443-3716-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/dev-audio.c                |    3 ++-
 arch/arm/mach-exynos/include/mach/regs-audss.h  |   18 ------------------
 arch/arm/mach-s5pv210/dev-audio.c               |    3 ++-
 arch/arm/mach-s5pv210/include/mach/regs-audss.h |   18 ------------------
 4 files changed, 4 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-audss.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/regs-audss.h

diff --git a/arch/arm/mach-exynos/dev-audio.c b/arch/arm/mach-exynos/dev-audio.c
index 9d1a609..c662c89 100644
--- a/arch/arm/mach-exynos/dev-audio.c
+++ b/arch/arm/mach-exynos/dev-audio.c
@@ -21,7 +21,8 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
-#include <mach/regs-audss.h>
+
+#define EXYNOS4_AUDSS_INT_MEM	(0x03000000)
 
 static int exynos4_cfg_i2s(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-exynos/include/mach/regs-audss.h b/arch/arm/mach-exynos/include/mach/regs-audss.h
deleted file mode 100644
index ca5a8b6..0000000
--- a/arch/arm/mach-exynos/include/mach/regs-audss.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-exynos4/include/mach/regs-audss.h
- *
- * Copyright (c) 2011 Samsung Electronics
- *		http://www.samsung.com
- *
- * Exynos4 Audio SubSystem clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_REGS_AUDSS_H
-#define __PLAT_REGS_AUDSS_H __FILE__
-
-#define EXYNOS4_AUDSS_INT_MEM	(0x03000000)
-
-#endif /* _PLAT_REGS_AUDSS_H */
diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index addfb16..2d67361 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -18,7 +18,8 @@
 #include <mach/map.h>
 #include <mach/dma.h>
 #include <mach/irqs.h>
-#include <mach/regs-audss.h>
+
+#define S5PV210_AUDSS_INT_MEM	(0xC0000000)
 
 static int s5pv210_cfg_i2s(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-audss.h b/arch/arm/mach-s5pv210/include/mach/regs-audss.h
deleted file mode 100644
index eacc1f7..0000000
--- a/arch/arm/mach-s5pv210/include/mach/regs-audss.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* arch/arm/mach-s5pv210/include/mach/regs-audss.h
- *
- * Copyright (c) 2011 Samsung Electronics
- *		http://www.samsung.com
- *
- * S5PV210 Audio SubSystem clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_REGS_AUDSS_H
-#define __PLAT_REGS_AUDSS_H __FILE__
-
-#define S5PV210_AUDSS_INT_MEM	(0xC0000000)
-
-#endif /* _PLAT_REGS_AUDSS_H */
-- 
1.7.10.4
