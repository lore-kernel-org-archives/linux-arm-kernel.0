From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 4 Jul 2014 09:36:08 +0200
Subject: [PATCH v2 0/2] new Atmel DMA controller
Message-ID: <1404459370-3540-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches introduces support for the new Atmel DMA controller know as
XDMAC and available on SAMA5D4.

Changes from:
- v1
  - add power management stuff
  - check maxburst value
  - revert subsys_initcall remove, EPROBE_DEFER not yet available on the kernel
  version I use to do the tests, moreover other devices are not ready to use it

- RFC:
  - DMA_SUCCESS replaced by DMA_COMPLETE
  - fix memcpy issue caused by a mistake in interfaces used
  - add filter function
  - remove some parameters from device tree since we can get them through the
  dma slave configuration
  - use readl/writel relaxed
  - remove subsys_initcall
  - synchronize irq before killing tasklets
  - use BIT macro
  - misc cleanup


Ludovic Desroches (2):
  dma: at_xdmac: creation of the atmel eXtended DMA Controller driver
  ARM: dts: at_xdmac: add bindings documentation

 .../devicetree/bindings/dma/atmel-xdma.txt         |   39 +
 drivers/dma/Kconfig                                |    7 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/at_xdmac.c                             | 1179 ++++++++++++++++++++
 drivers/dma/at_xdmac.h                             |  308 +++++
 include/dt-bindings/dma/at91.h                     |   25 +
 6 files changed, 1559 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt
 create mode 100644 drivers/dma/at_xdmac.c
 create mode 100644 drivers/dma/at_xdmac.h

-- 
1.7.9.5
