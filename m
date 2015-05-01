From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 01:02:48 +0900
Subject: [PATCH 2/2] clk: s3c2410: Constify platform_device_id
In-Reply-To: <1430496168-32408-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496168-32408-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430496168-32408-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/clk/samsung/clk-s3c2410-dclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index db6fddb211d4..e56df5064889 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -404,7 +404,7 @@ static struct s3c24xx_dclk_drv_data dclk_variants[] = {
 	},
 };
 
-static struct platform_device_id s3c24xx_dclk_driver_ids[] = {
+static const struct platform_device_id s3c24xx_dclk_driver_ids[] = {
 	{
 		.name		= "s3c2410-dclk",
 		.driver_data	= (kernel_ulong_t)&dclk_variants[S3C2410],
-- 
2.1.4
