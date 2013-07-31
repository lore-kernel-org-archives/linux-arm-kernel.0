From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 01 Aug 2013 04:01:46 +0900
Subject: [PATCH 04/13] ARM: shmobile: Use default ->init_time() on r8a7779
In-Reply-To: <20130731190110.31796.96552.sendpatchset@w520>
References: <20130731190110.31796.96552.sendpatchset@w520>
Message-ID: <20130731190146.31796.53837.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Leave ->init_time() set to NULL to use the default ARM behaviour.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7779.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-08-01 03:03:30.000000000 +0900
@@ -667,7 +667,6 @@ DT_MACHINE_START(R8A7779_DT, "Generic R8
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= r8a7779_add_standard_devices_dt,
-	.init_time	= shmobile_timer_init,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
