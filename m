From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:15 +0900
Subject: [PATCH 18/27] ARM: S5P64X0: 2nd Change to using
	s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-19-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the code setting range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgpin_range().
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/setup-i2c1.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/setup-i2c1.c b/arch/arm/mach-s5p64x0/setup-i2c1.c
index 5d5dd3c..6ad3b98 100644
--- a/arch/arm/mach-s5p64x0/setup-i2c1.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c1.c
@@ -25,16 +25,14 @@ struct platform_device; /* don't need the contents */
 
 void s5p6440_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin_range(S5P6440_GPR(9), 2, S3C_GPIO_SFN(6));
-	s3c_gpio_setpull(S5P6440_GPR(9), S3C_GPIO_PULL_UP);
-	s3c_gpio_setpull(S5P6440_GPR(10), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5P6440_GPR(9), 2,
+			      S3C_GPIO_SFN(6), S3C_GPIO_PULL_UP);
 }
 
 void s5p6450_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin_range(S5P6450_GPR(9), 2, S3C_GPIO_SFN(6));
-	s3c_gpio_setpull(S5P6450_GPR(9), S3C_GPIO_PULL_UP);
-	s3c_gpio_setpull(S5P6450_GPR(10), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5P6450_GPR(9), 2,
+			      S3C_GPIO_SFN(6), S3C_GPIO_PULL_UP);
 }
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev) { }
-- 
1.6.2.5
