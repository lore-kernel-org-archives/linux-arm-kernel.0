From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:56 +0200
Subject: [PATCH 20/28] ARM: EXYNOS: Remove setup-i2c0.c
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-21-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now since SAMSUNG_ATAGS is no longer selected for ARCH_EXYNOS, we can
safely remove the remaining setup code.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/Makefile     |  3 ---
 arch/arm/mach-exynos/setup-i2c0.c | 19 -------------------
 2 files changed, 22 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/setup-i2c0.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 5fc6cfd..66c9788 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -35,6 +35,3 @@ AFLAGS_exynos-smc.o		:=-Wa,-march=armv7-a$(plus_sec)
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 
-# device support
-
-obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
deleted file mode 100644
index ede6ceb..0000000
--- a/arch/arm/mach-exynos/setup-i2c0.c
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (c) 2009-2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * I2C0 GPIO configuration.
- *
- * Based on plat-s3c64xx/setup-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-struct platform_device; /* don't need the contents */
-
-void s3c_i2c0_cfg_gpio(struct platform_device *dev)
-{
-
-}
-- 
1.8.2.1
