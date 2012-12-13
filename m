From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 13 Dec 2012 17:24:03 +0530
Subject: [PATCH 2/3] gpio: samsung: skip gpiolib registration if pinctrl
 support is enabled for exynos5250
In-Reply-To: <1355399644-29417-1-git-send-email-thomas.abraham@linaro.org>
References: <1355399644-29417-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1355399644-29417-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Skip exynos5250 gpiolib registration if pinctrl support for exynos5250
is enabled.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/gpio/gpio-samsung.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 01f7fe9..849c134 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -3026,6 +3026,7 @@ static __init int samsung_gpiolib_init(void)
 	static const struct of_device_id exynos_pinctrl_ids[] = {
 		{ .compatible = "samsung,pinctrl-exynos4210", },
 		{ .compatible = "samsung,pinctrl-exynos4x12", },
+		{ .compatible = "samsung,pinctrl-exynos5250", },
 	};
 	for_each_matching_node(pctrl_np, exynos_pinctrl_ids)
 		if (pctrl_np && of_device_is_available(pctrl_np))
-- 
1.6.6.rc2
