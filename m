From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:50:03 +0900
Subject: [PATCH 3/3] mtd: samsung: Constify platform_device_id
In-Reply-To: <1430495403-31560-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495403-31560-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495403-31560-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mtd/onenand/samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index 19cfb97adbc0..739259513055 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -1083,7 +1083,7 @@ static const struct dev_pm_ops s3c_pm_ops = {
 	.resume		= s3c_pm_ops_resume,
 };
 
-static struct platform_device_id s3c_onenand_driver_ids[] = {
+static const struct platform_device_id s3c_onenand_driver_ids[] = {
 	{
 		.name		= "s3c6400-onenand",
 		.driver_data	= TYPE_S3C6400,
-- 
2.1.4
