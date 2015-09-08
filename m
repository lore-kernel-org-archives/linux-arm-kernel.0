From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Tue, 8 Sep 2015 17:49:53 +0800
Subject: [PATCH 0/3] Mediatek SPI-NOR flash driver 
Message-ID: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch supports MediaTek's NOR flash controller.
The NOR flash controller is specifically for spi nor flash,
and it is more stable and faster than SPI bus, the MTK
NOR controller not only support single mode but also support
dual mode and quad mode.

This series is based on v4.2-rc1 and l2-mtd.git
(git://git.infradead.org/l2-mtd.git)

Bayi Cheng (3):
  doc: dt: add documentation for Mediatek spi-nor controller
  mtd: mtk-nor: mtk serial flash controller driver
  arm64: dts: mt8173: Add nor flash node

 Documentation/devicetree/bindings/mtd/mtk_nor.txt |  25 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi          |  10 +
 drivers/mtd/spi-nor/Kconfig                       |   7 +
 drivers/mtd/spi-nor/Makefile                      |   1 +
 drivers/mtd/spi-nor/mtk_nor.c                     | 533 ++++++++++++++++++++++
 5 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk_nor.txt
 create mode 100644 drivers/mtd/spi-nor/mtk_nor.c

--
1.8.1.1.dirty
