From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue,  1 Oct 2013 12:31:03 +0200
Subject: [PATCH 0/1] dma: sdma: setup dma mask
Message-ID: <1380623464-24652-1-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

The imx-sdma dma engine is not setuping it's dma mask.
This leads to a non-working audio setup since imx-ssi is using the
generic soc-dmaengine-pcm which allocate the dma buffer differently
than the previous code.

This patch is based on Russell King's following patches:
 - DMA-API: provide a helper to set both DMA and coherent DMA masks
 - DMA-API: provide a helper to setup DMA masks

Philippe R?tornaz (1):
  dma: imx-sdma: setup dma mask

 drivers/dma/imx-sdma.c |    4 ++++
 1 file changed, 4 insertions(+)

-- 
1.7.9.5
