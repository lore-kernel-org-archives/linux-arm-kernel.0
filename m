From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 17 Feb 2011 16:57:46 -0200
Subject: [PATCH 2/2] ARM: mach-mx5: Add watchdog support for MX53 based boards
In-Reply-To: <1297969066-14810-1-git-send-email-fabio.estevam@freescale.com>
References: <1297969066-14810-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1297969066-14810-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/Kconfig           |    3 +++
 arch/arm/mach-mx5/board-mx53_evk.c  |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c  |    1 +
 4 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 10b6008..8441462 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -128,6 +128,7 @@ config MACH_MX53_EVK
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -138,6 +139,7 @@ config MACH_MX53_SMD
 	bool "Support MX53 SMD platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	help
 	  Include support for MX53 SMD platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -146,6 +148,7 @@ config MACH_MX53_LOCO
 	bool "Support MX53 LOCO platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 8ed316b..652e1e0 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -137,6 +137,7 @@ static void __init mx53_evk_board_init(void)
 	spi_register_board_info(mx53_evk_spi_board_info,
 		ARRAY_SIZE(mx53_evk_spi_board_info));
 	imx53_add_ecspi(0, &mx53_evk_spi_data);
+	imx53_add_imx2_wdt(0, NULL);
 }
 
 static void __init mx53_evk_timer_init(void)
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 0fea252..6005f49 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -69,6 +69,7 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_uart(0, NULL);
 	mx53_loco_fec_reset();
 	imx53_add_fec(&mx53_loco_fec_data);
+	imx53_add_imx2_wdt(0, NULL);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index fa0fad8..8a8694c 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -90,6 +90,7 @@ static void __init mx53_smd_board_init(void)
 	mx53_smd_init_uart();
 	mx53_smd_fec_reset();
 	imx53_add_fec(&mx53_smd_fec_data);
+	imx53_add_imx2_wdt(0, NULL);
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.6.0.4
