From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:20:21 +0200
Subject: [PATCH 06/12] ARM: imx: eukrea_cpuimx51sd: add watchdog support
In-Reply-To: <1336461627-30315-1-git-send-email-eric@eukrea.com>
References: <1336461627-30315-1-git-send-email-eric@eukrea.com>
Message-ID: <1336461627-30315-6-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig           |    1 +
 arch/arm/mach-imx/mach-cpuimx51sd.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 2f824d8..96b1c77 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -691,6 +691,7 @@ config MACH_EUKREA_CPUIMX51SD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 9fbe923..3e1d9fe 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -272,6 +272,7 @@ static void __init eukrea_cpuimx51sd_init(void)
 
 	imx51_add_imx_uart(0, &uart_pdata);
 	imx51_add_mxc_nand(&eukrea_cpuimx51sd_nand_board_info);
+	imx51_add_imx2_wdt(0, NULL);
 
 	gpio_request(ETH_RST, "eth_rst");
 	gpio_set_value(ETH_RST, 1);
-- 
1.7.7.6
