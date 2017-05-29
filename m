From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Mon, 29 May 2017 17:45:56 +0200
Subject: [PATCH 08/15] mfd: exynos: use devm_of_platform_populate()
In-Reply-To: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
References: <1496072763-31209-1-git-send-email-benjamin.gaignard@linaro.org>
Message-ID: <1496072763-31209-9-git-send-email-benjamin.gaignard@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_of_platform_populate() to be sure that of_platform_depopulate
is called when removing the driver.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

CC: Lee Jones <lee.jones@linaro.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Javier Martinez Canillas <javier@osg.samsung.com>
CC: linux-arm-kernel at lists.infradead.org
CC: linux-samsung-soc at vger.kernel.org
CC: linux-kernel at vger.kernel.org
---
 drivers/mfd/exynos-lpass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 0bf3aeb..ca829f8 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -138,7 +138,7 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	exynos_lpass_enable(lpass);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	return devm_of_platform_populate(dev);
 }
 
 static int exynos_lpass_remove(struct platform_device *pdev)
-- 
1.9.1
