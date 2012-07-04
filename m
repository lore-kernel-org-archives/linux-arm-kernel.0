From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 4 Jul 2012 16:36:28 +0200 (CEST)
Subject: [PATCH 3 of 3] ARM: imx: add rtc support to mx35_3ds
Message-ID: <656646260.702972.1341412588384.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that RTC support has been enabled for i.MX35, add RTC to the mx35_3ds board.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../arch/arm/mach-imx/Kconfig                      |    1 +
 .../arch/arm/mach-imx/mach-mx35_3ds.c              |    1 +
 2 files changed, 2 insertions(+)

diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/Kconfig linux-next-HEAD-f9637ba/arch/arm/mach-imx/Kconfig
index eff4db5..4baf5ab 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/Kconfig
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/Kconfig
@@ -589,6 +589,7 @@ config MACH_MX35_3DS
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_MXC_RTC
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX35PDK platform. This includes specific
diff --git linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx35_3ds.c linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx35_3ds.c
index 11afe00..25db220 100644
--- linux-next-HEAD-f9637ba.orig/arch/arm/mach-imx/mach-mx35_3ds.c
+++ linux-next-HEAD-f9637ba/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -562,6 +562,7 @@ static void __init mx35_3ds_init(void)
 
 	imx35_add_fec(NULL);
 	imx35_add_imx2_wdt();
+	imx35_add_mxc_rtc();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx35_add_imx_uart0(&uart_pdata);
