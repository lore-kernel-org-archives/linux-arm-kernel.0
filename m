From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 18:29:25 +0200
Subject: [PATCH V2 6/6] pcm043: register flexcan device
In-Reply-To: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
References: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279816165-6542-7-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig       |    1 +
 arch/arm/mach-mx3/mach-pcm043.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index e063657..03563eb 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -119,6 +119,7 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_FLEXCAN
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm043 platform. This includes
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index b92f624..47f5311 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -214,6 +214,9 @@ static struct pad_desc pcm043_pads[] = {
 	MX35_PAD_STXD4__AUDMUX_AUD4_TXD,
 	MX35_PAD_SRXD4__AUDMUX_AUD4_RXD,
 	MX35_PAD_SCK4__AUDMUX_AUD4_TXC,
+	/* CAN2 */
+	MX35_PAD_TX5_RX0__CAN2_TXCAN,
+	MX35_PAD_TX4_RX1__CAN2_RXCAN,
 };
 
 #define AC97_GPIO_TXFS	(1 * 32 + 31)
@@ -385,6 +388,7 @@ static void __init mxc_board_init(void)
 	if (!otg_mode_host)
 		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
 
+	imx35_add_flexcan1(NULL);
 }
 
 static void __init pcm043_timer_init(void)
-- 
1.7.1
