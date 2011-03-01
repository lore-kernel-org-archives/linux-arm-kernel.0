From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 16:59:47 -0300
Subject: [PATCH 4/5] ARM: mx25_3ds: Add I2C support
In-Reply-To: <1299009588-8783-3-git-send-email-fabio.estevam@freescale.com>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
	<1299009588-8783-2-git-send-email-fabio.estevam@freescale.com>
	<1299009588-8783-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1299009588-8783-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx25_3ds.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 01c6c72..e3f62b5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -100,6 +100,7 @@ config MACH_MX25_3DS
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 561f07f..da00b3c 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -106,6 +106,9 @@ static iomux_v3_cfg_t mx25pdk_pads[] = {
 	MX25_PAD_SD1_DATA3__SD1_DATA3,
 	MX25_PAD_A14__GPIO_2_0, /* WriteProtect */
 	MX25_PAD_A15__GPIO_2_1, /* CardDetect */
+	/* I2C1 */
+	MX25_PAD_I2C1_CLK__I2C1_CLK,
+	MX25_PAD_I2C1_DAT__I2C1_DAT,
 };
 
 static const struct fec_platform_data mx25_fec_pdata __initconst = {
@@ -211,6 +214,10 @@ static const struct esdhc_platform_data mx25pdk_esdhc_pdata __initconst = {
 	.cd_gpio = SD1_GPIO_CD,
 };
 
+static const struct imxi2c_platform_data mx25_3ds_i2c0_data __initconst = {
+	.bitrate = 100000,
+};
+
 static void __init mx25pdk_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
@@ -229,6 +236,7 @@ static void __init mx25pdk_init(void)
 	imx25_add_imx_keypad(&mx25pdk_keymap_data);
 
 	imx25_add_sdhci_esdhc_imx(0, &mx25pdk_esdhc_pdata);
+	imx25_add_imx_i2c0(&mx25_3ds_i2c0_data);
 }
 
 static void __init mx25pdk_timer_init(void)
-- 
1.6.0.4
