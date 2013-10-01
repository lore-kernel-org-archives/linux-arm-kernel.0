From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:12:57 +0900
Subject: [PATCH 07/10] ARM: shmobile: Use arch timer on Koelsch
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
Message-ID: <20131001081257.4136.80053.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make use of the R-Car Gen2 arch timer workaround on Koelsch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |    2 ++
 1 file changed, 2 insertions(+)

--- 0003/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-01 16:35:52.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a7791.h>
+#include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -40,5 +41,6 @@ static const char * const koelsch_boards
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_early	= r8a7791_init_early,
 	.init_machine	= koelsch_add_standard_devices,
+	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
