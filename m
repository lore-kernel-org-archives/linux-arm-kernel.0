From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 13:56:51 +0200
Subject: [PATCH 1/2] i2c: cadence: Remove .owner field for driver
Message-ID: <c076984af7e65c433fdfd3a3b0f8d20da2c18013.1407931005.git.michal.simek@xilinx.com>
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

 drivers/i2c/busses/i2c-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 63f3f03ecc9b..04d0a7e449ef 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -890,7 +890,6 @@ MODULE_DEVICE_TABLE(of, cdns_i2c_of_match);
 static struct platform_driver cdns_i2c_drv = {
 	.driver = {
 		.name  = DRIVER_NAME,
-		.owner = THIS_MODULE,
 		.of_match_table = cdns_i2c_of_match,
 		.pm = &cdns_i2c_dev_pm_ops,
 	},
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/22b5fa4f/attachment.sig>
