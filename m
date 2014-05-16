From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:47 +0900
Subject: [PATCH 6/9] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
Message-ID: <7e99497cf5e7b46ff5f434beae45f6f35005e8b6.1400200838.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the Koelsch board support to use shmobile_init_delay()
to be able to migrate away from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 2 +-
 arch/arm/mach-shmobile/board-koelsch.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a3fd302..ff33d9c 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -139,7 +139,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 5a034ff..3cd8008 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -522,7 +522,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_init,
 	.init_late	= shmobile_init_late,
-- 
1.8.5.2
