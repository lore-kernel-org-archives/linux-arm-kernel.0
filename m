From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:33 +0100
Subject: [PATCH 14/20] clocksource: sh_tmu: Remove unnecessary
 platform_set_drvdata()
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jingoo Han <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_tmu.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 78b8dae..54ab475 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -509,7 +509,6 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	ret = sh_tmu_setup(p, pdev);
 	if (ret) {
 		kfree(p);
-		platform_set_drvdata(pdev, NULL);
 		pm_runtime_idle(&pdev->dev);
 		return ret;
 	}
-- 
1.7.9.5
