From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:51:01 +0900
Subject: [PATCH 2/4] media: platform: exynos4-is: Constify platform_device_id
In-Reply-To: <1430495463-31633-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495463-31633-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495463-31633-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/media/platform/exynos4-is/media-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/media-dev.c b/drivers/media/platform/exynos4-is/media-dev.c
index f315ef946cd4..4f5586a4cbff 100644
--- a/drivers/media/platform/exynos4-is/media-dev.c
+++ b/drivers/media/platform/exynos4-is/media-dev.c
@@ -1451,7 +1451,7 @@ static int fimc_md_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id fimc_driver_ids[] __always_unused = {
+static const struct platform_device_id fimc_driver_ids[] __always_unused = {
 	{ .name = "s5p-fimc-md" },
 	{ },
 };
-- 
2.1.4
