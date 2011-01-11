From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Tue, 11 Jan 2011 20:54:23 +0800
Subject: [PATCH v2 3/4] ARM: i.MX53 EVK: add spi nor device
In-Reply-To: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
References: <1294750464-8660-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294750464-8660-4-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

add spi board information for spi nor device

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_evk.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 739bc62..3b0d5ee 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -24,6 +24,8 @@
 #include <linux/fec.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -98,6 +100,17 @@ static struct fec_platform_data mx53_evk_fec_pdata = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static struct spi_board_info mx53_evk_spi_board_info[] __initdata = {
+	{
+		.modalias = "mtd_dataflash",
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_0,
+		.platform_data = NULL,
+	},
+};
+
 static int mx53_evk_spi_cs[] = {
 	EVK_ECSPI1_CS0,
 	EVK_ECSPI1_CS1,
@@ -122,6 +135,8 @@ static void __init mx53_evk_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
 
+	spi_register_board_info(mx53_evk_spi_board_info,
+		ARRAY_SIZE(mx53_evk_spi_board_info));
 	imx53_add_ecspi(0, &mx53_evk_spi_data);
 }
 
-- 
1.7.1
