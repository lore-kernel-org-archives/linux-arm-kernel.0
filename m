From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 18:12:39 +0100
Subject: [PATCH] dmaengine: ti-dma-crossbar: make omap_dmaxbar_init static
Message-ID: <1466529159-10359-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap_dmaxbar_init() function is not exported or declared outside
the driver, so make it static to fix the following sparse warning:

drivers/dma/ti-dma-crossbar.c:455:5: warning: symbol 'omap_dmaxbar_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/dma/ti-dma-crossbar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index e107779..5ae294b 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -452,7 +452,7 @@ static struct platform_driver ti_dma_xbar_driver = {
 	.probe	= ti_dma_xbar_probe,
 };
 
-int omap_dmaxbar_init(void)
+static int omap_dmaxbar_init(void)
 {
 	return platform_driver_register(&ti_dma_xbar_driver);
 }
-- 
2.8.1
