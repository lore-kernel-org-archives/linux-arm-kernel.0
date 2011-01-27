From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 27 Jan 2011 15:00:19 -0200
Subject: [PATCH] ARM: mach-mx3/mach-mx31_3ds: Remove unnecessary function for
	IO mapping
Message-ID: <1296147619-9600-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/mach-mx31_3ds.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 0d65db8..2f41430 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -320,14 +320,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-/*
- * Set up static virtual mappings.
- */
-static void __init mx31_3ds_map_io(void)
-{
-	mx31_map_io();
-}
-
 /*!
  * Board specific initialization.
  */
@@ -382,7 +374,7 @@ static struct sys_timer mx31_3ds_timer = {
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
 	.boot_params    = MX3x_PHYS_OFFSET + 0x100,
-	.map_io         = mx31_3ds_map_io,
+	.map_io         = mx31_map_io,
 	.init_irq       = mx31_init_irq,
 	.init_machine   = mxc_board_init,
 	.timer          = &mx31_3ds_timer,
-- 
1.6.0.4
