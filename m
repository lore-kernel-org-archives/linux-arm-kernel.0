From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 15:01:31 +0900
Subject: [PATCH 03/04] ARM: shmobile: Use default ->init_irq() on r8a7790
In-Reply-To: <20130701060103.21728.83833.sendpatchset@w520>
References: <20130701060103.21728.83833.sendpatchset@w520>
Message-ID: <20130701060131.21728.85765.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove redundant irqchip_init() callback. The default case
of NULL will result in invoking irqchip_init() anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-lager.c   |    2 --
 arch/arm/mach-shmobile/setup-r8a7790.c |    2 --
 2 files changed, 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-lager.c
+++ work/arch/arm/mach-shmobile/board-lager.c	2013-07-01 13:27:30.000000000 +0900
@@ -22,7 +22,6 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/pinctrl/machine.h>
@@ -104,7 +103,6 @@ static const char *lager_boards_compat_d
 
 DT_MACHINE_START(LAGER_DT, "lager")
 	.init_early	= r8a7790_init_delay,
-	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
--- 0008/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-07-01 13:27:52.000000000 +0900
@@ -19,7 +19,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/gpio-rcar.h>
@@ -225,7 +224,6 @@ static const char *r8a7790_boards_compat
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.init_early	= r8a7790_init_delay,
-	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
