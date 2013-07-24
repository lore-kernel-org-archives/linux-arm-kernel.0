From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 24 Jul 2013 16:30:42 +0900
Subject: [PATCH] ARM: shmobile: marzen: Switch to DT_MACHINE_START
Message-ID: <20130724073042.28351.33041.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Convert the marzen board to use DT_MACHINE_START. With this in
place all mach-shmobile boards use DT_MACHINE_START. Also, this
makes it possible for the r8a7779 SMP code to use DT for CPUs.

So appended DTB is the way forward on this board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-devel-20130724

 arch/arm/mach-shmobile/board-marzen.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2013-07-24 15:45:39.000000000 +0900
@@ -238,7 +238,7 @@ static void __init marzen_init(void)
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
-MACHINE_START(MARZEN, "marzen")
+DT_MACHINE_START(MARZEN, "marzen")
 	.smp		= smp_ops(r8a7779_smp_ops),
 	.map_io		= r8a7779_map_io,
 	.init_early	= r8a7779_add_early_devices,
