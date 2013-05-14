From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:37 +0200
Subject: [PATCH 04/20] ARM: picoxcell: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for picoxcell as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
index 70b441a..c2721ce 100644
--- a/arch/arm/mach-picoxcell/common.c
+++ b/arch/arm/mach-picoxcell/common.c
@@ -9,7 +9,6 @@
  */
 #include <linux/delay.h>
 #include <linux/irq.h>
-#include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -87,7 +86,6 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
 	.map_io		= picoxcell_map_io,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= irqchip_init,
 	.init_time	= dw_apb_timer_init,
 	.init_machine	= picoxcell_init_machine,
 	.dt_compat	= picoxcell_dt_match,
-- 
1.8.1.2
