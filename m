From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 13 Dec 2011 07:31:37 +0100
Subject: [PATCH 05/19] cpuimx25: add watchdog support
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Message-ID: <1323757911-25217-5-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                |    1 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 65a7e57..388dd5a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -137,6 +137,7 @@ config MACH_EUKREA_CPUIMX25SD
 	select SOC_IMX25
 	select IMX_HAVE_PLATFORM_FLEXCAN
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_I2C
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 33a4c74..85e84b3 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -136,6 +136,7 @@ static void __init eukrea_cpuimx25_init(void)
 	imx25_add_mxc_nand(&eukrea_cpuimx25_nand_board_info);
 	imx25_add_imxdi_rtc(NULL);
 	imx25_add_fec(&mx25_fec_pdata);
+	imx25_add_imx2_wdt(NULL);
 
 	i2c_register_board_info(0, eukrea_cpuimx25_i2c_devices,
 				ARRAY_SIZE(eukrea_cpuimx25_i2c_devices));
-- 
1.7.6.4
