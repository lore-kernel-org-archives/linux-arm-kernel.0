From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 17 Jan 2011 22:39:23 +0800
Subject: [PATCH 1/2] dmaengine: imx-sdma: fix return of sdma_probe()
In-Reply-To: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
References: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295275164-7824-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d5a5d4d..48d0197 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1348,7 +1348,7 @@ err_clk:
 err_request_region:
 err_irq:
 	kfree(sdma);
-	return 0;
+	return ret;
 }
 
 static int __exit sdma_remove(struct platform_device *pdev)
-- 
1.7.1
