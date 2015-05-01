From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:53:07 +0900
Subject: [PATCH 2/2] input: s3c2410_ts: Constify platform_device_id
In-Reply-To: <1430495587-31762-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495587-31762-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495587-31762-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/input/touchscreen/s3c2410_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index bdfa27dc097b..a4a103e1d11b 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -411,7 +411,7 @@ static const struct dev_pm_ops s3c_ts_pmops = {
 };
 #endif
 
-static struct platform_device_id s3cts_driver_ids[] = {
+static const struct platform_device_id s3cts_driver_ids[] = {
 	{ "s3c2410-ts", 0 },
 	{ "s3c2440-ts", 0 },
 	{ "s3c64xx-ts", FEAT_PEN_IRQ },
-- 
2.1.4
