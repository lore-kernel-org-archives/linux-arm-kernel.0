From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 14:00:59 +0200
Subject: [PATCH] iio: adc: xilinx: Remove .owner field for driver
Message-ID: <32522124850adfda5c6cb8a7759d0e3a63893c1e.1407931250.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to init .owner field.

Based on the patch from Peter Griffin <peter.griffin@linaro.org>
"mmc: remove .owner field for drivers using module_platform_driver"

This patch removes the superflous .owner field for drivers which
use the module_platform_driver API, as this is overriden in
platform_driver_register anyway."

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/iio/adc/xilinx-xadc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index fd2745c62943..92541a80b041 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1322,7 +1322,6 @@ static struct platform_driver xadc_driver = {
 	.remove = xadc_remove,
 	.driver = {
 		.name = "xadc",
-		.owner = THIS_MODULE,
 		.of_match_table = xadc_of_match_table,
 	},
 };
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/4730dcb3/attachment.sig>
