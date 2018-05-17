From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 17 May 2018 18:38:43 +0530
Subject: [GIT PULL 1/3] DaVinci SoC updates for v4.18
Message-ID: <20180517130845.863-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.18/soc

for you to fetch changes up to ccfadbb759bed3cc40336e2c486e619e3bf8590b:

  Merge branch 'v4.18/nand-cs-simplification' into v4.18/soc (2018-05-02 15:04:15 +0530)

----------------------------------------------------------------
DaVinci SoC support updates for v4.18

Mainly contains patches to move NAND chipselect to platform data
(currently platform device id is being used). These patches have
been acked by NAND maintainer and because of the driver dependency
an immutable branch has been provided to Boris.

The other patch is to remove an unnecessary postcore_initcall() on
DM644x which is needed for common clock framework conversion.

----------------------------------------------------------------
Bartosz Golaszewski (12):
      mtd: rawnand: davinci: store the core chipselect number in platform data
      ARM: davinci: da830-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: da850-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm355-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm355-leopard: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm365-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm644x-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: mityomapl138: specify the chipselect in davinci_nand_pdata
      ARM: davinci: dm646x-evm: specify the chipselect in davinci_nand_pdata
      ARM: davinci: neuros-osd2: specify the chipselect in davinci_nand_pdata
      mtd: rawnand: davinci: stop using pdev->id as chipselect
      ARM: davinci: aemif: stop using pdev->id as nand chipselect

Sekhar Nori (2):
      ARM: davinci: dm644x: remove unnecessary postcore_initcall()
      Merge branch 'v4.18/nand-cs-simplification' into v4.18/soc

 arch/arm/mach-davinci/aemif.c               |  8 ++++----
 arch/arm/mach-davinci/board-da830-evm.c     |  1 +
 arch/arm/mach-davinci/board-da850-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm355-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm355-leopard.c |  1 +
 arch/arm/mach-davinci/board-dm365-evm.c     |  1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |  3 +++
 arch/arm/mach-davinci/board-dm646x-evm.c    |  1 +
 arch/arm/mach-davinci/board-mityomapl138.c  |  1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   |  3 +++
 arch/arm/mach-davinci/board-sffsdr.c        |  2 ++
 arch/arm/mach-davinci/davinci.h             |  1 +
 arch/arm/mach-davinci/dm644x.c              | 13 +++----------
 drivers/mtd/nand/raw/davinci_nand.c         |  6 +++---
 include/linux/platform_data/mtd-davinci.h   | 10 ++++++++++
 15 files changed, 36 insertions(+), 17 deletions(-)
