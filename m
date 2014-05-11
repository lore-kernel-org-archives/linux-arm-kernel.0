From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 12 May 2014 08:10:50 +0900
Subject: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
Message-ID: <20140511231050.19908.86623.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
and CPUIdle in case of C-code less board support for r8a7740.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Applies on top of renesas-devel-v3.15-rc5-20140511

 arch/arm/mach-shmobile/setup-r8a7740.c |    1 +
 1 file changed, 1 insertion(+)

--- 0003/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-04-24 17:55:06.000000000 +0900
@@ -927,6 +927,7 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= r8a7740_generic_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
 
