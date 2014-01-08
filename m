From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed,  8 Jan 2014 15:21:55 +0100
Subject: [RFC PATCH 0/9] mtd: nand: add sunxi NAND Flash Controller support
Message-ID: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series add the sunxi NFC support with up to 8 NAND chip connected.
I'm still in the early stages drivers development and some key features are
missing, but it's usable (I tested it on the cubietruck board).

Here's what's missing:
 - HW ECC support
 - DMA support
 - HW randomization support
 - many more improvements

This series depends on Emilio's patch series implementing mod0 clks
(http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185478.html)
+ an other patch not yet posted
(http://git.elopez.com.ar/linux/commits/5b4eb3ac406b9c98965714d40e8dd6da943d1ab0)


Best Regards,

Boris

Boris BREZILLON (9):
  mtd: nand: retrieve ECC requirements from Hynix READ ID byte 4
  mtd: nand: define struct nand_timings
  of: mtd: add NAND timings retrieval support
  of: mtd: add NAND timings bindings documentation
  mtd: nand: add sunxi NFC support
  mtd: nand: add sunxi NFC dt bindings doc
  ARM: dt/sunxi: add NFC node to Allwinner A20 SoC
  ARM: dt/sunxi: add NFC pinctrl pin definitions
  ARM: sunxi/dt: enable NAND on cubietruck board

 Documentation/devicetree/bindings/mtd/nand.txt     |   34 +
 .../devicetree/bindings/mtd/sunxi-nand.txt         |   71 ++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   33 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   35 +
 drivers/mtd/nand/Kconfig                           |    6 +
 drivers/mtd/nand/Makefile                          |    1 +
 drivers/mtd/nand/nand_base.c                       |   37 ++
 drivers/mtd/nand/sunxi_nfc.c                       |  700 ++++++++++++++++++++
 drivers/of/of_mtd.c                                |   47 ++
 include/linux/mtd/nand.h                           |   44 ++
 include/linux/of_mtd.h                             |    9 +
 11 files changed, 1017 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/sunxi-nand.txt
 create mode 100644 drivers/mtd/nand/sunxi_nfc.c

-- 
1.7.9.5
