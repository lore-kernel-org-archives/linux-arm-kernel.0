From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 12 May 2014 08:25:37 +0900
Subject: [PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()
In-Reply-To: <20140511232508.20177.11556.sendpatchset@w520>
References: <20140511232508.20177.11556.sendpatchset@w520>
Message-ID: <20140511232537.20177.39308.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove the now unused r8a7791_init_early() function.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7791.c        |    7 -------
 2 files changed, 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7791.h	2014-05-12 08:05:58.000000000 +0900
@@ -5,7 +5,6 @@ void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_pinmux_init(void);
-void r8a7791_init_early(void);
 extern struct smp_operations r8a7791_smp_ops;
 
 #endif /* __ASM_R8A7791_H__ */
--- 0006/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-05-12 08:05:22.000000000 +0900
@@ -207,13 +207,6 @@ void __init r8a7791_add_standard_devices
 	r8a7791_register_thermal();
 }
 
-void __init r8a7791_init_early(void)
-{
-#ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
-#endif
-}
-
 #ifdef CONFIG_USE_OF
 static const char *r8a7791_boards_compat_dt[] __initdata = {
 	"renesas,r8a7791",
