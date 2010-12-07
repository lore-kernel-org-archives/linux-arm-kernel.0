From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 7 Dec 2010 17:14:44 -0200
Subject: [PATCH 1/2] ARM: mx3/mx31_3ds: Add watchdog support
Message-ID: <1291749285-11406-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx31_3ds.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 165e722..9037c4e 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -93,6 +93,7 @@ config MACH_MX31_3DS
 	select SOC_IMX31
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index e4efbfe..c488491 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -252,6 +252,7 @@ static void __init mxc_board_init(void)
 	if (mxc_expio_init(MX31_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		printk(KERN_WARNING "Init of the debug board failed, all "
 				    "devices on the debug board are unusable.\n");
+	imx31_add_imx2_wdt(NULL);
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.6.0.4
