From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 09 Sep 2016 19:27:45 +0200
Subject: [GIT PULL] pxa for v4.9
Message-ID: <87zinhf0fi.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa 4.8 cycle. The diffstat should look
nice as the legacy dma code is removed at last.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.9

for you to fetch changes up to 9ba63e3cc849cdaf3b675c47cc51fe35419e5117:

  ARM: pxa: pxa_cplds: fix interrupt handling (2016-09-09 18:09:53 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.9 cycle.

This cycle is covering :
 - the removal of the legacy DMA API
   This is the major contributor to the negative diffstat, as dmaengine
   have taken over in this area.
 - IDE subsystem defconfig fixes
 - preparation for pxa25x to be device-tree compliant
 - various irq related fixes

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (4):
      arm: colibri_pxa270_defconfig: disable IDE subsystem
      arm: lpda270_defconfig: disable IDE subsystem
      arm: pxa255-idp_defconfig: disable IDE subsystem
      arm: trizeps4_defconfig: disable IDE subsystem

Markus Elfring (1):
      ARM: pxa: Use kmalloc_array() in pxa_pm_init()

Petr Cvek (1):
      ARM: pxa: magician: Remove duplicated I2C pins declaration

Robert Jarzmik (7):
      ARM: pxa: remove devicetree boards from pxa_defconfig
      ARM: pxa: remove platform dma code
      ARM: pxa: prepare pxa25x interrupts for device-tree platforms
      ARM: pxa: add pxa25x device-tree support
      ARM: pxa: fix GPIO double shifts
      ARM: pxa: remove irq init from dt machines
      ARM: pxa: pxa_cplds: fix interrupt handling

 arch/arm/configs/colibri_pxa270_defconfig |   1 -
 arch/arm/configs/lpd270_defconfig         |   1 -
 arch/arm/configs/pxa255-idp_defconfig     |   1 -
 arch/arm/configs/pxa_defconfig            |   2 -
 arch/arm/configs/trizeps4_defconfig       |   2 -
 arch/arm/mach-pxa/Kconfig                 |  11 +
 arch/arm/mach-pxa/Makefile                |   3 +-
 arch/arm/mach-pxa/corgi_pm.c              |  13 +-
 arch/arm/mach-pxa/devices.h               |   1 +
 arch/arm/mach-pxa/generic.h               |   2 -
 arch/arm/mach-pxa/include/mach/dma.h      |   1 -
 arch/arm/mach-pxa/magician.c              |   4 -
 arch/arm/mach-pxa/pm.c                    |   5 +-
 arch/arm/mach-pxa/pxa-dt.c                |  35 ++-
 arch/arm/mach-pxa/pxa25x.c                |  26 +-
 arch/arm/mach-pxa/pxa27x.c                |  14 +-
 arch/arm/mach-pxa/pxa3xx.c                |  11 +-
 arch/arm/mach-pxa/pxa_cplds_irqs.c        |  24 +-
 arch/arm/mach-pxa/sharpsl_pm.c            |   2 +-
 arch/arm/mach-pxa/sharpsl_pm.h            |   2 +-
 arch/arm/mach-pxa/spitz_pm.c              |   9 +-
 arch/arm/plat-pxa/Makefile                |   2 -
 arch/arm/plat-pxa/dma.c                   | 386 ------------------------------
 arch/arm/plat-pxa/include/plat/dma.h      | 100 --------
 24 files changed, 95 insertions(+), 563 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/dma.c
 delete mode 100644 arch/arm/plat-pxa/include/plat/dma.h

Cheers.

-- 
Robert
