From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 13:56:55 +0800
Subject: [PATCH] ARM: imx: remove .map_io from imx6sl machine descriptor
Message-ID: <1383285415-3504-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since bc37324 (ARM: mmu: Call debug_ll_io_init if no map_io function is
specified), the .map_io hook can be saved if calling debug_ll_io_init()
is the only thing to be done in there.  So the .map_io hook imx6sl
machine descriptor can just be dropped.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6sl.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 2f952e3..2c6f63a 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -67,7 +67,6 @@ static const char *imx6sl_dt_compat[] __initdata = {
 };
 
 DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
-	.map_io		= debug_ll_io_init,
 	.init_irq	= imx6sl_init_irq,
 	.init_machine	= imx6sl_init_machine,
 	.dt_compat	= imx6sl_dt_compat,
-- 
1.7.9.5
