From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 14:02:05 +0200
Subject: [PATCH] char: xilinx_hwicap: Remove .owner field for driver
Message-ID: <b2fb97b7fe72ba11ce1bef74ad2038d4e932b5a9.1407931319.git.michal.simek@xilinx.com>
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

 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 9b1a5ac4881d..c07dfe5c4da3 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -843,7 +843,6 @@ static struct platform_driver hwicap_platform_driver = {
 	.probe = hwicap_drv_probe,
 	.remove = hwicap_drv_remove,
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = DRIVER_NAME,
 		.of_match_table = hwicap_of_match,
 	},
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/571d3402/attachment.sig>
