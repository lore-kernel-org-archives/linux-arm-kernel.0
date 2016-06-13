From: hramrach@gmail.com (Michal Suchanek)
Date: 13 Jun 2016 17:46:48 -0000
Subject: [PATCH v3 00/13] sunxi spi fixes
Message-ID: <cover.1465490774.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is update of the sunxi spi patches that should give full-featured SPI
driver.

First three patches fix issues with the current driver and can be of use for
stable kernels so adding cc for those.

I merged the sun4i and sun6i driver because there several issues that need to
be fixed in both separately and they are even out of sync wrt some fixes.
I guess some of the merge patches can be squashed.

I tested this with A10s Olinuxino Micro. I have no sun6i device so I cannot
tell if that side was broken by this patchset - especially the last patch that
adds DMA was afaik never tested on sun6i.


Emilio L?pez (1):
  spi: sun4i: add DMA support

Michal Suchanek (12):
  spi: sunxi: set maximum and minimum speed of SPI master
  spi: sunxi: fix transfer timeout
  spi: sun4i: fix FIFO limit
  spi: sunxi: expose maximum transfer size limit
  spi: sun6i: update CS handling from spi-sun4i
  spi: sunxi: rename sun4i,sun6i -> sunxi
  spi: sunxi: rename constants to match between sun4i and sun6i
  spi: sunxi: synchronize whitespace, comments, struct
  spi: sunxi: use register map
  spi: sunxi: merge sun4i and sun6i SPI driver
  dt: spi: sun4i: merge sun4i and sun6i binding doc
  spi: sunxi: remove CONFIG_SPI_SUN6I

 .../devicetree/bindings/spi/spi-sun4i.txt          |  21 +-
 .../devicetree/bindings/spi/spi-sun6i.txt          |  24 -
 arch/arm/configs/multi_v7_defconfig                |   1 -
 arch/arm/configs/sunxi_defconfig                   |   1 -
 drivers/spi/Kconfig                                |  10 +-
 drivers/spi/Makefile                               |   1 -
 drivers/spi/spi-sun4i.c                            | 728 +++++++++++++++++----
 drivers/spi/spi-sun6i.c                            | 482 --------------
 8 files changed, 600 insertions(+), 668 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
 delete mode 100644 drivers/spi/spi-sun6i.c

-- 
2.8.1
