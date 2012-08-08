From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  8 Aug 2012 12:54:06 +0300
Subject: [PATCH 0/4] ASoC/OMAP: ASoC machine driver for simple SoC with twl4030
Message-ID: <1344419650-5389-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Create new unified ASoC machine driver (with DT support) for boards using simple
configuration for audio and using the twl4030 codec.
This driver will replace the following machine drivers (since they are basically
the same):
igep0020, omap3beagle, omap3evm and overo.

This series will switch the boards I can identify to use the new unified ASoC
machine driver.

Changes under arch/arm/mach-omap2/ are trivial, I don't expect merge issues
later. If it is OK for the maintainers I would like this to go via audio tree
(with the McBSP and the twl4030-audio stack DT support).

The series has been tested on BeagleBoard (with the McBSP and twl4030-audio DT
support).

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: omap-twl4030: Simple machine driver for TI SoC with twl4030
    codec
  ARM: OMAP: twl-common: Add helper function to register the
    omap-twl4030 audio driver
  ARM: OMAP3: Switch to use the unified audio driver (omap-twl4030) for
    selected boards
  ASoC: Remove obsolete OMAP3 machine drivers

 .../devicetree/bindings/sound/omap-twl4030.txt     |   19 ++
 arch/arm/mach-omap2/board-cm-t35.c                 |    1 +
 arch/arm/mach-omap2/board-devkit8000.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c               |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    1 +
 arch/arm/mach-omap2/board-omap3evm.c               |    1 +
 arch/arm/mach-omap2/board-overo.c                  |    1 +
 arch/arm/mach-omap2/twl-common.c                   |   28 +++
 arch/arm/mach-omap2/twl-common.h                   |    2 +
 include/linux/platform_data/omap-twl4030.h         |   33 +++
 sound/soc/omap/Kconfig                             |   48 ++---
 sound/soc/omap/Makefile                            |   10 +-
 sound/soc/omap/igep0020.c                          |  120 -----------
 sound/soc/omap/omap-twl4030.c                      |  219 ++++++++++++++++++++
 sound/soc/omap/omap3beagle.c                       |  150 -------------
 sound/soc/omap/omap3evm.c                          |  118 -----------
 sound/soc/omap/overo.c                             |  122 -----------
 17 files changed, 322 insertions(+), 553 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 include/linux/platform_data/omap-twl4030.h
 delete mode 100644 sound/soc/omap/igep0020.c
 create mode 100644 sound/soc/omap/omap-twl4030.c
 delete mode 100644 sound/soc/omap/omap3beagle.c
 delete mode 100644 sound/soc/omap/omap3evm.c
 delete mode 100644 sound/soc/omap/overo.c

-- 
1.7.8.6
