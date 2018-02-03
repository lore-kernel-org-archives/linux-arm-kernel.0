From: lkp@intel.com (kbuild test robot)
Date: Sat, 3 Feb 2018 23:10:44 +0800
Subject: [RFC PATCH] dmaengine: mediatek: mtk_hsdma_find_active_desc() can be
 static
In-Reply-To: <3d5c7933c83ec456bdbcc70623fd460eb66eba1c.1517454174.git.sean.wang@mediatek.com>
References: <3d5c7933c83ec456bdbcc70623fd460eb66eba1c.1517454174.git.sean.wang@mediatek.com>
Message-ID: <20180203151044.GA44748@lkp-hsx03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 73006a033ef0 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 mtk-hsdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index cd3af5c..c1523b4 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -643,8 +643,8 @@ static irqreturn_t mtk_hsdma_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-struct virt_dma_desc *mtk_hsdma_find_active_desc(struct dma_chan *c,
-						 dma_cookie_t cookie)
+static struct virt_dma_desc *mtk_hsdma_find_active_desc(struct dma_chan *c,
+							dma_cookie_t cookie)
 {
 	struct mtk_hsdma_vchan *hvc = to_hsdma_vchan(c);
 	struct virt_dma_desc *vd;
