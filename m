From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  6 Feb 2016 22:48:35 +0100
Subject: [PATCH] ARM: pxa: pxa3xx device-tree support cleanup
Message-ID: <1454795315-11294-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clocks, timer and several other drivers have well defined and working
device-tree bindings. Clean-up the code to leave only the strict
minimum. The final goal will be to remove the lookup array.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa-dt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index 8e0e62ccdced..f128133a8f30 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -19,42 +19,18 @@
 #include "generic.h"
 
 #ifdef CONFIG_PXA3xx
-static const struct of_dev_auxdata const pxa3xx_auxdata_lookup[] __initconst = {
-	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40100000, "pxa2xx-uart.0", NULL),
-	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40200000, "pxa2xx-uart.1", NULL),
-	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x40700000, "pxa2xx-uart.2", NULL),
-	OF_DEV_AUXDATA("mrvl,pxa-uart",		0x41600000, "pxa2xx-uart.3", NULL),
-	OF_DEV_AUXDATA("marvell,pxa-mmc",	0x41100000, "pxa2xx-mci.0", NULL),
-	OF_DEV_AUXDATA("intel,pxa3xx-gpio",	0x40e00000, "pxa3xx-gpio", NULL),
-	OF_DEV_AUXDATA("marvell,pxa-ohci",	0x4c000000, "pxa27x-ohci", NULL),
-	OF_DEV_AUXDATA("mrvl,pxa-i2c",		0x40301680, "pxa2xx-i2c.0", NULL),
-	OF_DEV_AUXDATA("mrvl,pwri2c",		0x40f500c0, "pxa3xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("marvell,pxa3xx-nand",	0x43100000, "pxa3xx-nand", NULL),
-	{}
-};
-
-static void __init pxa3xx_dt_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     pxa3xx_auxdata_lookup, NULL);
-}
-
 static const char *const pxa3xx_dt_board_compat[] __initconst = {
 	"marvell,pxa300",
 	"marvell,pxa310",
 	"marvell,pxa320",
 	NULL,
 };
-#endif
 
-#ifdef CONFIG_PXA3xx
 DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
 	.map_io		= pxa3xx_map_io,
 	.init_irq	= pxa3xx_dt_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
-	.init_time	= pxa_timer_init,
 	.restart	= pxa_restart,
-	.init_machine	= pxa3xx_dt_init,
 	.dt_compat	= pxa3xx_dt_board_compat,
 MACHINE_END
 #endif
-- 
2.1.4
