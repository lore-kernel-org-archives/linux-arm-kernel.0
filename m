From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 20 Jan 2015 20:58:20 +0900
Subject: [PATCH 03/03] ARM: shmobile: Remove mach/uncompress.h
In-Reply-To: <20150120115750.11479.95109.sendpatchset@little-apple>
References: <20150120115750.11479.95109.sendpatchset@little-apple>
Message-ID: <20150120115820.11479.4763.sendpatchset@little-apple>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert ARCH_SHMOBILE_LEGACY to make use of <debug/uncompress.h>
and remove the now unused <mach/uncompress.h>.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/Kconfig.debug                           |    3 ++-
 arch/arm/mach-shmobile/include/mach/uncompress.h |   19 -------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

--- 0001/arch/arm/Kconfig.debug
+++ work/arch/arm/Kconfig.debug	2015-01-20 20:26:10.527765900 +0900
@@ -1441,7 +1441,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARCH_EFM32
+					PLAT_SAMSUNG || ARCH_EFM32 || \
+					ARCH_SHMOBILE_LEGACY
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
--- 0001/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ /dev/null	2015-01-13 15:44:39.280208949 +0900
@@ -1,19 +0,0 @@
-#ifndef __ASM_MACH_UNCOMPRESS_H
-#define __ASM_MACH_UNCOMPRESS_H
-
-/*
- * This does not append a newline
- */
-static void putc(int c)
-{
-}
-
-static inline void flush(void)
-{
-}
-
-static void arch_decomp_setup(void)
-{
-}
-
-#endif /* __ASM_MACH_UNCOMPRESS_H */
