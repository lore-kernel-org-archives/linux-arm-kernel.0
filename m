From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:30:07 -0400
Subject: [PATCH 23/37] ARM: mach-msm: remove mach/memory.h
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-23-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-msm/include/mach/memory.h |   35 -------------------------------
 2 files changed, 1 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/mach-msm/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8495852..44e8fdd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -656,6 +656,7 @@ config ARCH_MSM
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select NO_MACH_MEMORY_H
 	help
 	  Support for Qualcomm MSM/QSD based systems.  This runs on the
 	  apps processor of the MSM/QSD and depends on a shared memory
diff --git a/arch/arm/mach-msm/include/mach/memory.h b/arch/arm/mach-msm/include/mach/memory.h
deleted file mode 100644
index f2f8d29..0000000
--- a/arch/arm/mach-msm/include/mach/memory.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* arch/arm/mach-msm/include/mach/memory.h
- *
- * Copyright (C) 2007 Google, Inc.
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
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-/* physical offset of RAM */
-#if defined(CONFIG_ARCH_QSD8X50) && defined(CONFIG_MSM_SOC_REV_A)
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-#elif defined(CONFIG_ARCH_QSD8X50)
-#define PLAT_PHYS_OFFSET		UL(0x20000000)
-#elif defined(CONFIG_ARCH_MSM7X30)
-#define PLAT_PHYS_OFFSET		UL(0x00200000)
-#elif defined(CONFIG_ARCH_MSM8X60)
-#define PLAT_PHYS_OFFSET		UL(0x40200000)
-#elif defined(CONFIG_ARCH_MSM8960)
-#define PLAT_PHYS_OFFSET		UL(0x40200000)
-#else
-#define PLAT_PHYS_OFFSET		UL(0x10000000)
-#endif
-
-#endif
-
-- 
1.7.4
