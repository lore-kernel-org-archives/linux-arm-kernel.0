From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 12:55:23 +0200
Subject: [PATCH 3/3] arm: pcm043: add esdhc-device to boardconfig
In-Reply-To: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
References: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286794523-26607-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig       |    1 +
 arch/arm/mach-mx3/mach-pcm043.c |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index c3e0882..096fd33 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -123,6 +123,7 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_ESDHC
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm043 platform. This includes
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index 0ab4d0b..e790a00 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -215,6 +215,13 @@ static struct pad_desc pcm043_pads[] = {
 	/* CAN2 */
 	MX35_PAD_TX5_RX0__CAN2_TXCAN,
 	MX35_PAD_TX4_RX1__CAN2_RXCAN,
+	/* esdhc */
+	MX35_PAD_SD1_CMD__ESDHC1_CMD,
+	MX35_PAD_SD1_CLK__ESDHC1_CLK,
+	MX35_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
 };
 
 #define AC97_GPIO_TXFS	(1 * 32 + 31)
@@ -388,6 +395,7 @@ static void __init mxc_board_init(void)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 
 	imx35_add_flexcan1(NULL);
+	imx35_add_esdhc0(NULL);
 }
 
 static void __init pcm043_timer_init(void)
-- 
1.7.1
