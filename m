From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Feb 2011 11:07:27 +0100
Subject: [PATCH] ARM: imx/eukrea_mbimx27: fix compile warnings about unused
	variables
In-Reply-To: <4D52F566.1070009@ru.mvista.com>
References: <4D52F566.1070009@ru.mvista.com>
Message-ID: <1297332447-23532-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

On Wed, Feb 09, 2011 at 11:13:26PM +0300, Sergei Shtylyov wrote:
> >>>-static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
> >>>+static struct spi_board_info __maybe_unused
> >>>+eukrea_mbimx27_spi_board_info[] __initdata = {
>
> >>   I think the second line should be somewhat indented.
> 
> >I like it as it is.  There are no rules for that, no?
> 
>    Documentation/CodingStyle, chapter 2.
hmm, this is how vim indents and checkpatch doesn't diagnose a style problem.
Though I prefer it unindented, too, I don't care enough.  So here's a patch
with the 2nd line having 2 tabs.  Up to Sascha which to include ...

Best regards and thanks,
Uwe

 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 275c858..d12815d 100644
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
+		eukrea_mbimx27_spi_board_info[] __initdata = {
 	[0] = {
 		.modalias	= "ads7846",
 		.bus_num	= 0,
-- 
1.7.2.3
