From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:49:20 +0900
Subject: [PATCH 4/6] mmc: s3cmci: Constify platform_device_id
In-Reply-To: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495362-31506-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495362-31506-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 94cddf381ba3..6291d5042ef2 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1856,7 +1856,7 @@ static int s3cmci_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id s3cmci_driver_ids[] = {
+static const struct platform_device_id s3cmci_driver_ids[] = {
 	{
 		.name	= "s3c2410-sdi",
 		.driver_data	= 0,
-- 
2.1.4
