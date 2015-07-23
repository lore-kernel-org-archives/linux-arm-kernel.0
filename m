From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 23 Jul 2015 17:10:39 +0800
Subject: [PATCH  v3 0/4] Add Mediatek SPI bus driver
Message-ID: <1437642643-11966-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change in v3:
1. support fifo mode function.
2. support any non-prime length transfer in dma mode.
3. use interrupt to handle scatterlist.
4. fix review comment.

Leilk Liu (4):
  spi: support spi without dma channel to use can_dma()
  dt-bindings: ARM: Mediatek: Document devicetree bindings for spi bus
  spi: mediatek: Add spi bus for Mediatek MT8173
  arm64: dts: Add spi bus dts

 .../devicetree/bindings/spi/spi-mt65xx.txt         |  38 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  23 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mt65xx.c                           | 817 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  22 +-
 include/linux/platform_data/spi-mt65xx.h           |  22 +
 7 files changed, 928 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 create mode 100644 drivers/spi/spi-mt65xx.c
 create mode 100644 include/linux/platform_data/spi-mt65xx.h

--
1.8.1.1.dirty
