From: daiane.angolini@freescale.com (Daiane Angolini)
Date: Thu, 9 Dec 2010 15:50:49 -0200
Subject: [PATCH] ARM: mx5/mx51_3ds: Add watchdog support
Message-ID: <1291917049-8183-1-git-send-email-daiane.angolini@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daiane Angolini <daiane.angolini@freescale.com>
---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 5011f42..b6180e5 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -30,6 +30,7 @@ config MACH_MX51_BABBAGE
 config MACH_MX51_3DS
 	bool "Support MX51PDK (3DS)"
 	select SOC_IMX51
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 6cc2805..54b3f25 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -174,6 +174,7 @@ static void __init mxc_board_init(void)
 
 	imx51_add_sdhci_esdhc_imx(0, NULL);
 	mxc_init_keypad();
+	imx51_add_imx2_wdt(0, NULL);
 }
 
 static void __init mx51_3ds_timer_init(void)
-- 
1.7.0.4
