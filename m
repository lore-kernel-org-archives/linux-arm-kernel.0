From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 10:19:16 +0100
Subject: [GIT PULL] Nomadik devicetree and cleanups
Message-ID: <CACRpkdZM8+6QaGrRtCCMWoZQO23uej7JDr1xz2zG7TtwQ7Ngqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

This patch series converts the Nomadik to use Device Tree.

Changes outside of the subsystem are constrained to pinctrl (my subsystem
and thus OK:ed) and a oneline in drivers/mtd/nand/fsmc_nand.c adding
a new compatible value.

The MTD maintainers have had time enough to ACK that oneliner and it
shouldn't be a big issue, so:

Please pull this into your tree.

Yours,
Linus Walleij


The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-devicetree

for you to fetch changes up to bf82c67edcc8751903bdd7e45626c47cd2cc7834:

  ARM: nomadik: get rid of <mach/hardware.h> (2013-01-22 08:45:36 +0100)

----------------------------------------------------------------
This patch set converts the Nomadik (mach-nomadik) to
Device Tree and delete the old board files, paving the
road for single zImage.

----------------------------------------------------------------
Linus Walleij (11):
      ARM: nomadik: move last custom calls to pinctrl
      ARM: nomadik: initial devicetree support
      ARM: nomadik: move pin maps to cpu file
      ARM: nomadik: move remaining PrimeCells to device tree
      ARM: nomadik: add FSMC NAND
      ARM: nomadik: move GPIO and pinctrl to device tree
      ARM: nomadik: convert SMSC91x ethernet to device tree
      ARM: nomadik: migrate MMC/SD card support to device tree
      ARM: nomadik: add I2C devices to the device tree
      ARM: nomadik: delete old board files
      ARM: nomadik: get rid of <mach/hardware.h>

 .../devicetree/bindings/arm/ste-nomadik.txt        |  27 ++
 .../devicetree/bindings/mtd/fsmc-nand.txt          |   2 +-
 arch/arm/Kconfig                                   |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |  30 ++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi         | 256 ++++++++++++++
 arch/arm/mach-nomadik/Kconfig                      |  10 +-
 arch/arm/mach-nomadik/Makefile                     |   6 -
 arch/arm/mach-nomadik/board-nhk8815.c              | 359 --------------------
 arch/arm/mach-nomadik/cpu-8815.c                   | 370 +++++++++++++++------
 arch/arm/mach-nomadik/cpu-8815.h                   |   4 -
 arch/arm/mach-nomadik/i2c-8815nhk.c                |  88 -----
 arch/arm/mach-nomadik/include/mach/hardware.h      |  90 -----
 arch/arm/mach-nomadik/include/mach/irqs.h          |   2 -
 arch/arm/mach-nomadik/include/mach/uncompress.h    |   1 -
 drivers/mtd/nand/fsmc_nand.c                       |   1 +
 drivers/pinctrl/pinctrl-nomadik.c                  |   4 +
 17 files changed, 601 insertions(+), 652 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ste-nomadik.txt
 create mode 100644 arch/arm/boot/dts/ste-nomadik-s8815.dts
 create mode 100644 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
 delete mode 100644 arch/arm/mach-nomadik/board-nhk8815.c
 delete mode 100644 arch/arm/mach-nomadik/cpu-8815.h
 delete mode 100644 arch/arm/mach-nomadik/i2c-8815nhk.c
 delete mode 100644 arch/arm/mach-nomadik/include/mach/hardware.h
