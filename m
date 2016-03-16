From: eric@anholt.net (Eric Anholt)
Date: Wed, 16 Mar 2016 12:24:55 -0700
Subject: [PATCH 1/8] dmaengine: bcm2835: set residue_granularity field
In-Reply-To: <1458156302-4359-1-git-send-email-eric@anholt.net>
References: <1458156302-4359-1-git-send-email-eric@anholt.net>
Message-ID: <1458156302-4359-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

bcm2835-dma supports residue reporting at burst level but didn't report
this via the residue_granularity field.

See also:
https://github.com/raspberrypi/linux/commit/b015555327afa402f70ddc86e3632f59df1cd9d7
for the downstream patch.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/dma/bcm2835-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 996c4b0..2d72fe8 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -625,6 +625,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	od->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	od->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	od->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	od->ddev.dev = &pdev->dev;
 	INIT_LIST_HEAD(&od->ddev.channels);
 	spin_lock_init(&od->lock);
-- 
2.7.0
