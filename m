From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 11 Mar 2018 21:18:56 +0100
Subject: [GIT PULL] pxa for v4.17
Message-ID: <871sgq5psf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.17. This one is a bit outstanding, as I was
expecting conflicts with the MTD tree from Boris, which was merged into my tree
from one of his imutable branches. I this is an issue, tell me and I'll query
another pull without this merge commit.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.17

for you to fetch changes up to 0b8129278fdc30fa3281f435db419ab2d610085b:

  Merge tag 'nand/pxa3xx-removal' of git://git.infradead.org/linux-mtd into pxa/for-next (2018-03-07 14:22:29 +0100)

----------------------------------------------------------------
This is the pxa changes for v4.17 cycle :
 - minor changes for property API
 - clock API fix for ULPI driver warning

It exceptionally contains a merge from the mtd tree from Boris
to prevent any merge conflicts in the PXA tree.

----------------------------------------------------------------
Andy Shevchenko (1):
      ARM: pxa/raumfeld: use PROPERTY_ENTRY_U32() directly

Igor Grinberg (3):
      ARM: pxa: fix static checker warning in pxa3xx-ulpi
      ARM: pxa: cm-x300: remove inline directive
      ARM: pxa: ulpi: fix ulpi timeout and slowpath warn

Miquel Raynal (6):
      mtd: nand: use Marvell reworked NAND controller driver with all platforms
      mtd: nand: remove deprecated pxa3xx_nand driver
      mtd: nand: remove useless fields from pxa3xx NAND platform data
      dt-bindings: mtd: remove pxa3xx NAND controller documentation
      arm: dts: pxa: use reworked NAND controller driver
      MAINTAINERS: remove entry for deleted pxa3xx_nand driver

Robert Jarzmik (1):
      Merge tag 'nand/pxa3xx-removal' of git://git.infradead.org/linux-mtd into pxa/for-next

 .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   50 -
 MAINTAINERS                                        |    6 -
 arch/arm/boot/dts/pxa3xx.dtsi                      |    6 +-
 arch/arm/configs/cm_x300_defconfig                 |    2 +-
 arch/arm/configs/pxa3xx_defconfig                  |    3 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 arch/arm/configs/raumfeld_defconfig                |    2 +-
 arch/arm/mach-mmp/aspenite.c                       |    6 +-
 arch/arm/mach-mmp/ttc_dkb.c                        |    9 +-
 arch/arm/mach-pxa/cm-x300.c                        |   14 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |    8 +-
 arch/arm/mach-pxa/colibri.h                        |    2 +-
 arch/arm/mach-pxa/littleton.c                      |   10 +-
 arch/arm/mach-pxa/mxm8x10.c                        |   10 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c                    |    6 +-
 arch/arm/mach-pxa/raumfeld.c                       |   12 +-
 arch/arm/mach-pxa/zylonite.c                       |   10 +-
 drivers/mtd/nand/Kconfig                           |   11 -
 drivers/mtd/nand/Makefile                          |    1 -
 drivers/mtd/nand/marvell_nand.c                    |    3 +-
 drivers/mtd/nand/pxa3xx_nand.c                     | 2105 --------------------
 include/linux/platform_data/mtd-nand-pxa3xx.h      |   43 +-
 22 files changed, 55 insertions(+), 2266 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
 delete mode 100644 drivers/mtd/nand/pxa3xx_nand.c

-- 
Robert
