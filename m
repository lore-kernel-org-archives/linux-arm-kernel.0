From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:19 +0900
Subject: [PATCH 22/27] ARM: S3C64XX: Change to using s3c_gpio_cfgrange_nopull()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-23-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change code setting special-function and no pull-up to use
the s3c_gpio_cfgrange_nopull() wrapper.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index 4262f78..6eac071 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -26,8 +26,7 @@ void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG pins to special-function 2 */
-	s3c_gpio_cfgall_range(S3C64XX_GPG(0), 2 + width,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPG(0), 2 + width, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
@@ -40,8 +39,7 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPH pins to special-function 2 */
-	s3c_gpio_cfgall_range(S3C64XX_GPH(0), 2 + width,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPH(0), 2 + width, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
@@ -52,10 +50,8 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
 	/* Set all the necessary GPH pins to special-function 3 */
-	s3c_gpio_cfgall_range(S3C64XX_GPH(6), width,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPH(6), width, S3C_GPIO_SFN(3));
 
 	/* Set all the necessary GPC pins to special-function 3 */
-	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 2,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPC(4), 2, S3C_GPIO_SFN(3));
 }
-- 
1.6.2.5
