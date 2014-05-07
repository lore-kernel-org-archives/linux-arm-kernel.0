From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 May 2014 08:37:53 +0900
Subject: [PATCH] ARM: shmobile: Minor cleanup of the Armadillo legacy board
 code
Message-ID: <20140507233753.29842.55463.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Cleanup the legacy Armadillo board code slightly by
removing the pointless eva_add_early_devices() function

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.15-rc3-20140502

 arch/arm/mach-shmobile/board-armadillo800eva.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva.c	2014-04-24 18:11:16.000000000 +0900
@@ -1300,11 +1300,6 @@ static void __init eva_earlytimer_init(v
 	eva_clock_init();
 }
 
-static void __init eva_add_early_devices(void)
-{
-	r8a7740_add_early_devices();
-}
-
 #define RESCNT2 IOMEM(0xe6188020)
 static void eva_restart(enum reboot_mode mode, const char *cmd)
 {
@@ -1319,7 +1314,7 @@ static const char *eva_boards_compat_dt[
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.map_io		= r8a7740_map_io,
-	.init_early	= eva_add_early_devices,
+	.init_early	= r8a7740_add_early_devices,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
