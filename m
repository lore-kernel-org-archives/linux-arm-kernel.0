From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:23 +0900
Subject: [PATCH 26/27] ARM: S5PC100: 2nd Change to using
	s3c_gpio_cfgrange_nopull()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-27-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes code setting special-function and no pull-up
to use the s3c_gpio_cfgrange_nopull() wrapper.
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/setup-fb-24bpp.c |    2 +-
 arch/arm/mach-s5pc100/setup-ide.c      |    5 ++---
 arch/arm/mach-s5pc100/setup-keypad.c   |    6 ++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s5pc100/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
index 5a882d4..d31c0f3 100644
--- a/arch/arm/mach-s5pc100/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
@@ -24,7 +24,7 @@
 
 static void s5pc100_fb_setgpios(unsigned int base, unsigned int nr)
 {
-	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(base, nr, S3C_GPIO_SFN(2));
 }
 
 void s5pc100_fb_gpio_setup_24bpp(void)
diff --git a/arch/arm/mach-s5pc100/setup-ide.c b/arch/arm/mach-s5pc100/setup-ide.c
index d8b0d0e..223aae0 100644
--- a/arch/arm/mach-s5pc100/setup-ide.c
+++ b/arch/arm/mach-s5pc100/setup-ide.c
@@ -19,7 +19,7 @@
 
 static void s5pc100_ide_cfg_gpios(unsigned int base, unsigned int nr)
 {
-	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(4), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(base, nr, S3C_GPIO_SFN(4));
 
 	for (; nr > 0; nr--, base++)
 		s5p_gpio_set_drvstr(base, S5P_GPIO_DRVSTR_LV4);
@@ -49,8 +49,7 @@ void s5pc100_ide_setup_gpio(void)
 	s3c_gpio_cfgpin_range(S5PC100_GPK0(6), 2, S3C_GPIO_SFN(0));
 
 	/* CF_OE, CF_WE */
-	s3c_gpio_cfgall_range(S5PC100_GPK1(6), 8,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PC100_GPK1(6), 8, S3C_GPIO_SFN(2));
 
 	/* CF_CD */
 	s3c_gpio_cfgpin(S5PC100_GPK3(5), S3C_GPIO_SFN(2));
diff --git a/arch/arm/mach-s5pc100/setup-keypad.c b/arch/arm/mach-s5pc100/setup-keypad.c
index 966b49f..ada377f 100644
--- a/arch/arm/mach-s5pc100/setup-keypad.c
+++ b/arch/arm/mach-s5pc100/setup-keypad.c
@@ -16,10 +16,8 @@
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
 	/* Set all the necessary GPH3 pins to special-function 3: KP_ROW[x] */
-	s3c_gpio_cfgall_range(S5PC100_GPH3(0), rows,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PC100_GPH3(0), rows, S3C_GPIO_SFN(3));
 
 	/* Set all the necessary GPH2 pins to special-function 3: KP_COL[x] */
-	s3c_gpio_cfgall_range(S5PC100_GPH2(0), cols,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S5PC100_GPH2(0), cols, S3C_GPIO_SFN(3));
 }
-- 
1.6.2.5
