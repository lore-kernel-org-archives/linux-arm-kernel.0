From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 19 Sep 2011 10:59:46 -0300
Subject: [PATCH] ARM: mach-qong: Add watchdog support
Message-ID: <1316440786-21118-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add watchdog support for mach-qong target.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig     |    1 +
 arch/arm/mach-imx/mach-qong.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0519dd7..8748531 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -485,6 +485,7 @@ config MACH_QONG
 	bool "Support Dave/DENX QongEVB-LITE platform"
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	help
 	  Include support for Dave/DENX QongEVB-LITE platform. This includes
 	  specific configurations for the board and its peripherals.
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 3626f48..44462ce 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -249,6 +249,7 @@ static void __init qong_init(void)
 	mxc_init_imx_uart();
 	qong_init_nor_mtd();
 	qong_init_fpga();
+	imx31_add_imx2_wdt(NULL);
 }
 
 static void __init qong_timer_init(void)
-- 
1.6.0.4
