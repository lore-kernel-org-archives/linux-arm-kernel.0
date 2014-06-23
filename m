From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:56 +0900
Subject: [PATCH 9/9] ARM: shmobile: Remove unused r8a7790_init_early()
In-Reply-To: <cover.1403487831.git.horms+renesas@verge.net.au>
References: <cover.1403487831.git.horms+renesas@verge.net.au>
Message-ID: <d83fa4c9c27c4d8612e39e99506b5420fa05b58b.1403487831.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the now unused r8a7790_init_early() function.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h | 1 -
 arch/arm/mach-shmobile/setup-r8a7790.c        | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index d755544..459827f 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -31,7 +31,6 @@ void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_pm_init(void);
-void r8a7790_init_early(void);
 extern struct smp_operations r8a7790_smp_ops;
 
 #endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 9c2bc16..ee5daccf3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -308,13 +308,6 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_audio_dmac(1);
 }
 
-void __init r8a7790_init_early(void)
-{
-#ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1300, 2, 4); /* Cortex-A15 @ 1300MHz */
-#endif
-}
-
 #ifdef CONFIG_USE_OF
 
 static const char * const r8a7790_boards_compat_dt[] __initconst = {
-- 
2.0.0.rc2
