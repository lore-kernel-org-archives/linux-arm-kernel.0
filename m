From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Mar 2014 02:12:54 +0100
Subject: [GIT PULL] ux500 devicetree cleanups for v3.15, take two
Message-ID: <CACRpkdb4SgZgbgQ6m31LWmqTT7nskaR8yV4OXO9RmvgXhVZPCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

this is a set of cleanups building upon the already submitted cleanups
queued on the ux500/dt branch in the ARM SoC tree.

This kills of another three boardfile things with just constants so it's a
real nice step forward to finalizing ux500 as a DT-only platform.

Remaining cleanups are a few hardcoded DMA definitions related to
DMA (that I won't do until I can really test the result) and some MMC
stuff that first need proper DT support in the MMC subsystem.

This contains a u300 patch as well, as it is closely related to the same
ux500 patch and I do not plan to send any separate u300 pull request
for this kernel cycle.

So please pull this in!

Yours,
Linus Walleij


The following changes since commit 77ad9dfc2c7e3b5ce49efc5c0c215f7c36c91cf2:

  ARM: ux500: move last AB8505 set-up to DT (2014-02-04 20:50:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dt-v3.15-2

for you to fetch changes up to f864c46aae4cb6aed09e98615c427fcc4f1de104:

  mfd: dbx500/abx500: root out hardcoded IRQ assignments (2014-03-04
08:58:11 +0800)

----------------------------------------------------------------
A set of device tree-related cleanups for the ux500 platform:

- Rename SSP/SPI clocks to the name found in the hardware
  reference manual. (Also includes a rename in the U300
  device tree file.)

- Delete dead non-DT code.

- Drop now completely unused GPIO definition header file.

- Delete all hardcoded IRQ number assignments. This hits
  MFD a bit so the patch has been ACKed by Lee Jones from
  the MFD side.

----------------------------------------------------------------
Linus Walleij (6):
      ARM: ux500: switch SSP/SPI clock name to "SSPCLK"
      ARM: u300: switch SSP/SPI clock name to "SSPCLK"
      ARM: ux500: delete pointless DT config option
      ARM: ux500: skip GIC CPU and dist address checks
      ARM: ux500: drop a chunk of GPIO definitions
      mfd: dbx500/abx500: root out hardcoded IRQ assignments

 arch/arm/boot/dts/ste-dbx5x0.dtsi        |  12 +--
 arch/arm/boot/dts/ste-u300.dts           |   2 +-
 arch/arm/mach-ux500/Kconfig              |   5 --
 arch/arm/mach-ux500/board-mop500-audio.c |   1 -
 arch/arm/mach-ux500/board-mop500.h       |  69 -----------------
 arch/arm/mach-ux500/cpu-db8500.c         |   7 --
 arch/arm/mach-ux500/cpu.c                |  10 ---
 arch/arm/mach-ux500/irqs-board-mop500.h  |  55 --------------
 arch/arm/mach-ux500/irqs-db8500.h        | 125 -------------------------------
 arch/arm/mach-ux500/irqs.h               |  49 ------------
 drivers/mfd/ab8500-core.c                |  27 +++----
 drivers/mfd/db8500-prcmu.c               |  34 ++++++---
 include/linux/mfd/abx500/ab8500.h        |   2 -
 include/linux/mfd/dbx500-prcmu.h         |   2 -
 14 files changed, 43 insertions(+), 357 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/irqs-board-mop500.h
 delete mode 100644 arch/arm/mach-ux500/irqs-db8500.h
 delete mode 100644 arch/arm/mach-ux500/irqs.h
