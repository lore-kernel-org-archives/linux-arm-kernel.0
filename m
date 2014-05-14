From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 14 May 2014 16:26:57 +0900
Subject: [PATCH] ARM: shmobile: Minor cleanup of the Armadillo legacy board
 code
In-Reply-To: <cover.1400052350.git.horms+renesas@verge.net.au>
References: <cover.1400052350.git.horms+renesas@verge.net.au>
Message-ID: <fd105ecf17fe459d979f336a7389d87172a1cf6d.1400052350.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Cleanup the legacy Armadillo board code slightly by
removing the pointless eva_add_early_devices() function

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 2858f38..4eb9a13 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1299,11 +1299,6 @@ static void __init eva_earlytimer_init(void)
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
@@ -1318,7 +1313,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.map_io		= r8a7740_map_io,
-	.init_early	= eva_add_early_devices,
+	.init_early	= r8a7740_add_early_devices,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
-- 
1.8.5.2
