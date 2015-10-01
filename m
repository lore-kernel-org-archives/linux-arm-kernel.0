From: bayi.cheng@mediatek.com (Bayi Cheng)
Date: Thu, 1 Oct 2015 15:44:49 +0800
Subject: [PATCH v3 0/3] Mediatek SPI-NOR flash driver 
Message-ID: <1443685492-9996-1-git-send-email-bayi.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch supports MediaTek's NOR flash controller.
THe NOR flash controller is specifically for spi nor flash,
and it is more stable and faster than SPI bus, the MTK
NOR controller not only support single mode but also support
dual mode and quad mode.

This series is based on v4.3-rc1 and l2-mtd.git
(git://git.infradead.org/l2-mtd.git)

Change in v3:
1: use switch() to replace some if-else statement
2: use shifts to replace endianness statement
3: delete some unused macros
4: use auto-increment mechanism for single write
5: write address added to 32bytes

Change in v2:
1. Rebase to 4.3-rc1
2. propagate error code
3. delete mux clock and axi clock in dts file
4. descripts more exactly for binding file
5. change file names from mtk-nor.c to mtk_quadspi.c
6. delete some functions witch were used once time

Bayi Cheng (3):
  doc: dt: add documentation for Mediatek spi-nor controller
  mtd: mtk-nor: mtk serial flash controller driver
  arm64: dts: mt8173: Add nor flash node

 .../devicetree/bindings/mtd/mtk-quadspi.txt        |  30 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  15 +
 drivers/mtd/spi-nor/Kconfig                        |   7 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/mtk-quadspi.c                  | 486 +++++++++++++++++++++
 5 files changed, 539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
 create mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c

--
1.8.1.1.dirty
