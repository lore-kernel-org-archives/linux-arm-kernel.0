From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 4 Apr 2011 09:50:49 -0300
Subject: [PATCH v3] ARM: mx5/mx53_smd: Add esdhc support
Message-ID: <1301921449-32194-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Add esdhc entry into Kconfig
Changes since v1:
- Do not use CD detecion via GPIO as it is not working for MX53 yet.
 arch/arm/mach-mx5/Kconfig          |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 83ee088..697f44b 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -154,6 +154,7 @@ config MACH_MX53_SMD
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX53 SMD platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index 31e1732..e510c27 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -52,6 +52,31 @@ static iomux_v3_cfg_t mx53_smd_pads[] = {
 	/* I2C1 */
 	MX53_PAD_CSI0_DAT8__I2C1_SDA,
 	MX53_PAD_CSI0_DAT9__I2C1_SCL,
+	/* SD1 */
+	MX53_PAD_SD1_CMD__ESDHC1_CMD,
+	MX53_PAD_SD1_CLK__ESDHC1_CLK,
+	MX53_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX53_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX53_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX53_PAD_SD1_DATA3__ESDHC1_DAT3,
+	/* SD2 */
+	MX53_PAD_SD2_CMD__ESDHC2_CMD,
+	MX53_PAD_SD2_CLK__ESDHC2_CLK,
+	MX53_PAD_SD2_DATA0__ESDHC2_DAT0,
+	MX53_PAD_SD2_DATA1__ESDHC2_DAT1,
+	MX53_PAD_SD2_DATA2__ESDHC2_DAT2,
+	MX53_PAD_SD2_DATA3__ESDHC2_DAT3,
+	/* SD3 */
+	MX53_PAD_PATA_DATA8__ESDHC3_DAT0,
+	MX53_PAD_PATA_DATA9__ESDHC3_DAT1,
+	MX53_PAD_PATA_DATA10__ESDHC3_DAT2,
+	MX53_PAD_PATA_DATA11__ESDHC3_DAT3,
+	MX53_PAD_PATA_DATA0__ESDHC3_DAT4,
+	MX53_PAD_PATA_DATA1__ESDHC3_DAT5,
+	MX53_PAD_PATA_DATA2__ESDHC3_DAT6,
+	MX53_PAD_PATA_DATA3__ESDHC3_DAT7,
+	MX53_PAD_PATA_IORDY__ESDHC3_CLK,
+	MX53_PAD_PATA_RESET_B__ESDHC3_CMD,
 };
 
 static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
@@ -97,6 +122,9 @@ static void __init mx53_smd_board_init(void)
 	imx53_add_fec(&mx53_smd_fec_data);
 	imx53_add_imx2_wdt(0, NULL);
 	imx53_add_imx_i2c(0, &mx53_smd_i2c_data);
+	imx53_add_sdhci_esdhc_imx(0, NULL);
+	imx53_add_sdhci_esdhc_imx(1, NULL);
+	imx53_add_sdhci_esdhc_imx(2, NULL);
 }
 
 static void __init mx53_smd_timer_init(void)
-- 
1.6.0.4
