From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:48 +0530
Subject: [PATCH 23/50] pinctrl: exynos5440: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-24-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-exynos5440.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index 00ab63a..71f9f13 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -788,7 +788,7 @@ static int exynos5440_pinctrl_register(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	pctl_dev = pinctrl_register(ctrldesc, &pdev->dev, priv);
+	pctl_dev = devm_pinctrl_register(&pdev->dev, ctrldesc, priv);
 	if (IS_ERR(pctl_dev)) {
 		dev_err(&pdev->dev, "could not register pinctrl driver\n");
 		return PTR_ERR(pctl_dev);
-- 
2.1.4
