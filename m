From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 20 May 2014 08:37:42 +0900
Subject: [PATCH 03/03] ARM: shmobile: Remove unused r8a7790_init_early()
In-Reply-To: <20140519233714.10496.31390.sendpatchset@w520>
References: <20140519233714.10496.31390.sendpatchset@w520>
Message-ID: <20140519233742.10496.54331.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the now unused r8a7790_init_early() function.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7790.c        |    7 -------
 2 files changed, 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2014-05-19 22:26:16.000000000 +0900
@@ -33,7 +33,6 @@ void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_pm_init(void);
-void r8a7790_init_early(void);
 extern struct smp_operations r8a7790_smp_ops;
 
 #endif /* __ASM_R8A7790_H__ */
--- 0003/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-05-19 22:25:49.000000000 +0900
@@ -307,13 +307,6 @@ void __init r8a7790_add_standard_devices
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
