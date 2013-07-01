From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 15:01:12 +0900
Subject: [PATCH 01/04] ARM: shmobile: Use default ->init_irq() on EMEV2
In-Reply-To: <20130701060103.21728.83833.sendpatchset@w520>
References: <20130701060103.21728.83833.sendpatchset@w520>
Message-ID: <20130701060112.21728.37189.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove redundant irqchip_init() callback. The default case
of NULL will result in invoking irqchip_init() anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    2 --
 1 file changed, 2 deletions(-)

--- 0005/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-07-01 13:33:39.000000000 +0900
@@ -20,7 +20,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-em.h>
 #include <linux/of_platform.h>
@@ -445,7 +444,6 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma
 	.smp		= smp_ops(emev2_smp_ops),
 	.init_early	= emev2_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
