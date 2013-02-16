From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 19:43:36 +0000
Subject: [PATCH] ARM: Dove: fix build breakage with .timer/.init_time
Message-ID: <1361043816-28753-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the latest arm-soc/for-next, building dove_defconfig breaks because
.timer has been replaced with .init_timer in DT_MACHINE_START.  With
this fix, it builds fine.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---

Not sure where you guys want to apply this.  If I apply it to any one my
branches (without arm-soc/for-next), they break.

 arch/arm/mach-dove/board-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index ee11b31..fbde1dd 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -85,7 +85,7 @@ DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
 	.map_io		= dove_map_io,
 	.init_early	= dove_init_early,
 	.init_irq	= orion_dt_init_irq,
-	.timer		= &dove_timer,
+	.init_time	= dove_timer_init,
 	.init_machine	= dove_dt_init,
 	.restart	= dove_restart,
 	.dt_compat	= dove_dt_board_compat,
-- 
1.8.1.2
