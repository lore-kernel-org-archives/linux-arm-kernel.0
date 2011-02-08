From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  8 Feb 2011 21:17:21 +0100
Subject: [PATCH] ARM: imx/eukrea_mbimx27: fix compile warnings about unused
	variables
Message-ID: <1297196241-26564-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 275c858..9ac5348 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -249,7 +249,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 
 #define ADS7846_PENDOWN (GPIO_PORTD | 25)
 
-static void ads7846_dev_init(void)
+static void __maybe_unused ads7846_dev_init(void)
 {
 	if (gpio_request(ADS7846_PENDOWN, "ADS7846 pendown") < 0) {
 		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
@@ -268,7 +268,8 @@ static struct ads7846_platform_data ads7846_config __initdata = {
 	.keep_vref_on		= 1,
 };
 
-static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
+static struct spi_board_info __maybe_unused
+eukrea_mbimx27_spi_board_info[] __initdata = {
 	[0] = {
 		.modalias	= "ads7846",
 		.bus_num	= 0,
-- 
1.7.2.3
