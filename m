From: andre.silva@freescale.com (Andre Silva)
Date: Mon, 13 Jun 2011 14:31:58 -0300
Subject: [PATCH 2/2] ARM:mach-mx5/mx53_ard: Add Watchdog timer support
In-Reply-To: <1307986318-16324-1-git-send-email-andre.silva@freescale.com>
References: <1307986318-16324-1-git-send-email-andre.silva@freescale.com>
Message-ID: <1307986318-16324-2-git-send-email-andre.silva@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Silva <andre.silva@freescale.com>

---
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 9a8e6f8..5b16f39 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -212,6 +212,7 @@ config MACH_MX53_LOCO
 config MACH_MX53_ARD
 	bool "Support MX53 ARD platforms"
 	select SOC_IMX53
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 5d98dbf..7dd54b9 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -178,6 +178,7 @@ static void __init mx53_ard_board_init(void)
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
+	imx53_add_imx2_wdt(0, NULL);
 }
 
 static void __init mx53_ard_timer_init(void)
-- 
1.7.1
