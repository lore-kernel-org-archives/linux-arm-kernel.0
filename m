From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 14:01:21 +0200
Subject: [PATCH] gpio: zynq: Remove .owner field for driver
Message-ID: <78682b5ace6f31f2b52496823823116076eefd61.1407931277.git.michal.simek@xilinx.com>
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

 drivers/gpio/gpio-zynq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index c3145f91fda3..a94db67c23b0 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -668,7 +668,6 @@ MODULE_DEVICE_TABLE(of, zynq_gpio_of_match);
 static struct platform_driver zynq_gpio_driver = {
 	.driver	= {
 		.name = DRIVER_NAME,
-		.owner = THIS_MODULE,
 		.pm = &zynq_gpio_dev_pm_ops,
 		.of_match_table = zynq_gpio_of_match,
 	},
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/1d3b011c/attachment.sig>
