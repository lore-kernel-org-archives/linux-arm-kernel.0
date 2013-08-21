From: zonque@gmail.com (Daniel Mack)
Date: Wed, 21 Aug 2013 14:08:53 +0200
Subject: [PATCH v5 0/5] dma: pdma: cyclic, residue, DMA_PRIVATE
Message-ID: <1377086938-29145-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v5 of my series to teach the pdma driver more required functions.

In contrast to v4, it has yet again grown by one more patch (2/5),
which removes code that clears DCMD_ENDIRQEN at the end of the pending
chain. We want to leave of the DCMD_ENDIRQEN intact in order to
identify where a transaction ends.

Thanks to Xiang Wang and Andy Shevchenko for their reviews.


Daniel

Daniel Mack (5):
  dma: mmp_pdma: only complete one transaction from dma_do_tasklet()
  dma: mmp_pdma: don't clear DCMD_ENDIRQEN at end of pending chain
  dma: mmp_pdma: add support for cyclic DMA descriptors
  dma: mmp_pdma: add support for residue reporting
  dma: mmp_pdma: set DMA_PRIVATE

 drivers/dma/mmp_pdma.c | 247 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 210 insertions(+), 37 deletions(-)

-- 
1.8.3.1
