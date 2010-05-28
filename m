From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:52 +0100
Subject: [PATCH 15/15] ARM: S5PV210: Change to using s3c_gpio_cfgrange_nopull()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-16-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chane code setting special-function and no pull-up to use
the s3c_gpio_cfgrange_nopull() wrapper.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index 38189d1..2307d52 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -31,12 +31,10 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
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
@@ -48,12 +46,10 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
 	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG1(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG1(0), 2, S3C_GPIO_SFN(2));
 
 	/* Data pin GPG1[3:6] to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG1(3), 4,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(2));
 
 	s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
@@ -62,18 +58,15 @@ void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
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
1.6.3.3
