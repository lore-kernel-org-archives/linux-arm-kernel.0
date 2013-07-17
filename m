From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:49 +0900
Subject: [PATCH 10/22] ARM: shmobile: kzm9g: Remove init_irq declaration in
 machine description
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <fc492ba58aa6642f34eba716daf6ec4d2715e492.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove redundant irqchip_init() callback. The default case
of NULL will result in invoking irqchip_init() anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
[ horms+renesas at verge.net.au: Trimmed patch to remove portion
  that updates the sh73a0 SoC and altered the subject to
  use the same format as the patch that updates the sh73a0. ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 44055fe..41092bb 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -24,7 +24,6 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
@@ -99,7 +98,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.init_machine	= kzm_init,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
-- 
1.7.10.4
