From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 12 Mar 2014 19:07:35 +0100
Subject: [PATCH v3 0/9] mtd: nand: add sunxi NAND Flash Controller support
Message-ID: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the sunxi NAND Flash Controller (NFC).

I'll split this series for the next round:
1) NAND timings
2) sunxi NAND controller driver

But I'd like to have some feedback on the NAND timings stuff before doing this.

Any review on the sunxi driver is welcome (for the moment I only got feedback
on the NAND timings code).

I also have patches adding support for HW randomizer and per ECC partition
config that you can find here:
https://groups.google.com/forum/#!searchin/linux-sunxi/boris/linux-sunxi/s3lBb01I0Js/Bem2X1wKPa4J
But I'd like to get the sunxi NAND driver mainlined before adding more
intrusive parts.

Best Regards,

Boris

Changes since v2:
 - merge HW ECC implementation in base implementation patch
 - fix timing config when interfacing with an ONFI compatible chip

Changes since v1:
 - add HW ECC support
 - rework NAND timings retrieval (use ONFI timing mode instead of raw timings)
 - add nand-ecc-level property to specify NAND ECC requirements from DT


Boris BREZILLON (9):
  mtd: nand: define struct nand_timings
  mtd: nand: add ONFI timing mode to nand_timings converter
  of: mtd: add NAND timing mode retrieval support
  of: mtd: add documentation for the ONFI NAND timing mode property
  mtd: nand: add sunxi NAND flash controller support
  mtd: nand: add sunxi NFC dt bindings doc
  ARM: dt/sunxi: add NFC node to Allwinner A20 SoC
  ARM: dt/sunxi: add A20 NAND controller pin definitions
  ARM: sunxi/dt: enable NAND on cubietruck board

 Documentation/devicetree/bindings/mtd/nand.txt     |    8 +
 .../devicetree/bindings/mtd/sunxi-nand.txt         |   48 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   17 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   91 ++
 drivers/mtd/nand/Kconfig                           |    6 +
 drivers/mtd/nand/Makefile                          |    3 +-
 drivers/mtd/nand/nand_timings.c                    |  248 ++++
 drivers/mtd/nand/sunxi_nand.c                      | 1276 ++++++++++++++++++++
 drivers/of/of_mtd.c                                |   19 +
 include/linux/mtd/nand.h                           |   53 +
 include/linux/of_mtd.h                             |    8 +
 11 files changed, 1776 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/sunxi-nand.txt
 create mode 100644 drivers/mtd/nand/nand_timings.c
 create mode 100644 drivers/mtd/nand/sunxi_nand.c

-- 
1.7.9.5
