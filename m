From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 14 Oct 2015 11:27:46 +0200
Subject: [PATCH] arm: pxa: raumfeld: make some variables static
Message-ID: <1444814866-4639-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following sparse warnings:

	arch/arm/mach-pxa/raumfeld.c:510:24: warning: symbol 'raumfeld_w1_gpio_device' was not declared. Should it be static?
	arch/arm/mach-pxa/raumfeld.c:632:31: warning: symbol 'raumfeld_spi_platform_data' was not declared. Should it be static?
	arch/arm/mach-pxa/raumfeld.c:851:28: warning: symbol 'audio_va_initdata' was not declared. Should it be static?
	arch/arm/mach-pxa/raumfeld.c:883:28: warning: symbol 'audio_dummy_initdata' was not declared. Should it be static?
	arch/arm/mach-pxa/raumfeld.c:931:28: warning: symbol 'max8660_v6_subdev_data' was not declared. Should it be static?

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-pxa/raumfeld.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 88f70c37ad0d..32ee6ef5ea4f 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -507,7 +507,7 @@ static struct w1_gpio_platform_data w1_gpio_platform_data = {
 	.ext_pullup_enable_pin	= -EINVAL,
 };
 
-struct platform_device raumfeld_w1_gpio_device = {
+static struct platform_device raumfeld_w1_gpio_device = {
 	.name	= "w1-gpio",
 	.dev	= {
 		.platform_data = &w1_gpio_platform_data
@@ -629,7 +629,7 @@ static void __init raumfeld_lcd_init(void)
  * SPI devices
  */
 
-struct spi_gpio_platform_data raumfeld_spi_platform_data = {
+static struct spi_gpio_platform_data raumfeld_spi_platform_data = {
 	.sck		= GPIO_SPI_CLK,
 	.mosi		= GPIO_SPI_MOSI,
 	.miso		= GPIO_SPI_MISO,
@@ -848,7 +848,7 @@ static void __init raumfeld_power_init(void)
 static struct regulator_consumer_supply audio_va_consumer_supply =
 	REGULATOR_SUPPLY("va", "0-0048");
 
-struct regulator_init_data audio_va_initdata = {
+static struct regulator_init_data audio_va_initdata = {
 	.consumer_supplies = &audio_va_consumer_supply,
 	.num_consumer_supplies = 1,
 	.constraints = {
@@ -880,7 +880,7 @@ static struct regulator_consumer_supply audio_dummy_supplies[] = {
 	REGULATOR_SUPPLY("vlc", "0-0048"),
 };
 
-struct regulator_init_data audio_dummy_initdata = {
+static struct regulator_init_data audio_dummy_initdata = {
 	.consumer_supplies = audio_dummy_supplies,
 	.num_consumer_supplies = ARRAY_SIZE(audio_dummy_supplies),
 	.constraints = {
@@ -928,7 +928,7 @@ static struct regulator_init_data vcc_mmc_init_data = {
 	.num_consumer_supplies = 1,
 };
 
-struct max8660_subdev_data max8660_v6_subdev_data = {
+static struct max8660_subdev_data max8660_v6_subdev_data = {
 	.id		= MAX8660_V6,
 	.name		= "vmmc",
 	.platform_data	= &vcc_mmc_init_data,
-- 
2.6.1
