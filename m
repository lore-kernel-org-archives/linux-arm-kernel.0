From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:14 -0400
Subject: [PATCH 30/37] ARM: mach-tegra: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-30-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-tegra/include/mach/memory.h |   28 ----------------------------
 2 files changed, 1 insertions(+), 28 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8b221f2..5eedf03 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -625,6 +625,7 @@ config ARCH_TEGRA
 	select HAVE_SCHED_CLOCK
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
 	select ARCH_HAS_CPUFREQ
+	select NO_MACH_MEMORY_H
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
diff --git a/arch/arm/mach-tegra/include/mach/memory.h b/arch/arm/mach-tegra/include/mach/memory.h
deleted file mode 100644
index 537db3a..0000000
--- a/arch/arm/mach-tegra/include/mach/memory.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * arch/arm/mach-tegra/include/mach/memory.h
- *
- * Copyright (C) 2010 Google, Inc.
- *
- * Author:
- *	Colin Cross <ccross@google.com>
- *	Erik Gilling <konkers@google.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#ifndef __MACH_TEGRA_MEMORY_H
-#define __MACH_TEGRA_MEMORY_H
-
-/* physical offset of RAM */
-#define PLAT_PHYS_OFFSET		UL(0)
-
-#endif
-
-- 
1.7.4
