From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:30 +0900
Subject: [PATCH 17/24] ARM: shmobile: marzen-reference: Use DT CPU Frequency
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <17ed9efd8afdd8c38f19ff72f08e71c1fd2376e3.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Marzen DT reference board support to use shmobile_init_delay()
to be able to migrate away from per-SoC delay setup functions.

Based on work for the Armadillo800 EVA board by Magnus Damm.

Cc: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 1b63686..bb2df32 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -66,7 +66,7 @@ static const char *marzen_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
-	.init_early	= r8a7779_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_time	= marzen_init_timer,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
-- 
2.0.0.rc2
