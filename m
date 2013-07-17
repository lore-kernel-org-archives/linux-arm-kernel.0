From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:32:09 +0900
Subject: [PATCH 08/22] ARM: shmobile: lager: Remove init_irq declaration in
 machine description
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <5f85052c606e38c98de28170a2df72f78931aa30.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove redundant irqchip_init() callback. The default case
of NULL will result in invoking irqchip_init() anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
[ horms+renesas at verge.net.au: Trimmed patch to remove portion
  that updates the r8a7790 SoC and altered the subject to
  use the same format as the patch that updates the r8a7790. ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d73e21d..1e99b17 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -22,7 +22,6 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/pinctrl/machine.h>
@@ -103,7 +102,6 @@ static const char *lager_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(LAGER_DT, "lager")
-	.init_irq	= irqchip_init,
 	.init_time	= r8a7790_timer_init,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
-- 
1.7.10.4
