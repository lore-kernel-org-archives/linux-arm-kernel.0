From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:43:30 +0900
Subject: [PATCH 1/8] ARM: shmobile: kzm9g: Add shmobile_init_late()
In-Reply-To: <cover.1408671094.git.horms+renesas@verge.net.au>
References: <cover.1408671094.git.horms+renesas@verge.net.au>
Message-ID: <eeed09e8116f9932b55aa284d109bdea1e2ddc46.1408671094.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend board specific KZM9D DT reference machine vector to include
shmobile_init_late() so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 5d2621f..9ec9887 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -54,5 +54,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= kzm_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
2.0.1
