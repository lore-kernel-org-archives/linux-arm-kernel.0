From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:49:18 +0900
Subject: [PATCH 2/6] mmc: mxs: Constify platform_device_id
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495362-31506-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/mxs-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index a82411a2c024..d839147e591d 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -549,7 +549,7 @@ static const struct mmc_host_ops mxs_mmc_ops = {
 	.enable_sdio_irq = mxs_mmc_enable_sdio_irq,
 };
 
-static struct platform_device_id mxs_ssp_ids[] = {
+static const struct platform_device_id mxs_ssp_ids[] = {
 	{
 		.name = "imx23-mmc",
 		.driver_data = IMX23_SSP,
-- 
2.1.4
