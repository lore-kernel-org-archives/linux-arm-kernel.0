From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:51:04 +0900
Subject: [PATCH 12/14] ARM: shmobile: Use SMP on Koelsch
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <b6d5a1b1c3476225e897a2f706c0e7eca7b05984.1381299817.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable r8a7791 SMP support code on the Koelsch board.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index ea5846e..ace1711 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -39,6 +39,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_time	= rcar_gen2_timer_init,
-- 
1.8.4
