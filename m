From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:13:26 +0900
Subject: [PATCH 10/10] ARM: shmobile: Use SMP on Koelsch
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
Message-ID: <20131001081326.4136.95868.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable r8a7791 SMP support code on the Koelsch board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |    1 +
 1 file changed, 1 insertion(+)

--- 0008/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-01 16:40:07.000000000 +0900
@@ -39,6 +39,7 @@ static const char * const koelsch_boards
 };
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
+	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_time	= rcar_gen2_timer_init,
