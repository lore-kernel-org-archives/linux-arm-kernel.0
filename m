From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:22 +0900
Subject: [PATCH 25/27] ARM: S3C64XX: 2nd Change to using
	s3c_gpio_cfgrange_nopull()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-26-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes code setting special-function and no pull-up
to use the s3c_gpio_cfgrange_nopull() wrapper.
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c |    7 ++-----
 arch/arm/mach-s3c64xx/setup-keypad.c   |    6 ++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 3b0dd12..8f30911 100644
--- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
@@ -23,9 +23,6 @@
 
 extern void s3c64xx_fb_gpio_setup_24bpp(void)
 {
-	s3c_gpio_cfgall_range(S3C64XX_GPI(0), 16,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
-
-	s3c_gpio_cfgall_range(S3C64XX_GPJ(0), 12,
-			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPI(0), 16, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPJ(0), 12, S3C_GPIO_SFN(2));
 }
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
index cc9b09c..d1fd722 100644
--- a/arch/arm/mach-s3c64xx/setup-keypad.c
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -16,10 +16,8 @@
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
 	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x] */
-	s3c_gpio_cfgall_range(S3C64XX_GPK(8), 8 + rows,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPK(8), 8 + rows, S3C_GPIO_SFN(3));
 
 	/* Set all the necessary GPL pins to special-function 3: KP_COL[x] */
-	s3c_gpio_cfgall_range(S3C64XX_GPL(0), cols,
-			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
+	s3c_gpio_cfgrange_nopull(S3C64XX_GPL(0), cols, S3C_GPIO_SFN(3));
 }
-- 
1.6.2.5
