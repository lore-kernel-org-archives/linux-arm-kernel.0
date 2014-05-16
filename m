From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 13:43:00 +0900
Subject: [PATCH 3/4] ARM: shmobile: marzen-reference: Use DT CPU Frequency
In-Reply-To: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
References: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400215381-7027-4-git-send-email-horms+renesas@verge.net.au>
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
index c6c133d..dbfec58 100644
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
1.8.5.2
