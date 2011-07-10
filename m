From: ccross@android.com (Colin Cross)
Date: Sun, 10 Jul 2011 14:02:52 -0700
Subject: [PATCH] ARM: tegra: remove mach/barriers.h
Message-ID: <1310331772-13310-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The barriers implemented in arch/arm/mach-tegra/mach/barriers.h
are exactly the same as the default barriers implemented in
arch/arm/include/asm/system.h.  Remove barriers.h from Tegra,
and don't select ARCH_HAS_BARRIERS.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/Kconfig                            |    1 -
 arch/arm/mach-tegra/include/mach/barriers.h |   30 ---------------------------
 2 files changed, 0 insertions(+), 31 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/barriers.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..7e179f0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -591,7 +591,6 @@ config ARCH_TEGRA
 	select GENERIC_GPIO
 	select HAVE_CLK
 	select HAVE_SCHED_CLOCK
-	select ARCH_HAS_BARRIERS if CACHE_L2X0
 	select ARCH_HAS_CPUFREQ
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
diff --git a/arch/arm/mach-tegra/include/mach/barriers.h b/arch/arm/mach-tegra/include/mach/barriers.h
deleted file mode 100644
index 425b42e..0000000
--- a/arch/arm/mach-tegra/include/mach/barriers.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * arch/arm/mach-realview/include/mach/barriers.h
- *
- * Copyright (C) 2010 ARM Ltd.
- * Written by Catalin Marinas <catalin.marinas@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __MACH_BARRIERS_H
-#define __MACH_BARRIERS_H
-
-#include <asm/outercache.h>
-
-#define rmb()		dsb()
-#define wmb()		do { dsb(); outer_sync(); } while (0)
-#define mb()		wmb()
-
-#endif	/* __MACH_BARRIERS_H */
-- 
1.7.4.1
