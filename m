From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 31 Jan 2016 22:05:54 +0100
Subject: [PATCH] ARM: pxa: fix irq initialization for pxa3xx devicetree
Message-ID: <1454274354-4381-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The initialization of interrupt controller for devicetree platform was
done for pxa2xx platforms, but not for pxa3xx ones.

Fix this my adding the missing initialization call.

Fixes: 089d03629b04 ("ARM: pxa: add devicetree code for irq handling")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/pxa-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index bed3fa741f54..f128133a8f30 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -28,6 +28,7 @@ static const char *const pxa3xx_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(PXA_DT, "Marvell PXA3xx (Device Tree Support)")
 	.map_io		= pxa3xx_map_io,
+	.init_irq	= pxa3xx_dt_init_irq,
 	.handle_irq	= pxa3xx_handle_irq,
 	.restart	= pxa_restart,
 	.dt_compat	= pxa3xx_dt_board_compat,
-- 
2.1.4
