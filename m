From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 1 Mar 2011 16:59:45 -0300
Subject: [PATCH 2/5] ARM: mx31_3ds: Add I2C support
In-Reply-To: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
References: <1299009588-8783-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1299009588-8783-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx3/Kconfig         |    1 +
 arch/arm/mach-mx3/mach-mx31_3ds.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 8b4b097..340809a 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -94,6 +94,7 @@ config MACH_MX31_3DS
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index b7d0953..35fdb2a 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -96,6 +96,9 @@ static int mx31_3ds_pins[] = {
 	IOMUX_MODE(MX31_PIN_PC_RW_B, IOMUX_CONFIG_ALT1),
 	/* USB Host2 reset */
 	IOMUX_MODE(MX31_PIN_USB_BYP, IOMUX_CONFIG_GPIO),
+	/* I2C1 */
+	MX31_PIN_I2C_CLK__I2C1_SCL,
+	MX31_PIN_I2C_DAT__I2C1_SDA,
 };
 
 /*
@@ -323,6 +326,10 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
+static const struct imxi2c_platform_data mx31_3ds_i2c0_data __initconst = {
+	.bitrate = 100000,
+};
+
 static void __init mx31_3ds_init(void)
 {
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
@@ -356,6 +363,7 @@ static void __init mx31_3ds_init(void)
 		printk(KERN_WARNING "Init of the debug board failed, all "
 				    "devices on the debug board are unusable.\n");
 	imx31_add_imx2_wdt(NULL);
+	imx31_add_imx_i2c0(&mx31_3ds_i2c0_data);
 }
 
 static void __init mx31_3ds_timer_init(void)
-- 
1.6.0.4
