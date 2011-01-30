From: richard.zhao@freescale.com (Richard Zhao)
Date: Sun, 30 Jan 2011 17:26:17 +0800
Subject: [PATCH 1/1] ARM: imx53_loco: add i2c device support
Message-ID: <1296379577-28474-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
It can i2cdetect sgtl5000 device.

 arch/arm/mach-mx5/Kconfig           |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 10b6008..abea297 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -146,6 +146,7 @@ config MACH_MX53_LOCO
 	bool "Support MX53 LOCO platforms"
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_IMX_I2C
 	help
 	  Include support for MX53 LOCO platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index d724ac8..46da468 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -199,6 +199,10 @@ static struct fec_platform_data mx53_loco_fec_data = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
+	.bitrate = 100000,
+};
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -206,6 +210,8 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_imx_uart(0, NULL);
 	mx53_loco_fec_reset();
 	imx53_add_fec(&mx53_loco_fec_data);
+	imx53_add_imx_i2c(0, &mx53_loco_i2c_data);
+	imx53_add_imx_i2c(1, &mx53_loco_i2c_data);
 }
 
 static void __init mx53_loco_timer_init(void)
-- 
1.6.3.3
