From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 21 Jun 2013 02:35:19 +0200
Subject: [PATCH v6 3/8] gpio: samsung: Skip legacy GPIO registration if
 pinctrl-s3c64xx is present
In-Reply-To: <1371774924-9224-1-git-send-email-tomasz.figa@gmail.com>
References: <1371774924-9224-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1371774924-9224-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new driver handles GPIO on DT-enabled platforms.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/gpio/gpio-samsung.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index a1392f4..8d512b1 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2949,7 +2949,7 @@ static __init int samsung_gpiolib_init(void)
 	int i, nr_chips;
 	int group = 0;
 
-#if defined(CONFIG_PINCTRL_EXYNOS) || defined(CONFIG_PINCTRL_EXYNOS5440)
+#if defined(CONFIG_PINCTRL_SAMSUNG) || defined(CONFIG_PINCTRL_EXYNOS5440)
 	/*
 	* This gpio driver includes support for device tree support and there
 	* are platforms using it. In order to maintain compatibility with those
@@ -2967,6 +2967,7 @@ static __init int samsung_gpiolib_init(void)
 		{ .compatible = "samsung,s3c2416-pinctrl", },
 		{ .compatible = "samsung,s3c2440-pinctrl", },
 		{ .compatible = "samsung,s3c2450-pinctrl", },
+		{ .compatible = "samsung,s3c64xx-pinctrl", },
 		{ .compatible = "samsung,exynos4210-pinctrl", },
 		{ .compatible = "samsung,exynos4x12-pinctrl", },
 		{ .compatible = "samsung,exynos5250-pinctrl", },
-- 
1.8.2.1
