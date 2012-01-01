From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun,  1 Jan 2012 22:38:12 +0800
Subject: [PATCH v2 2/2] dma/imx-sdma: add wmb before enable a channel
In-Reply-To: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
References: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1325428692-11473-3-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma_alloc_coherent memory may be bufferable. We need to add
nececcary memory barrier.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/dma/imx-sdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index f8e87b5..9301bff 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -394,6 +394,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
+	wmb();
 	__raw_writel(1 << channel, sdma->regs + SDMA_H_START);
 }
 
-- 
1.7.4.1
