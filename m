From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:02 +0900
Subject: [PATCH 05/27] ARM: S5P64X0: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[kgene.kim at samsung.com: modified to s5p64x0 from s5p6440]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/dev-audio.c |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
index fa097bd..396bacc 100644
--- a/arch/arm/mach-s5p64x0/dev-audio.c
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -24,13 +24,8 @@ static int s5p6440_cfg_i2s(struct platform_device *pdev)
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
 	case -1:
-		s3c_gpio_cfgpin(S5P6440_GPR(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(5), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(4), 5, S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(13), 2, S3C_GPIO_SFN(5));
 		break;
 
 	default:
@@ -47,13 +42,9 @@ static int s5p6450_cfg_i2s(struct platform_device *pdev)
 	switch (pdev->id) {
 	case -1:
 		s3c_gpio_cfgpin(S5P6450_GPB(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(5), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(6), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(7), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(8), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(13), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6450_GPR(14), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5P6450_GPR(4), 5, S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5P6450_GPR(13), 2, S3C_GPIO_SFN(5));
+
 		break;
 
 	default:
@@ -116,11 +107,8 @@ static int s5p6440_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(6), 3, S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(13), 2, S3C_GPIO_SFN(2));
 		break;
 
 	default:
-- 
1.6.2.5
