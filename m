From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 18:07:11 +0100
Subject: [PATCH 1/3] ARM: mvebu: remove unneeded ->map_io field for Armada
 370/XP
In-Reply-To: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392138433-12573-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ->map_io() implementation of Armada 370/XP simply calls
debug_ll_io_init(), which is exactly what the kernel does when
->map_io is NULL. Therefore, there is no need to have a specific
->map_io() implementation in Armada 370/XP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index f6c9d1d..161cf2f 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -31,11 +31,6 @@
 #include "coherency.h"
 #include "mvebu-soc-id.h"
 
-static void __init armada_370_xp_map_io(void)
-{
-	debug_ll_io_init();
-}
-
 static void __init armada_370_xp_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
@@ -90,7 +85,6 @@ static const char * const armada_370_xp_dt_compat[] = {
 DT_MACHINE_START(ARMADA_XP_DT, "Marvell Armada 370/XP (Device Tree)")
 	.smp		= smp_ops(armada_xp_smp_ops),
 	.init_machine	= armada_370_xp_dt_init,
-	.map_io		= armada_370_xp_map_io,
 	.init_time	= armada_370_xp_timer_and_clk_init,
 	.restart	= mvebu_restart,
 	.dt_compat	= armada_370_xp_dt_compat,
-- 
1.8.3.2
