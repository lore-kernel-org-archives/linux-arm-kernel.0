From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:44 +0100
Subject: [PATCH 07/15] ARM: S5PV210: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-8-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pv210/dev-audio.c        |   46 ++++-------------------------
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c |   16 +++++-----
 2 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index 6e21533..5c67829 100644
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
index fe7d86d..147abd0 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -27,21 +27,21 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int gpio;
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
+	s3c_gpio_cfgpin_range(S5PV210_GPG0(0), 2, S3C_GPIO_SFN(2));
 	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 	switch (width) {
 	case 8:
 		/* GPG1[3:6] special-funtion 3 */
+		s3c_gpio_cfgpin_range(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(3));
 		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		}
 	case 4:
 		/* GPG0[3:6] special-funtion 2 */
+		s3c_gpio_cfgpin_range(S5PV210_GPG0(3), 4, S3C_GPIO_SFN(2));
 		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		}
 	default:
@@ -57,14 +57,14 @@ void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int gpio;
 
 	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
+	s3c_gpio_cfgpin_range(S5PV210_GPG1(0), 2, S3C_GPIO_SFN(2));
 	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
 	/* Data pin GPG1[3:6] to special-function 2 */
+	s3c_gpio_cfgpin(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(2));
 	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
@@ -77,22 +77,22 @@ void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int gpio;
 
 	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
+	s3c_gpio_cfgpin_range(S5PV210_GPG2(0), 2, S3C_GPIO_SFN(2));
 	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
 	switch (width) {
 	case 8:
 		/* Data pin GPG3[3:6] to special-function 3 */
+		s3c_gpio_cfgpin_range(S5PV210_GPG3(3), 4, S3C_GPIO_SFN(3));
 		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		}
 	case 4:
 		/* Data pin GPG2[3:6] to special-function 2 */
+		s3c_gpio_cfgpin_range(S5PV210_GPG2(3), 4, S3C_GPIO_SFN(2));
 		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 		}
 	default:
-- 
1.6.3.3
