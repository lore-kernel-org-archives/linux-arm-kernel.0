From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:09 +0900
Subject: [PATCH 12/27] ARM: S5P6442: Change to using s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-13-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting a range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgall_range().

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/dev-spi.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s5p6442/dev-spi.c b/arch/arm/mach-s5p6442/dev-spi.c
index 547c570..cce8c24 100644
--- a/arch/arm/mach-s5p6442/dev-spi.c
+++ b/arch/arm/mach-s5p6442/dev-spi.c
@@ -38,10 +38,9 @@ static int s5p6442_spi_cfg_gpio(struct platform_device *pdev)
 	switch (pdev->id) {
 	case 0:
 		s3c_gpio_cfgpin(S5P6442_GPB(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin_range(S5P6442_GPB(2), 2, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(S5P6442_GPB(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6442_GPB(2), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6442_GPB(3), S3C_GPIO_PULL_UP);
+		s3c_gpio_cfgall_range(S5P6442_GPB(2), 2,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 		break;
 
 	default:
-- 
1.6.2.5
