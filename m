From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 13:57:42 +0200
Subject: [PATCH] dma: xilinx: Remove .owner field for driver
Message-ID: <f82330042cf6185a1f4e18232ebf6999662ae48f.1407931050.git.michal.simek@xilinx.com>
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

 drivers/dma/xilinx/xilinx_vdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_vdma.c b/drivers/dma/xilinx/xilinx_vdma.c
index 42a13e8d4607..a6e64767186e 100644
--- a/drivers/dma/xilinx/xilinx_vdma.c
+++ b/drivers/dma/xilinx/xilinx_vdma.c
@@ -1365,7 +1365,6 @@ static const struct of_device_id xilinx_vdma_of_ids[] = {
 static struct platform_driver xilinx_vdma_driver = {
 	.driver = {
 		.name = "xilinx-vdma",
-		.owner = THIS_MODULE,
 		.of_match_table = xilinx_vdma_of_ids,
 	},
 	.probe = xilinx_vdma_probe,
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/289720ab/attachment.sig>
