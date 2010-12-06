From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 6 Dec 2010 16:38:34 -0200
Subject: [PATCH 3/3] ARM: mx5/mx51_babbage: Add watchdog support
In-Reply-To: <1291660714-16396-2-git-send-email-fabio.estevam@freescale.com>
References: <1291660714-16396-1-git-send-email-fabio.estevam@freescale.com>
	<1291660714-16396-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1291660714-16396-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/Kconfig              |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 7f5a696..5011f42 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -17,6 +17,7 @@ comment "MX5 platforms:"
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
 	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 6442579..a896f84 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -387,6 +387,7 @@ static void __init mxc_board_init(void)
 	spi_register_board_info(mx51_babbage_spi_board_info,
 		ARRAY_SIZE(mx51_babbage_spi_board_info));
 	imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
+	imx51_add_imx2_wdt(0, NULL);
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.6.0.4
