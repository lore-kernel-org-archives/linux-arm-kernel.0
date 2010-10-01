From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:05 +0900
Subject: [PATCH 08/27] ARM: S5PV210: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-9-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[kgene.kim at samsung.com: coding-style fixes]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/dev-audio.c        |   46 ++++----------------------
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c |   53 ++++++++++++-----------------
 2 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index 21dc6cf..b274b6b 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -24,29 +24,15 @@ static int s5pv210_cfg_i2s(struct platform_device *pdev)
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
 	case 1:
-		s3c_gpio_cfgpin(S5PV210_GPC0(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC0(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC0(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC0(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC0(4), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PV210_GPC0(0), 5, S3C_GPIO_SFN(2));
 		break;
 
 	case 2:
-		s3c_gpio_cfgpin(S5PV210_GPC1(0), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PV210_GPC1(1), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PV210_GPC1(2), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PV210_GPC1(3), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PV210_GPC1(4), S3C_GPIO_SFN(4));
+		s3c_gpio_cfgpin_range(S5PV210_GPC1(0), 5, S3C_GPIO_SFN(4));
 		break;
 
 	case -1:
-		s3c_gpio_cfgpin(S5PV210_GPI(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPI(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPI(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPI(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPI(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPI(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPI(6), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PV210_GPI(0), 7, S3C_GPIO_SFN(2));
 		break;
 
 	default:
@@ -151,25 +137,13 @@ static int s5pv210_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5PV210_GPI(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPI(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPI(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPI(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPI(4), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(S5PV210_GPI(0), 5, S3C_GPIO_SFN(3));
 		break;
 	case 1:
-		s3c_gpio_cfgpin(S5PV210_GPC0(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPC0(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPC0(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPC0(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PV210_GPC0(4), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(S5PV210_GPC0(0), 5, S3C_GPIO_SFN(3));
 		break;
 	case 2:
-		s3c_gpio_cfgpin(S5PV210_GPC1(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC1(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC1(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC1(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PV210_GPC1(4), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PV210_GPC1(0), 5, S3C_GPIO_SFN(2));
 		break;
 	default:
 		printk(KERN_DEBUG "Invalid PCM Controller number!");
@@ -271,13 +245,7 @@ struct platform_device s5pv210_device_pcm2 = {
 
 static int s5pv210_ac97_cfg_gpio(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S5PV210_GPC0(0), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PV210_GPC0(1), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PV210_GPC0(2), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PV210_GPC0(3), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PV210_GPC0(4), S3C_GPIO_SFN(4));
-
-	return 0;
+	return s3c_gpio_cfgpin_range(S5PV210_GPC0(0), 5, S3C_GPIO_SFN(4));
 }
 
 static struct resource s5pv210_ac97_resource[] = {
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index b18587b..7064278 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -29,23 +29,21 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int gpio;
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
-	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PV210_GPG0(0), 2, S3C_GPIO_SFN(2));
+	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+
 	switch (width) {
 	case 8:
 		/* GPG1[3:6] special-funtion 3 */
-		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(3));
+		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++)
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
 	case 4:
 		/* GPG0[3:6] special-funtion 2 */
-		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PV210_GPG0(3), 4, S3C_GPIO_SFN(2));
+		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++)
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
 	default:
 		break;
 	}
@@ -62,16 +60,14 @@ void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int gpio;
 
 	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
-	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PV210_GPG1(0), 2, S3C_GPIO_SFN(2));
+	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	/* Data pin GPG1[3:6] to special-function 2 */
-	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(2));
+	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
@@ -85,24 +81,21 @@ void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int gpio;
 
 	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
-	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PV210_GPG2(0), 2, S3C_GPIO_SFN(2));
+	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	switch (width) {
 	case 8:
 		/* Data pin GPG3[3:6] to special-function 3 */
-		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(S5PV210_GPG3(3), 4, S3C_GPIO_SFN(3));
+		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++)
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
 	case 4:
 		/* Data pin GPG2[3:6] to special-function 2 */
-		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PV210_GPG2(3), 4, S3C_GPIO_SFN(2));
+		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++)
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
 	default:
 		break;
 	}
@@ -118,17 +111,15 @@ void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 	unsigned int gpio;
 
-	/* Set all the necessary GPG3[0:2] pins to special-function 2 */
-	for (gpio = S5PV210_GPG3(0); gpio < S5PV210_GPG3(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	/* Set all the necessary GPG3[0:1] pins to special-function 2 */
+	s3c_gpio_cfgpin_range(S5PV210_GPG3(0), 2, S3C_GPIO_SFN(2));
+	for (gpio = S5PV210_GPG3(0); gpio < S5PV210_GPG3(2); gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	/* Data pin GPG3[3:6] to special-function 2 */
-	for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PV210_GPG3(3), 4, S3C_GPIO_SFN(2));
+	for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PV210_GPG3(2), S3C_GPIO_PULL_UP);
-- 
1.6.2.5
