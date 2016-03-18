From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 15:21:11 +0100
Subject: [PATCH v3 4/5] dmaengine: sun6i: Simplify some macros
In-Reply-To: <cover.1458311540.git.moinejf@free.fr>
References: <cover.1458311540.git.moinejf@free.fr>
Message-ID: <a25c76bc3c63afc311069366af4970b909d356ef.1458311540.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the max burst and bus width values are now checked, there is
no reason to check them again when setting the hardware registers.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/dma/sun6i-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 3f73123..643ba4c 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -65,8 +65,8 @@
 #define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & 0x1f)
 #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
 #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
-#define DMA_CHAN_CFG_SRC_BURST(x)	(((x) & 0x3) << 7)
-#define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
+#define DMA_CHAN_CFG_SRC_BURST(x)	((x) << 7)
+#define DMA_CHAN_CFG_SRC_WIDTH(x)	((x) << 9)
 
 #define DMA_CHAN_CFG_DST_DRQ(x)		(DMA_CHAN_CFG_SRC_DRQ(x) << 16)
 #define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
-- 
2.7.4
