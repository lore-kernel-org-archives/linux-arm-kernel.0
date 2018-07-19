From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 19 Jul 2018 17:46:10 +0800
Subject: [RFC PATCH v2 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
Message-ID: <20180719094612.5833-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  These two patches try to add initial NAND driver support for Amlogic Meson
SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.

  Note this patch series actually depend on the eMMC clkc patch[2] which
still not merged.

Changes since v1 at [1]:
   - adopt property amlogic,nand-enable-scrambler - thanks Martin
   - drop nand pins in DT
   - convert clk access to emmc clkc model 
   - fix regiser field definition alignment
   - convert devm_kmalloc to kmalloc API
   - drop nand-user-mode 
   - parse cs id from DT
   - rework n2m, m2n function
   - explain why insert two "IDLE" command
   - implement exec_op()
   - drop meson_nfc_get_nand_chip_dts()
   - release resource once error occur in meson_nfc_nand_chips_init(), 
   - call nand_cleanup(nand) once mtd_device_register fail

Items not addressed in this version:
   - convert to ECC conf helper() 
   - how to construct mtd->name

[1] https://lkml.kernel.org/r/20180613161314.14894-1-yixun.lan at amlogic.com
[2] https://lkml.kernel.org/r/20180712211244.11428-1-yixun.lan at amlogic.com

Liang Yang (1):
  dt-bindings: nand: meson: add Amlogic NAND controller driver

Yixun Lan (1):
  mtd: rawnand: meson: add support for Amlogic NAND flash controller

 .../bindings/mtd/amlogic,meson-nand.txt       |   95 ++
 drivers/mtd/nand/raw/Kconfig                  |   10 +
 drivers/mtd/nand/raw/Makefile                 |    1 +
 drivers/mtd/nand/raw/meson_nand.c             | 1333 +++++++++++++++++
 4 files changed, 1439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c

-- 
2.18.0
