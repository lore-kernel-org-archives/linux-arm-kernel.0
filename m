From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sat,  2 Oct 2010 17:15:29 +0200
Subject: [PATCH 4/4] eukrea_mbimxsd for cpuimx25: add CAN & SDCard support
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286032529-26509-4-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/Kconfig                    |    2 ++
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index c71a7bc..60cc16e 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -12,6 +12,8 @@ config MACH_EUKREA_CPUIMX25
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_ESDHC
 	select MXC_ULPI if USB_ULPI
 
 choice
diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index 4aaadc7..f4c4c6f 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -90,6 +90,9 @@ static struct pad_desc eukrea_mbimxsd_pads[] = {
 	MX25_PAD_KPP_COL2__AUD5_TXC,
 	MX25_PAD_KPP_COL1__AUD5_RXD,
 	MX25_PAD_KPP_COL0__AUD5_TXD,
+	/* CAN */
+	MX25_PAD_GPIO_D__CAN2_RX,
+	MX25_PAD_GPIO_C__CAN2_TX,
 };
 
 #define GPIO_LED1	83
@@ -240,6 +243,8 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 	imx25_add_imx_uart1(&uart_pdata);
 	mxc_register_device(&mx25_fb_device, &eukrea_mximxsd_fb_pdata);
 	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
+	imx25_add_flexcan1(NULL);
+	imx25_add_esdhc0(NULL);
 
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
-- 
1.7.0.4
