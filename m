From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Sat,  2 Oct 2010 17:15:27 +0200
Subject: [PATCH 2/4] eukrea_mbimxsd for cpuimx35: add CAN & SDCard support
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286032529-26509-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx3/Kconfig                    |    2 ++
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |   13 +++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 2f4d6cb..2c08dfd 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -160,6 +160,8 @@ config MACH_EUKREA_CPUIMX35
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
+	select IMX_HAVE_PLATFORM_FLEXCAN
+	select IMX_HAVE_PLATFORM_ESDHC
 	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Eukrea CPUIMX35 platform. This includes
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index f8f15e3..0d219bb 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -120,6 +120,16 @@ static struct pad_desc eukrea_mbimxsd_pads[] = {
 	MX35_PAD_STXD4__AUDMUX_AUD4_TXD,
 	MX35_PAD_SRXD4__AUDMUX_AUD4_RXD,
 	MX35_PAD_SCK4__AUDMUX_AUD4_TXC,
+	/* CAN2 */
+	MX35_PAD_TX5_RX0__CAN2_TXCAN,
+	MX35_PAD_TX4_RX1__CAN2_RXCAN,
+	/* SDCARD */
+	MX35_PAD_SD1_CMD__ESDHC1_CMD,
+	MX35_PAD_SD1_CLK__ESDHC1_CLK,
+	MX35_PAD_SD1_DATA0__ESDHC1_DAT0,
+	MX35_PAD_SD1_DATA1__ESDHC1_DAT1,
+	MX35_PAD_SD1_DATA2__ESDHC1_DAT2,
+	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
 };
 
 #define GPIO_LED1	(2 * 32 + 29)
@@ -244,6 +254,9 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 
 	mxc_register_device(&imx_ssi_device0, &eukrea_mbimxsd_ssi_pdata);
 
+	imx35_add_flexcan1(NULL);
+	imx35_add_esdhc0(NULL);
+
 	gpio_request(GPIO_LED1, "LED1");
 	gpio_direction_output(GPIO_LED1, 1);
 	gpio_free(GPIO_LED1);
-- 
1.7.0.4
