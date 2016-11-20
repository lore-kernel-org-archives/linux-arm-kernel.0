From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 Nov 2016 18:37:34 -0800
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20161120023734.GA24493@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Actual current version this time. Had an old file with the generated pull
request around in my directory on this machine.

Thanks,

-Olof

The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:

  Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 9883ed4433b358528e1a41e56ae01a4b02a1dde3:

  Merge tag 'sunxi-fixes-for-4.9' of https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux into fixes (2016-11-17 16:43:38 -0800)

----------------------------------------------------------------
ARM: SoC fixes for v4.9-rc

Again a set of smaller fixes across several platforms (OMAP, Marvell,
Allwinner, i.MX, etc).

A handful of typo fixes and smaller missing contents from device trees,
with some tweaks to OMAP mach files to deal with CPU feature print
misformatting, potential NULL ptr dereference and one setup issue
with UARTs.

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: omap3: Fix memory node in Torpedo board
      ARM: omap3: Add missing memory node in SOM-LV

Colin Ian King (1):
      ARM: OMAP2+: PRM: initialize en_uart4_mask and grpsel_uart4_mask

C?dric Le Goater (1):
      ipmi/bt-bmc: change compatible node to 'aspeed, ast2400-ibt-bmc'

Dave Gerlach (1):
      ARM: AM43XX: Select OMAP_INTERCONNECT in Kconfig

Fabio Estevam (1):
      ARM: dts: imx53-qsb: Fix regulator constraints

Gregory CLEMENT (1):
      arm64: dts: marvell: Fix typo in label name on Armada 37xx

H. Nikolaus Schaller (4):
      dts: omap5: board-common: add phandle to reference Palmas gpadc
      dts: omap5: board-common: enable twl6040 headset jack detection
      ASoC: omap-abe-twl6040: fix typo in bindings documentation
      ARM: dts: omap5: board-common: fix wrong SMPS6 (VDD-DDR3) voltage

Icenowy Zheng (1):
      ARM: dts: sun8i: fix the pinmux for UART1

Loic Pallardy (1):
      ARM: dts: STiH410-b2260: Fix typo in spi0 chipselect definition

Marcin Wojtas (2):
      arm64: dts: marvell: fix clocksource for CP110 slave SPI0
      arm64: dts: marvell: add unique identifiers for Armada A8k SPI controllers

Nicolae Rosia (1):
      ARM: OMAP2+: avoid NULL pointer dereference

Olof Johansson (5):
      Merge tag 'mvebu-fixes-4.9-1' of git://git.infradead.org/linux-mvebu into fixes
      Merge tag 'omap-for-v4.9/fixes-for-rc-cycle' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.9-2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'sti-dt-for-v4.9-rc' of git://git.kernel.org/.../pchotard/sti into fixes
      Merge tag 'sunxi-fixes-for-4.9' of https://git.kernel.org/.../mripard/linux into fixes

Tony Lindgren (1):
      ARM: OMAP3: Fix formatting of features printed

 ...eed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt} |  4 ++--
 .../devicetree/bindings/sound/omap-abe-twl6040.txt       |  2 +-
 arch/arm/boot/dts/imx53-qsb.dts                          | 14 +++++++-------
 arch/arm/boot/dts/logicpd-som-lv.dtsi                    |  5 +++++
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi               |  4 ++--
 arch/arm/boot/dts/omap5-board-common.dtsi                |  7 ++++---
 arch/arm/boot/dts/stih410-b2260.dts                      |  2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                     |  4 ++++
 arch/arm/mach-omap2/Kconfig                              |  1 +
 arch/arm/mach-omap2/id.c                                 | 16 +++++++++++-----
 arch/arm/mach-omap2/prm3xxx.c                            |  3 +++
 arch/arm/mach-omap2/voltage.c                            |  6 ++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi             |  4 ++--
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi      |  6 +++---
 drivers/char/ipmi/bt-bmc.c                               |  4 ++--
 15 files changed, 54 insertions(+), 28 deletions(-)
 rename Documentation/devicetree/bindings/ipmi/{aspeed,ast2400-bt-bmc.txt => aspeed,ast2400-ibt-bmc.txt} (85%)
