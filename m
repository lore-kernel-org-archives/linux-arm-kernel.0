From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:24 +0900
Subject: [PATCH 27/27] ARM: S5PV210: 2nd Change to using
	s3c_gpio_cfgrange_nopull()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-28-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes code setting special-function and no pull-up
to use the s3c_gpio_cfgrange_nopull() wrapper.
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/setup-fb-24bpp.c   |    2 +-
 arch/arm/mach-s5pv210/setup-ide.c        |    2 +-
 arch/arm/mach-s5pv210/setup-keypad.c     |    6 ++----
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c |    9 +++------
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-s5pv210/setup-fb-24bpp.c b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
index a33fe96..e932ebf 100644
--- a/arch/arm/mach-s5pv210/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
@@ -23,7 +23,7 @@
 
 static void s5pv210_fb_cfg_gpios(unsigned int base, unsigned int nr)
 {
-	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(base, nr, S3C_GPIO_SFN(2));
 
 	for (; nr > 0; nr--, base++)
 		s5p_gpio_set_drvstr(base, S5P_GPIO_DRVSTR_LV4);
diff --git a/arch/arm/mach-s5pv210/setup-ide.c b/arch/arm/mach-s5pv210/setup-ide.c
index d7cd10f..ea123d5 100644
--- a/arch/arm/mach-s5pv210/setup-ide.c
+++ b/arch/arm/mach-s5pv210/setup-ide.c
@@ -17,7 +17,7 @@
 
 static void s5pv210_ide_cfg_gpios(unsigned int base, unsigned int nr)
 {
-	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(4), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(base, nr, S3C_GPIO_SFN(4));
 
 	for (; nr > 0; nr--, base++)
 		s5p_gpio_set_drvstr(base, S5P_GPIO_DRVSTR_LV4);
diff --git a/arch/arm/mach-s5pv210/setup-keypad.c b/arch/arm/mach-s5pv210/setup-keypad.c
index cb3f409..c56420a 100644
--- a/arch/arm/mach-s5pv210/setup-keypad.c
+++ b/arch/arm/mach-s5pv210/setup-keypad.c
@@ -17,10 +17,8 @@
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
 	/* Set all the necessary GPH3 pins to special-function 3: KP_ROW[x] */
-	s3c_gpio_cfgall_range(S5PV210_GPH3(0), rows,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPH3(0), rows, S3C_GPIO_SFN(3));
 
 	/* Set all the necessary GPH2 pins to special-function 3: KP_COL[x] */
-	s3c_gpio_cfgall_range(S5PV210_GPH2(0), cols,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPH2(0), cols, S3C_GPIO_SFN(3));
 }
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index 927d588..746777d 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -28,8 +28,7 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG0(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG0(0), 2, S3C_GPIO_SFN(2));
 
 	switch (width) {
 	case 8:
@@ -93,12 +92,10 @@ void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *dev, int width)
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
 
 	/* Set all the necessary GPG3[0:1] pins to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG3(0), 2,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG3(0), 2, S3C_GPIO_SFN(2));
 
 	/* Data pin GPG3[3:6] to special-function 2 */
-	s3c_gpio_cfgall_range(S5PV210_GPG3(3), 4,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PV210_GPG3(3), 4, S3C_GPIO_SFN(2));
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PV210_GPG3(2), S3C_GPIO_PULL_UP);
-- 
1.6.2.5
