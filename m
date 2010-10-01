From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:20 +0900
Subject: [PATCH 23/27] ARM: S5PC100: Change to using s3c_gpio_cfgrange_nopull()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-24-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change code setting special-function and no pull-up to use
the s3c_gpio_cfgrange_nopull() wrapper.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index a8d22a7..03c02d0 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -33,12 +33,10 @@ void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 		num = width - 2;
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
-	s3c_gpio_cfgall_range(S5PC100_GPG0(0), 2 + num,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PC100_GPG0(0), 2 + num, S3C_GPIO_SFN(2));
 
 	if (width == 8)
-		s3c_gpio_cfgall_range(S5PC100_GPG1(0), 2,
-				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+		s3c_gpio_cfgrange_nopull(S5PC100_GPG1(0), 2, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
@@ -51,8 +49,7 @@ void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG2 pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PC100_GPG2(0), 2 + width,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PC100_GPG2(0), 2 + width, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
@@ -65,8 +62,7 @@ void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG3 pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PC100_GPG3(0), 2 + width,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PC100_GPG3(0), 2 + width, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
-- 
1.6.2.5
