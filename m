From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Fri, 07 Nov 2014 14:14:43 +0000
Subject: [PATCH 3/5] serial: pl011: Set length of DMA transfer
Message-ID: <545CD3D3.9000608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The DMA engines on some systems require that the dma_length is set
when using scatter gather lists.

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index d8d067a..7c5e263 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -246,6 +246,7 @@ static int pl011_sgbuf_init(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	sg_set_page(&sg->sg, phys_to_page(dma_addr),
 		PL011_DMA_BUFFER_SIZE, offset_in_page(dma_addr));
 	sg_dma_address(&sg->sg) = dma_addr;
+	sg_dma_len(&sg->sg) = PL011_DMA_BUFFER_SIZE;
 
 	return 0;
 }
-- 
1.7.1
