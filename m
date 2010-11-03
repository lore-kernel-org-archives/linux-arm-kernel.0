From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 3 Nov 2010 13:53:44 -0700 (PDT)
Subject: [PATCH v2] mx51_3ds: Add esdhc support
Message-ID: <895982.34875.qm@web51003.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for esdhc on mx51_3ds board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index b03d68e..74468e3 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -25,6 +25,7 @@ config MACH_MX51_3DS
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
+	select IMX_HAVE_PLATFORM_ESDHC
 	help
 	  Include support for MX51PDK (3DS) platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index ba5805f..d731104 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -172,6 +172,7 @@ static void __init mxc_board_init(void)
 		printk(KERN_WARNING "Init of the debugboard failed, all "
 				    "devices on the board are unusable.\n");
 
+	imx51_add_esdhc(0, NULL);
 	mxc_init_keypad();
 }
 
-- 
1.6.0.4


      
