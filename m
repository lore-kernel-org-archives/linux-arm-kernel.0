From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 30 Sep 2013 18:03:27 -0300
Subject: [PATCH 1/4] ARM: kirkwood: Remove unneeded MBus initialization
In-Reply-To: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1380575010-8573-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the MBus is initialized from the DT, it's not necessary to
call the legacy initialization.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-kirkwood/board-dt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 82d3ad8..ee6297e 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -72,13 +72,6 @@ static void __init kirkwood_dt_time_init(void)
 	clocksource_of_init();
 }
 
-static void __init kirkwood_dt_init_early(void)
-{
-	mvebu_mbus_init("marvell,kirkwood-mbus",
-			BRIDGE_WINS_BASE, BRIDGE_WINS_SZ,
-			DDR_WINDOW_CPU_BASE, DDR_WINDOW_CPU_SZ);
-}
-
 static void __init kirkwood_dt_init(void)
 {
 	pr_info("Kirkwood: %s, TCLK=%d.\n", kirkwood_id(), kirkwood_tclk);
@@ -121,7 +114,6 @@ static const char * const kirkwood_dt_board_compat[] = {
 DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
 	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
 	.map_io		= kirkwood_map_io,
-	.init_early	= kirkwood_dt_init_early,
 	.init_time	= kirkwood_dt_time_init,
 	.init_machine	= kirkwood_dt_init,
 	.restart	= kirkwood_restart,
-- 
1.8.1.5
