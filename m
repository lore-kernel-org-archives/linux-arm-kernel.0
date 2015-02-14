From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 14 Feb 2015 23:47:31 +0100
Subject: [PATCH RFC 0/2] Prepare smooth PXA transition to dmaengine
Message-ID: <1423954053-21760-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the best I could think of to smoothly transition the PXA drivers to
dmaengine, driver by driver. The goal is to :
 - be able to port several drivers, but not _all_ of them at the same time
 - have both dmaengine and legacy dma code working in the same kernel
 - have dma chanels correctly split between both APIs

This was only compiled for now, I'll make some test shortly.

If anybody thinks of something smarter, please let me know.

Cheers.

--
Robert

Robert Jarzmik (2):
  dma: mmp_dma: add support for legacy transition
  ARM: pxa: transition to dmaengine phase 1

 arch/arm/Kconfig                     |  2 ++
 arch/arm/plat-pxa/dma.c              |  4 +++-
 arch/arm/plat-pxa/include/plat/dma.h |  1 +
 drivers/dma/mmp_pdma.c               | 26 ++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.1.0
