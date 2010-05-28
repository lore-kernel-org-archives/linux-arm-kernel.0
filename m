From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:50 +0100
Subject: [PATCH 13/15] ARM: S3C64XX: Change to using s3c_gpio_cfgrange_nopull()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-14-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chane code setting special-function and no pull-up to use
the s3c_gpio_cfgrange_nopull() wrapper.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index 45640ef..9c2b118 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -23,8 +23,7 @@
 void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
 	/* Set all the necessary GPG pins to special-function 0 */
-	s3c_gpio_cfgall_range(S3C64XX_GPG(0), 2 + width,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPG(0), 2 + width, S3C_GPIO_SFN(2));
 
 	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(2));
@@ -33,8 +32,7 @@ void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
 	/* Set all the necessary GPG pins to special-function 0 */
-	s3c_gpio_cfgall_range(S3C64XX_GPH(0), 2 + width,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPH(0), 2 + width, S3C_GPIO_SFN(2));
 
 	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(3));
@@ -43,10 +41,8 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
 	/* Set all the necessary GPH pins to special-function 1 */
-	s3c_gpio_cfgall_range(S3C64XX_GPH(6), width,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPH(6), width, S3C_GPIO_SFN(3));
 
 	/* Set all the necessary GPC pins to special-function 1 */
-	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPC(4), 2, S3C_GPIO_SFN(3));
 }
-- 
1.6.3.3
