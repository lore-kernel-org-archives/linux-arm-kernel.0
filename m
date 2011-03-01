From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Tue, 1 Mar 2011 17:58:17 +0800
Subject: [PATCH V4 1/4] ARM: imx53_loco: add esdhc device support
Message-ID: <1298973500-2858-1-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index f065a0d..a72c833 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -162,6 +162,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 160899e..0a18f8d 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -213,6 +213,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
+	imx53_add_sdhci_esdhc_imx(0, NULL);
+	imx53_add_sdhci_esdhc_imx(2, NULL);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.7.1
