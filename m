From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 16:59:46 -0300
Subject: [PATCH 3/5] ARM: mx27_3ds: Add I2C support
In-Reply-To: <1299009588-8783-2-git-send-email-fabio.estevam@freescale.com>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
	<1299009588-8783-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1299009588-8783-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c172418..01c6c72 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -238,6 +238,7 @@ config MACH_MX27_3DS
 	select SOC_IMX27
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index ba88417..f4f2725 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -98,6 +98,9 @@ static const int mx27pdk_pins[] __initconst = {
 	PD22_PF_CSPI2_SCLK,
 	PD23_PF_CSPI2_MISO,
 	PD24_PF_CSPI2_MOSI,
+	/* I2C1 */
+	PD17_PF_I2C_DATA,
+	PD18_PF_I2C_CLK,
 };
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -257,6 +260,9 @@ static struct spi_board_info mx27_3ds_spi_devs[] __initdata = {
 	},
 };
 
+static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
+	.bitrate = 100000,
+};
 
 static void __init mx27pdk_init(void)
 {
@@ -286,6 +292,7 @@ static void __init mx27pdk_init(void)
 
 	if (mxc_expio_init(MX27_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
+	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.6.0.4
