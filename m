From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:38:27 +0900
Subject: [GIT PULL 10/26] ARM: shmobile: Use default ->init_time() on Bockw
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
Message-ID: <9808f79327806e00e681c18ac84e8abfa4373dbf.1375840527.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index b6f3d2f..b40885de 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -273,7 +273,6 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_machine	= bockw_init,
-	.init_time	= shmobile_timer_init,
 	.dt_compat	= bockw_boards_compat_dt,
 	.init_late      = r8a7778_init_late,
 MACHINE_END
-- 
1.8.3.2
