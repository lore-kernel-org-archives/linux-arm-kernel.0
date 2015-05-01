From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:51:02 +0900
Subject: [PATCH 3/4] media: platform: s3c-camif: Constify platform_device_id
In-Reply-To: <1430495463-31633-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495463-31633-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495463-31633-3-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/media/platform/s3c-camif/camif-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index 2d5bd3ac7f81..f47b332f0418 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -628,7 +628,7 @@ static struct s3c_camif_drvdata s3c6410_camif_drvdata = {
 	.bus_clk_freq	= 133000000UL,
 };
 
-static struct platform_device_id s3c_camif_driver_ids[] = {
+static const struct platform_device_id s3c_camif_driver_ids[] = {
 	{
 		.name		= "s3c2440-camif",
 		.driver_data	= (unsigned long)&s3c244x_camif_drvdata,
-- 
2.1.4
