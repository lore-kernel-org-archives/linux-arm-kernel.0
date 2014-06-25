From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:35 +0900
Subject: [PATCH 5/5] ARM: shmobile: Enable R-Car Gen2 CMA code in board files
In-Reply-To: <cover.1403681531.git.horms+renesas@verge.net.au>
References: <cover.1403681531.git.horms+renesas@verge.net.au>
Message-ID: <5f65c5bd58bf027eb2bacc2294a98e7aea81c630.1403681531.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook in the R-Car Gen2 CMA reservation code in the board
files for Lager and Koelsch. Both the DT-reference code
and the legacy code is modified.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 1 +
 arch/arm/mach-shmobile/board-koelsch.c           | 1 +
 arch/arm/mach-shmobile/board-lager-reference.c   | 1 +
 arch/arm/mach-shmobile/board-lager.c             | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 28e3c45..5e0375f 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -113,5 +113,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 0d44e7eb..db4b8a3 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -526,5 +526,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 9e0624e..c5e656e 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -119,5 +119,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 83bbb5c..a51d202 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -891,5 +891,6 @@ DT_MACHINE_START(LAGER_DT, "lager")
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= lager_init,
 	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
-- 
2.0.0.rc2
