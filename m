From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 25 Aug 2014 16:30:25 +0900
Subject: [PATCHv4 4/4] thermal: exynos: Remove duplicate code when reading
 triminfo register of Exynos5440
In-Reply-To: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
References: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1408951825-2639-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch remove simply duplicate code when reading triminfo register of Exynos5440.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7234f38..caeb445 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -195,15 +195,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 		 */
 		switch (data->id) {
 		case 0:
+		case 2:
 			trim_info = readl(data->base +
 			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
 			break;
 		case 1:
 			trim_info = readl(data->base + reg->triminfo_data);
 			break;
-		case 2:
-			trim_info = readl(data->base -
-			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
 		}
 	} else {
 		/* On exynos5420 the triminfo register is in the shared space */
-- 
1.8.0
