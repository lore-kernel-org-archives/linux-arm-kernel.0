From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 13:51:28 +0200
Subject: [PATCH] watchdog: xilinx: Remove .owner field for driver
Message-ID: <e8e4f914035bfd055525e224da9d3e62e70edb1b.1407930684.git.michal.simek@xilinx.com>
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

 drivers/watchdog/of_xilinx_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 1e6e28df5d7b..b2e1b4cbbdc1 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -236,7 +236,6 @@ static struct platform_driver xwdt_driver = {
 	.probe       = xwdt_probe,
 	.remove      = xwdt_remove,
 	.driver = {
-		.owner = THIS_MODULE,
 		.name  = WATCHDOG_NAME,
 		.of_match_table = xwdt_of_match,
 	},
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/36b667e7/attachment.sig>
