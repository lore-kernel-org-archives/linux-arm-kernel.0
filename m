From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:32 +0900
Subject: [PATCH 3/4] ARM: shmobile: Remove mach/uncompress.h
In-Reply-To: <cover.1424931049.git.horms+renesas@verge.net.au>
References: <cover.1424931049.git.horms+renesas@verge.net.au>
Message-ID: <bb04883b2519b23bb4d3f4f7dac51cdda9a5e61d.1424931049.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert ARCH_SHMOBILE_LEGACY to make use of <debug/uncompress.h>
and remove the now unused <mach/uncompress.h>.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig.debug                           |  3 ++-
 arch/arm/mach-shmobile/include/mach/uncompress.h | 19 -------------------
 2 files changed, 2 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de75..1ca8dc7 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1573,7 +1573,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARCH_EFM32
+					PLAT_SAMSUNG || ARCH_EFM32 || \
+					ARCH_SHMOBILE_LEGACY
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-shmobile/include/mach/uncompress.h b/arch/arm/mach-shmobile/include/mach/uncompress.h
deleted file mode 100644
index f1aee567..0000000
--- a/arch/arm/mach-shmobile/include/mach/uncompress.h
+++ /dev/null
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
-- 
2.1.4
