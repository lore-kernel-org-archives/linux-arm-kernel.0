From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:21 +0900
Subject: [PATCH 24/27] ARM: S5PV210: Change to using s3c_gpio_cfgrange_nopull()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-25-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change code setting special-function and no pull-up to use
the s3c_gpio_cfgrange_nopull() wrapper.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index f5499ae..927d588 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -34,12 +34,10 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	switch (width) {
 	case 8:
 		/* GPG1[3:6] special-funtion 3 */
-		s3c_gpio_cfgall_range(S5PV210_GPG1(3), 4,
-				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+		s3c_gpio_cfgrange_nopull(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(3));
 	case 4:
 		/* GPG0[3:6] special-funtion 2 */
-		s3c_gpio_cfgall_range(S5PV210_GPG0(3), 4,
-				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+		s3c_gpio_cfgrange_nopull(S5PV210_GPG0(3), 4, S3C_GPIO_SFN(2));
 	default:
 		break;
 	}
@@ -55,12 +53,10 @@ void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG1(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG1(0), 2, S3C_GPIO_SFN(2));
 
 	/* Data pin GPG1[3:6] to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG1(3), 4,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
@@ -73,18 +69,15 @@ void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG2(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG2(0), 2, S3C_GPIO_SFN(2));
 
 	switch (width) {
 	case 8:
 		/* Data pin GPG3[3:6] to special-function 3 */
-		s3c_gpio_cfgall_range(S5PV210_GPG3(3), 4,
-				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+		s3c_gpio_cfgrange_nopull(S5PV210_GPG3(3), 4, S3C_GPIO_SFN(3));
 	case 4:
 		/* Data pin GPG2[3:6] to special-function 2 */
-		s3c_gpio_cfgall_range(S5PV210_GPG2(3), 4,
-				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+		s3c_gpio_cfgrange_nopull(S5PV210_GPG2(3), 4, S3C_GPIO_SFN(2));
 	default:
 		break;
 	}
-- 
1.6.2.5
