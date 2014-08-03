From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  3 Aug 2014 16:10:30 +0400
Subject: [PATCH] ARM: i.MX: Remove mxc_arch_reset_init_dt() call for i.MX1
Message-ID: <1407067830-10985-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX1 watchdog is not compatible with other i.MX SOCs, so
remove call of mxc_arch_reset_init_dt() for this CPU.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/imx1-dt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-imx/imx1-dt.c b/arch/arm/mach-imx/imx1-dt.c
index 05da661..6f915b0 100644
--- a/arch/arm/mach-imx/imx1-dt.c
+++ b/arch/arm/mach-imx/imx1-dt.c
@@ -12,13 +12,6 @@
 
 #include "common.h"
 
-static void __init imx1_dt_init(void)
-{
-	mxc_arch_reset_init_dt();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const imx1_dt_board_compat[] __initconst = {
 	"fsl,imx1",
 	NULL
@@ -28,7 +21,6 @@ DT_MACHINE_START(IMX1_DT, "Freescale i.MX1 (Device Tree Support)")
 	.map_io		= mx1_map_io,
 	.init_early	= imx1_init_early,
 	.init_irq	= mx1_init_irq,
-	.init_machine	= imx1_dt_init,
 	.dt_compat	= imx1_dt_board_compat,
 	.restart	= mxc_restart,
 MACHINE_END
-- 
1.8.5.5
