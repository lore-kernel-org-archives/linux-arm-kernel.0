From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:07 +0900
Subject: [PATCH 4/4] spi: sh-msiof: Constify platform_device_id
In-Reply-To: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495047-31122-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index bcc7c635d8e7..d3370a612d84 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1263,7 +1263,7 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id spi_driver_ids[] = {
+static const struct platform_device_id spi_driver_ids[] = {
 	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
 	{ "spi_r8a7790_msiof",	(kernel_ulong_t)&r8a779x_data },
 	{ "spi_r8a7791_msiof",	(kernel_ulong_t)&r8a779x_data },
-- 
2.1.4
