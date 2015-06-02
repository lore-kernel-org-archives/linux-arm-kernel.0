From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  2 Jun 2015 19:32:24 +0200
Subject: [PATCH 0/7] ARM: berlin: nand support
Message-ID: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series was part of a bigger one[1], which was split into smaller
ones as asked by Ezequiel[2].

The support is added into the existing pxa3xx nand controller. Some
additions were done in order to get this controller working:
- Support for a non mandatory ECC clock has been added.
- The Berlin nand controller needs to poll the status register.
- Sequences of commands are quite different in order to perform write
  operation.

Based on [3].

[1] https://lkml.org/lkml/2015/5/11/495
[2] https://lkml.org/lkml/2015/5/16/309
[3] https://lkml.org/lkml/2015/6/2/471

Antoine Tenart (7):
  mtd: pxa3xx_nand: add a non mandatory ECC clock
  Documentation: bindings: document the clocks for pxa3xx-nand
  mtd: pxa3xx_nand: add support for the Marvell Berlin nand controller
  Documentation: bindings: add the Berlin nand controller compatible
  mtd: nand: let Marvell Berlin SoCs select the pxa3xx driver
  ARM: berlin: add BG2Q node for the nand
  ARM: berlin: enable flash on the BG2Q DMP

 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   5 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts         |  25 +++
 arch/arm/boot/dts/berlin2q.dtsi                    |  13 ++
 drivers/mtd/nand/Kconfig                           |   4 +-
 drivers/mtd/nand/pxa3xx_nand.c                     | 214 +++++++++++++++++++--
 5 files changed, 240 insertions(+), 21 deletions(-)

-- 
2.4.2
