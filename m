From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:22 +0900
Subject: [PATCH 5/7] ARM: shmobile: r8a7790: Remove init_irq declaration in
 machine description
In-Reply-To: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645224-3728-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for shmobile as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 49de2d5..2a7a276 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
@@ -142,7 +141,6 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.init_irq	= irqchip_init,
 	.init_machine	= r8a7790_add_standard_devices_dt,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
-- 
1.7.10.4
