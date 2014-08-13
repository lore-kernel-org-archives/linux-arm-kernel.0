From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 13 Aug 2014 13:52:39 +0200
Subject: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
Message-ID: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
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

 drivers/spi/spi-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 4d8efb16573d..79bd84f43430 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -471,7 +471,6 @@ static struct platform_driver xilinx_spi_driver = {
 	.remove = xilinx_spi_remove,
 	.driver = {
 		.name = XILINX_SPI_NAME,
-		.owner = THIS_MODULE,
 		.of_match_table = xilinx_spi_of_match,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/0bd1c0ed/attachment-0001.sig>
