From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 10 Jun 2011 12:04:25 +0530
Subject: [PATCH 3/5] ARM: EXYNOS4: fix improper gpio configuration
In-Reply-To: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
References: <1307687667-9127-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1307687667-9127-4-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These pins are incorrectly configured for PCM2
configure them to SPDIF(_OUT & _EXT_CLK)

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 arch/arm/mach-exynos4/dev-audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos4/dev-audio.c b/arch/arm/mach-exynos4/dev-audio.c
index 6347594..5add5fa 100644
--- a/arch/arm/mach-exynos4/dev-audio.c
+++ b/arch/arm/mach-exynos4/dev-audio.c
@@ -335,7 +335,7 @@ struct platform_device exynos4_device_ac97 = {
 
 static int exynos4_spdif_cfg_gpio(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 2, S3C_GPIO_SFN(3));
+	s3c_gpio_cfgpin_range(EXYNOS4_GPC1(0), 2, S3C_GPIO_SFN(4));
 
 	return 0;
 }
-- 
1.7.2.3
