From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:49:22 +0900
Subject: [PATCH 6/6] mmc: sdhc-s3c: Constify platform_device_id
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495362-31506-6-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index c6d2dd7317c1..70c724bc6fc7 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -736,7 +736,7 @@ static struct sdhci_s3c_drv_data exynos4_sdhci_drv_data = {
 #define EXYNOS4_SDHCI_DRV_DATA ((kernel_ulong_t)NULL)
 #endif
 
-static struct platform_device_id sdhci_s3c_driver_ids[] = {
+static const struct platform_device_id sdhci_s3c_driver_ids[] = {
 	{
 		.name		= "s3c-sdhci",
 		.driver_data	= (kernel_ulong_t)NULL,
-- 
2.1.4
