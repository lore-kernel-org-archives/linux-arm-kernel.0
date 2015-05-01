From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:49:21 +0900
Subject: [PATCH 5/6] mmc: sdhci-imx: Constify platform_device_id
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495362-31506-5-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 82f512d87cb8..7b6ff7067320 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -161,7 +161,7 @@ struct pltfm_imx_data {
 	u32 is_ddr;
 };
 
-static struct platform_device_id imx_esdhc_devtype[] = {
+static const struct platform_device_id imx_esdhc_devtype[] = {
 	{
 		.name = "sdhci-esdhc-imx25",
 		.driver_data = (kernel_ulong_t) &esdhc_imx25_data,
-- 
2.1.4
