From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 12:19:18 +0200
Subject: [PATCH 00/12] dma: pdma: some patches needed for PXA DT environments
Message-ID: <1375870770-14263-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been working on the PXA DMA transition for some days now, and
tweaked the mmp-pdma driver in order to make it work in pure DT
environments.

I also ported over most PXA peripheral drivers, but that will take some
more time to settle. I'll post those in a separate series. Up front,
here are some patches for the mmp-pdma that can be reviewed and merged
independently.

With these patches applied, I can successfully use pxa3xx-nand, pxamci
and audio on a custom pxa3xx board.

I'm including two patches from Xiang Wang which have been posted
but not yet merged, as far as I can tell.


Many thanks,
Daniel


Daniel Mack (10):
  dma: mmp_pdma: factor out DRCMR register calculation
  dma: mmp_pdma: fix maximum transfer length
  dma: mmp_pdma: add filter function
  dma: mmp_pdma: make the controller a DMA provider
  dma: mmp_pdma: print the number of channels at probe time
  dma: mmp_pdma: remove duplicate assignment
  dma: mmp_pdma: add support for byte-aligned transfers
  dma: mmp_pdma: implement DMA_PAUSE and DMA_RESUME
  dma: mmp_pdma: add support for residue reporting
  dma: mmp_pdma: add support for cyclic DMA descriptors

Xiang Wang (2):
  dma: mmp_pdma: add protect when alloc/free phy channels
  dma: mmp_pdma: clear DRCMR when free a phy channel

 drivers/dma/mmp_pdma.c       | 274 +++++++++++++++++++++++++++++++++++++++----
 include/linux/dma/mmp-pdma.h |  15 +++
 2 files changed, 263 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/dma/mmp-pdma.h

-- 
1.8.3.1
