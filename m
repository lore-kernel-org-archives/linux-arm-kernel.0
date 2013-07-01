From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 15:01:40 +0900
Subject: [PATCH 04/04] ARM: shmobile: Use default ->init_irq() on sh73a0
In-Reply-To: <20130701060103.21728.83833.sendpatchset@w520>
References: <20130701060103.21728.83833.sendpatchset@w520>
Message-ID: <20130701060140.21728.27213.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove redundant irqchip_init() callback. The default case
of NULL will result in invoking irqchip_init() anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 --
 arch/arm/mach-shmobile/setup-sh73a0.c          |    2 --
 2 files changed, 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2013-06-28 16:04:39.000000000 +0900
@@ -24,7 +24,6 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
@@ -99,7 +98,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-refere
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
--- 0007/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-06-28 16:04:47.000000000 +0900
@@ -22,7 +22,6 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/delay.h>
@@ -983,7 +982,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.init_machine	= sh73a0_add_standard_devices_dt,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
