From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 8 Jul 2014 15:11:34 +0200
Subject: [PATCH v3 0/2] new Atmel DMA controller
Message-ID: <1404825096-15724-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches introduces support for the new Atmel DMA controller know as
XDMAC and available on SAMA5D4.

Documentation has been updated including Mark and Sergei comments. Some locking
issues have been fixed thanks to Leilei.


Changes from:
- v2
  - documentation updated
  - fix locking issues
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

 .../devicetree/bindings/dma/atmel-xdma.txt         |   48 +
 drivers/dma/Kconfig                                |    7 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/at_xdmac.c                             | 1181 ++++++++++++++++++++
 drivers/dma/at_xdmac.h                             |  308 +++++
 include/dt-bindings/dma/at91.h                     |   25 +
 6 files changed, 1570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/atmel-xdma.txt
 create mode 100644 drivers/dma/at_xdmac.c
 create mode 100644 drivers/dma/at_xdmac.h

-- 
1.7.9.5
