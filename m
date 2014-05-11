From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 12 May 2014 08:25:27 +0900
Subject: [PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
In-Reply-To: <20140511232508.20177.11556.sendpatchset@w520>
References: <20140511232508.20177.11556.sendpatchset@w520>
Message-ID: <20140511232527.20177.15638.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the Koelsch board support to use shmobile_init_delay()
to be able to migrate away from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch-reference.c |    2 +-
 arch/arm/mach-shmobile/board-koelsch.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-05-12 08:04:07.000000000 +0900
@@ -139,7 +139,7 @@ static const char * const koelsch_boards
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2014-05-12 08:03:53.000000000 +0900
@@ -522,7 +522,7 @@ static const char * const koelsch_boards
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_init,
 	.init_late	= shmobile_init_late,
