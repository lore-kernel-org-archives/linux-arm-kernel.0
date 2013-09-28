From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 28 Sep 2013 20:21:34 +0200
Subject: [PATCH 2/5] gpio: samsung: Use CONFIG_ARCH_S3C64XX to check for
 S3C64xx support
In-Reply-To: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
References: <1380392497-27406-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1380392497-27406-2-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since CONFIG_PLAT_S3C64XX is going to be removed, this patch modifies
the gpio-samsung driver to use the proper way of checking for S3C64xx
support - CONFIG_ARCH_S3C64XX.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/gpio/gpio-samsung.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 29b5d67..76e02b9 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -1033,7 +1033,7 @@ static int s3c24xx_gpiolib_fbank_to_irq(struct gpio_chip *chip, unsigned offset)
 }
 #endif
 
-#ifdef CONFIG_PLAT_S3C64XX
+#ifdef CONFIG_ARCH_S3C64XX
 static int s3c64xx_gpiolib_mbank_to_irq(struct gpio_chip *chip, unsigned pin)
 {
 	return pin < 5 ? IRQ_EINT(23) + pin : -ENXIO;
@@ -1174,7 +1174,7 @@ struct samsung_gpio_chip s3c24xx_gpios[] = {
  */
 
 static struct samsung_gpio_chip s3c64xx_gpios_4bit[] = {
-#ifdef CONFIG_PLAT_S3C64XX
+#ifdef CONFIG_ARCH_S3C64XX
 	{
 		.chip	= {
 			.base	= S3C64XX_GPA(0),
@@ -1227,7 +1227,7 @@ static struct samsung_gpio_chip s3c64xx_gpios_4bit[] = {
 };
 
 static struct samsung_gpio_chip s3c64xx_gpios_4bit2[] = {
-#ifdef CONFIG_PLAT_S3C64XX
+#ifdef CONFIG_ARCH_S3C64XX
 	{
 		.base	= S3C64XX_GPH_BASE + 0x4,
 		.chip	= {
@@ -1257,7 +1257,7 @@ static struct samsung_gpio_chip s3c64xx_gpios_4bit2[] = {
 };
 
 static struct samsung_gpio_chip s3c64xx_gpios_2bit[] = {
-#ifdef CONFIG_PLAT_S3C64XX
+#ifdef CONFIG_ARCH_S3C64XX
 	{
 		.base	= S3C64XX_GPF_BASE,
 		.config	= &samsung_gpio_cfgs[6],
-- 
1.8.3.2
