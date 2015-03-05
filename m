From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:25 +0900
Subject: [PATCH 09/11] ARM: shmobile: sh73a0: Remove unused
 sh73a0_add_standard_devices_dt()
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
Message-ID: <05813a8112cd0e38f14b53ecc2b381824cb2aeb4.1425518682.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

"ARM: shmobile: kzm9g-reference: Remove board C code and DT file"
removed the last user of sh73a0_add_standard_devices_dt(). Hence remove
this function.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 9 ---------
 arch/arm/mach-shmobile/sh73a0.h       | 1 -
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 48f2447..2f68459e 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -783,15 +783,6 @@ void __init sh73a0_add_early_devices(void)
 	shmobile_setup_console();
 }
 
-void __init sh73a0_add_standard_devices_dt(void)
-{
-	/* clocks are setup late during boot in the case of DT */
-#ifndef CONFIG_COMMON_CLK
-	sh73a0_clock_init();
-#endif
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 #define RESCNT2 IOMEM(0xe6188020)
 static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
 {
diff --git a/arch/arm/mach-shmobile/sh73a0.h b/arch/arm/mach-shmobile/sh73a0.h
index f037c64..5a80f18 100644
--- a/arch/arm/mach-shmobile/sh73a0.h
+++ b/arch/arm/mach-shmobile/sh73a0.h
@@ -77,7 +77,6 @@ extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
 extern void sh73a0_add_early_devices(void);
 extern void sh73a0_add_standard_devices(void);
-extern void sh73a0_add_standard_devices_dt(void);
 extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern void sh73a0_pm_init(void);
-- 
2.1.4
