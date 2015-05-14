From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 14 May 2015 09:03:06 +0900
Subject: [PATCH] drm/exynos: dp: Lower level of EDID read success message
Message-ID: <1431561786-12413-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't pollute the dmesg with EDID read success message as an error.
Printing as debug should be fine.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
index 441ef06b8894..30feb7d06624 100644
--- a/drivers/gpu/drm/exynos/exynos_dp_core.c
+++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
@@ -195,7 +195,7 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
 		}
 	}
 
-	dev_err(dp->dev, "EDID Read success!\n");
+	dev_dbg(dp->dev, "EDID Read success!\n");
 	return 0;
 }
 
-- 
1.9.1
