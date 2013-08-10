From: zonque@gmail.com (Daniel Mack)
Date: Sat, 10 Aug 2013 18:52:14 +0200
Subject: [PATCH v2 00/11] dma: pdma: some patches needed for PXA DT
 environments
Message-ID: <1376153545-14361-1-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of my series to add more features to the pdma driver.

Changes from v1 -> v2:

 - drop the two patches from Xiang Wang that are already applied to
   Vinod's next branch
 - add another patch to cleanup the unlocking path in lookup_phy(),
   as suggested by Ezequiel
 - provide an own xlate function rather than using
   of_dma_simple_xlate(), as suggested by Arnd


There's still an open topic with the DALGN flag, as Xiang Wang pointed
out. According to him, there's a chance we need an alternative way of
forcing the driver into byte-align mode, but that can still be done in
an additional patch later.


Thanks,
Daniel



Daniel Mack (11):
  dma: mmp_pdma: factor out DRCMR register calculation
  dma: mmp_pdma: refactor unlocking path in lookup_phy()
  dma: mmp_pdma: fix maximum transfer length
  dma: mmp_pdma: add filter function
  dma: mmp_pdma: make the controller a DMA provider
  dma: mmp_pdma: print the number of channels at probe time
  dma: mmp_pdma: remove duplicate assignment
  dma: mmp_pdma: add support for byte-aligned transfers
  dma: mmp_pdma: implement DMA_PAUSE and DMA_RESUME
  dma: mmp_pdma: add support for residue reporting
  dma: mmp_pdma: add support for cyclic DMA descriptors

 drivers/dma/mmp_pdma.c       | 265 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/dma/mmp-pdma.h |  15 +++
 2 files changed, 264 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/dma/mmp-pdma.h

-- 
1.8.3.1
