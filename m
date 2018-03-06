From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 06 Mar 2018 15:43:44 +0100
Subject: [PATCH 01/12] thermal: exynos: remove unused "type" field from
 struct exynos_tmu_platform_data
In-Reply-To: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180306144431epcas2p1fef7b2d8130decb08e023b4ff329e9ff@epcas2p1.samsung.com>
Message-ID: <1520347435-22970-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unused "type" field from struct exynos_tmu_platform_data.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index 5149c2a..8c468b6 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -47,7 +47,6 @@ enum soc_type {
  *	0 < reference_voltage <= 31
  * @noise_cancel_mode: noise cancellation mode
  *	000, 100, 101, 110 and 111 can be different modes
- * @type: determines the type of SOC
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -68,7 +67,6 @@ struct exynos_tmu_platform_data {
 	u8 second_point_trim;
 	u8 default_temp_offset;
 
-	enum soc_type type;
 	u32 cal_type;
 };
 
-- 
1.9.1
