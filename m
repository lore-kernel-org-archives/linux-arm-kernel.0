From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 17 Jan 2011 22:39:24 +0800
Subject: [PATCH 2/2] dmaengine: imx-sdma: fix inconsistent naming in
	sdma_assign_cookie()
In-Reply-To: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
References: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1295275164-7824-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Variable name sdma and sdmac are consistently used as the pointer to
sdma_engine and sdma_channel respectively throughout the file.  The
patch fixes the inconsistency seen in function sdma_assign_cookie().

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/dma/imx-sdma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 48d0197..4eb1d29 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -770,15 +770,15 @@ static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
 }
 
-static dma_cookie_t sdma_assign_cookie(struct sdma_channel *sdma)
+static dma_cookie_t sdma_assign_cookie(struct sdma_channel *sdmac)
 {
-	dma_cookie_t cookie = sdma->chan.cookie;
+	dma_cookie_t cookie = sdmac->chan.cookie;
 
 	if (++cookie < 0)
 		cookie = 1;
 
-	sdma->chan.cookie = cookie;
-	sdma->desc.cookie = cookie;
+	sdmac->chan.cookie = cookie;
+	sdmac->desc.cookie = cookie;
 
 	return cookie;
 }
-- 
1.7.1
