From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 25 Feb 2011 10:00:30 +0100
Subject: [PATCH] ARM: mxs: Initial support for Ka-Ro TX28
In-Reply-To: <1298581480-15585-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110224210353.GA22310@pengutronix.de>
	<1298581480-15585-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110225090030.GB22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

as requested by Sascha I squashed the following patch in:

diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index 540d6ea..b609b84 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -130,7 +130,6 @@ static const struct gpio_led_platform_data tx28_stk5v3_led_data __initconst = {
 };
 
 static struct spi_board_info tx28_spi_board_info[] = {
-#if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
 	{
 		.modalias = "spidev",
 		.max_speed_hz = 20000000,
@@ -139,7 +138,6 @@ static struct spi_board_info tx28_spi_board_info[] = {
 		.controller_data = (void *)SPI_GPIO_NO_CHIPSELECT,
 		.mode = SPI_MODE_0,
 	},
-#endif
 };
 
 static void __init tx28_stk5v3_init(void)

The branch in my public repository is updated.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
