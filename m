From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 May 2013 17:38:49 +0200
Subject: [PATCH 16/20] ARM: mxs: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1368545933-7430-17-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
specified") removed the need to explictly setup the init_irq field in
the machine description when using only irqchip_init. Remove that
declaration for mxs as well.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 5b62b64..66fe810 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
-#include <linux/irqchip.h>
 #include <linux/irqchip/mxs.h>
 #include <linux/micrel_phy.h>
 #include <linux/of_address.h>
@@ -435,7 +434,6 @@ static const char *mxs_dt_compat[] __initdata = {
 
 DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
 	.map_io		= debug_ll_io_init,
-	.init_irq	= irqchip_init,
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= mxs_timer_init,
 	.init_machine	= mxs_machine_init,
-- 
1.8.1.2
