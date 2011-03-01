From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 16:59:44 -0300
Subject: [PATCH 1/5] ARM: mx35_3ds: Add I2C support
Message-ID: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx35_3ds.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 4f57f13..8b4b097 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -183,6 +183,7 @@ config MACH_MX35_3DS
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index be12ac1..5f35d5c 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -118,6 +118,9 @@ static iomux_v3_cfg_t mx35pdk_pads[] = {
 	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
 	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
 	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
+	/* I2C1 */
+	MX35_PAD_I2C1_CLK__I2C1_SCL,
+	MX35_PAD_I2C1_DAT__I2C1_SDA,
 };
 
 static int mx35_3ds_otg_init(struct platform_device *pdev)
@@ -163,6 +166,10 @@ static int __init mx35_3ds_otg_mode(char *options)
 }
 __setup("otg_mode=", mx35_3ds_otg_mode);
 
+static const struct imxi2c_platform_data mx35_3ds_i2c0_data __initconst = {
+	.bitrate = 100000,
+};
+
 /*
  * Board specific initialization.
  */
@@ -190,6 +197,7 @@ static void __init mx35_3ds_init(void)
 	if (mxc_expio_init(MX35_CS5_BASE_ADDR, EXPIO_PARENT_INT))
 		pr_warn("Init of the debugboard failed, all "
 				"devices on the debugboard are unusable.\n");
+	imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
 }
 
 static void __init mx35pdk_timer_init(void)
-- 
1.6.0.4
