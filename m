From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Jul 2016 10:43:49 +0200
Subject: [PATCH] dmaengine: zynqmp_dma: add missing MODULE_LICENSE
Message-ID: <20160719084422.3304865-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a warning about the missing MODULE_LICENSE tag for this newly
added driver module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/dma/xilinx/zynqmp_dma.o
see include/linux/module.h for more information

This adds a "GPL" license, matching the "version 2 or later" information in
the comment at the start of the file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f777a5bc0db8..693474f5f2e5 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1141,5 +1141,6 @@ static struct platform_driver zynqmp_dma_driver = {
 
 module_platform_driver(zynqmp_dma_driver);
 
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Xilinx, Inc.");
 MODULE_DESCRIPTION("Xilinx ZynqMP DMA driver");
-- 
2.9.0
