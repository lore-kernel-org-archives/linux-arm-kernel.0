From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 13 Jun 2016 21:25:48 +0900
Subject: [PATCH] ARM: remove unused CONFIG_ARCH_HAS_BARRIERS
Message-ID: <1465820748-7369-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 2b749cb3a515 ("ARM: realview: remove private barrier
implementation"), this config is not used by any platform.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/barrier.h | 4 +---
 arch/arm/mm/Kconfig            | 6 ------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 112cc1a..f5d6981 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -44,9 +44,7 @@ extern void arm_heavy_mb(void);
 #define __arm_heavy_mb(x...) dsb(x)
 #endif
 
-#ifdef CONFIG_ARCH_HAS_BARRIERS
-#include <mach/barriers.h>
-#elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
+#if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
 #define mb()		__arm_heavy_mb()
 #define rmb()		dsb()
 #define wmb()		__arm_heavy_mb(st)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index cb569b6..d15a7fe 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1025,12 +1025,6 @@ config ARM_DMA_MEM_BUFFERABLE
 
 	  You are recommended say 'Y' here and debug any affected drivers.
 
-config ARCH_HAS_BARRIERS
-	bool
-	help
-	  This option allows the use of custom mandatory barriers
-	  included via the mach/barriers.h file.
-
 config ARM_HEAVY_MB
 	bool
 
-- 
1.9.1
