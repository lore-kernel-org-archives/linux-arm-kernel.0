From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 11 Apr 2015 21:40:31 +0200
Subject: [PATCH v2 0/5] Driver for pxa architectures
Message-ID: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

This is the same serie as in v1, only one fix around irq probing was included in
patch 3/5. I copy-pasted the previous cover letter for reference here :

This serie introduces a new driver for Marvell pxa architectures. There is a
full rationale explanation in patch 3/5 on why mmp_pdma was not reused nor
patched incrementally.

This new driver provides all the capabilities to port all the drivers of pxa
architecture to dmaengine. It was tested against the most dma advanced user I
know (pxa_camera), as well a more casual ones (pxamci and dmatest).

This is big piece of code, so I expect the review will take time. If we converge
on it, it will be maintained as well as part of the pxa architeture
maintainance.

It is as well one of the last steps (or so I hope) for pxa architure to be part
of the multiplatform ARM architecture, and at the same time keep its legacy
platforms operational. It will kill arch/arm/plat-pxa/dma.c in the long term.

Cheers.

Robert Jarzmik (5):
  Documentation: dmaengine: pxa-dma design
  MAINTAINERS: add pxa dma driver to pxa architecture
  dmaengine: pxa: add pxa dmaengine driver
  dmaengine: pxa_dma: add debug information
  dmaengine: pxa_dma: add support for legacy transition

 Documentation/dmaengine/pxa_dma.txt |  157 ++++
 MAINTAINERS                         |    1 +
 drivers/dma/Kconfig                 |   11 +
 drivers/dma/Makefile                |    1 +
 drivers/dma/pxa_dma.c               | 1479 +++++++++++++++++++++++++++++++++++
 include/linux/dma/pxa-dma.h         |   27 +
 6 files changed, 1676 insertions(+)
 create mode 100644 Documentation/dmaengine/pxa_dma.txt
 create mode 100644 drivers/dma/pxa_dma.c
 create mode 100644 include/linux/dma/pxa-dma.h

-- 
2.1.4
