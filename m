From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 17 Sep 2018 10:19:19 +0800
Subject: [PATCH v3 0/3] Add Mediatek SPI slave driver
Message-ID: <1537150762-7072-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 82bced99683343899dea4634452940b15d6374eb Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Mon, 17 Sep 2018 10:07:45 +0800
Subject: [PATCH v3 0/3] Add Mediatek SPI slave driver

v3:
1. Fix Rob Herring review comment about bindings.
2. remove unused variables in driver.

v2:
1. Fix Sean Wang review comment.
2. remove unused register and offset define.
3. update bindings file with assigned-clocks and assigned-clocks-parents.

v1:
This series are based on 4.19-rc1 and provide three patches to add mediatek spi slave driver.

Leilk Liu (3):
  spis: mediatek: add bindings for Mediatek MT2712 soc platform
  spis: mediatek: add spi slave for Mediatek MT2712
  arm64: dts: Add spi slave dts

 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |  32 ++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  11 +
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-slave-mt27xx.c                     | 553 +++++++++++++++++++++
 5 files changed, 605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
 create mode 100644 drivers/spi/spi-slave-mt27xx.c

-- 
1.9.1
