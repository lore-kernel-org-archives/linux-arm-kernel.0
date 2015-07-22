From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 22 Jul 2015 15:17:05 +0200
Subject: [PATCH v2 0/5] add driver for Atmel QSPI controller
Message-ID: <cover.1437569902.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v2:
- remove the patches to set the "latency code" of Spansion QSPI memories
  (support of Spansion memories may be submitted in later series).
- rename "qspi" node into "spi" in the DT example to fit ePAPR standard.
- remove the useless "qspi0" label from the DT node example.
- remove the leading 0 from the size of the second memory region to make
  it consistent with the size of the first memory region.
- indent the DT bindings documentation to make it more readable.
- remove the useless ".bus	= &platform_bus_type," line from the
  platform driver definition.

v1:

This series of patches add support for the new Atmel QSPI controller
embedded inside sama5d2x SoCs.

These patches were first developped for linux-3.18-at91 and tested on a
sama5d27 Xplained ultra board, which embeds a Micron n25q128a13 QSPI NOR
flash memory. Then the series was adapted for mainline.

Cyrille Pitchen (5):
  mtd: spi-nor: notify (Q)SPI controller about protocol change
  Documentation: mtd: add a DT property to set the number of dummy
    cycles
  mtd: spi-nor: allow to tune the number of dummy cycles
  Documentation: atmel-quadspi: add binding file for Atmel QSPI driver
  mtd: atmel-quadspi: add driver for Atmel QSPI controller

 .../devicetree/bindings/mtd/atmel-quadspi.txt      |  29 +
 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |   6 +
 drivers/mtd/spi-nor/Kconfig                        |   7 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/atmel-quadspi.c                | 900 +++++++++++++++++++++
 drivers/mtd/spi-nor/spi-nor.c                      | 114 ++-
 include/linux/mtd/spi-nor.h                        |  15 +
 7 files changed, 1053 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/atmel-quadspi.c

-- 
1.8.2.2
