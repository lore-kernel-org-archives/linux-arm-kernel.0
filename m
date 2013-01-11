From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jan 2013 13:13:00 +0000
Subject: [PATCH 12/18] power: ab8500_btemp: remove superfluous BTEMP thermal
 comp.
In-Reply-To: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357909986-9262-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hakan Berg <hakan.berg@stericsson.com>

BTEMP thermal compensation factor times 10 is applied in two
places, probe and get_property. Removed from probe.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Hakan Berg <hakan.berg@stericsson.com>
Reviewed-by: Karl KOMIEROWSKI <karl.komierowski@stericsson.com>
---
 drivers/power/ab8500_btemp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/ab8500_btemp.c b/drivers/power/ab8500_btemp.c
index 6f6a715..c882a9a 100644
--- a/drivers/power/ab8500_btemp.c
+++ b/drivers/power/ab8500_btemp.c
@@ -1030,8 +1030,8 @@ static int __devinit ab8500_btemp_probe(struct platform_device *pdev)
 		ab8500_btemp_periodic_work);
 
 	/* Set BTEMP thermal limits. Low and Med are fixed */
-	di->btemp_ranges.btemp_low_limit = BTEMP_THERMAL_LOW_LIMIT * 10;
-	di->btemp_ranges.btemp_med_limit = BTEMP_THERMAL_MED_LIMIT * 10;
+	di->btemp_ranges.btemp_low_limit = BTEMP_THERMAL_LOW_LIMIT;
+	di->btemp_ranges.btemp_med_limit = BTEMP_THERMAL_MED_LIMIT;
 
 	ret = abx500_get_register_interruptible(di->dev, AB8500_CHARGER,
 		AB8500_BTEMP_HIGH_TH, &val);
-- 
1.7.9.5
