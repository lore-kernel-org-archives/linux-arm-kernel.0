From: leilk.liu@mediatek.com (Leilk Liu)
Date: Fri, 7 Aug 2015 15:19:48 +0800
Subject: [PATCH v5 0/3] Add Mediatek SPI bus driver
Message-ID: <1438931991-17044-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series are based on 4.2-rc1 and provide three patches to add mediatek spi driver.

Change in v5:
1. add changelogs in the individual patches.
2. modify clk relevant implement.
3. describe dt-binding document in more detail.

Change in v4:
1. fix Mark Brown review comment.

Change in v3:
1. support fifo mode function.
2. support any non-prime length transfer in dma mode.
3. use interrupt to handle scatterlist.
4. fix review comment.

Change in v2:
1. Remove spi bitbang framwork, use can_dma() and transfer_one().
2. Add PM functions.
3. Fix Mark Brown review comment.

Leilk Liu (3):
  spi: Mediatek: Document devicetree bindings for spi bus
  spi: mediatek: Add spi bus for Mediatek MT8173
  arm64: dts: Add spi bus dts

 .../devicetree/bindings/spi/spi-mt65xx.txt         |  51 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  23 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mt65xx.c                           | 749 +++++++++++++++++++++
 include/linux/platform_data/spi-mt65xx.h           |  22 +
 6 files changed, 855 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 create mode 100644 drivers/spi/spi-mt65xx.c
 create mode 100644 include/linux/platform_data/spi-mt65xx.h

--
1.8.1.1.dirty
