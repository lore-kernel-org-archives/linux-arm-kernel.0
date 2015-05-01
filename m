From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 00:44:05 +0900
Subject: [PATCH 2/4] spi: rspi: Constify platform_device_id
In-Reply-To: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430495047-31122-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430495047-31122-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/spi/spi-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index f6bac9e77d06..70a7a7b168fd 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1300,7 +1300,7 @@ error1:
 	return ret;
 }
 
-static struct platform_device_id spi_driver_ids[] = {
+static const struct platform_device_id spi_driver_ids[] = {
 	{ "rspi",	(kernel_ulong_t)&rspi_ops },
 	{ "rspi-rz",	(kernel_ulong_t)&rspi_rz_ops },
 	{ "qspi",	(kernel_ulong_t)&qspi_ops },
-- 
2.1.4
