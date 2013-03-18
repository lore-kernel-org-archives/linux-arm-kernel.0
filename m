From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 18 Mar 2013 22:31:51 +0100
Subject: [PATCH 2/6] pinctrl: samsung: Include pinctrl-exynos driver data
 conditionally
In-Reply-To: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1363642315-10331-3-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pinctrl-samsung is a common part of the pin control support for
several Samsung SoCs, it can be compiled without Exynos support enabled.

This patch surrounds Exynos-specific driver data with ifdefs to include
them only when support for Exynos is enabled.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/pinctrl-samsung.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-samsung.c b/drivers/pinctrl/pinctrl-samsung.c
index b1d4ac8..f1fb562 100644
--- a/drivers/pinctrl/pinctrl-samsung.c
+++ b/drivers/pinctrl/pinctrl-samsung.c
@@ -968,10 +968,12 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id samsung_pinctrl_dt_match[] = {
+#ifdef CONFIG_PINCTRL_EXYNOS4
 	{ .compatible = "samsung,exynos4210-pinctrl",
 		.data = (void *)exynos4210_pin_ctrl },
 	{ .compatible = "samsung,exynos4x12-pinctrl",
 		.data = (void *)exynos4x12_pin_ctrl },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, samsung_pinctrl_dt_match);
-- 
1.8.1.5
