From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:22:11 +0900
Subject: [GIT PULL] Renesas ARM Based SoC sh7372 SoC Removal Updates for v4.1
Message-ID: <cover.1424931560.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC sh7372 SoC removal updates for v4.1.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh7372-soc-removal-for-v4.1

for you to fetch changes up to c6535e1e0361157ea073b57b626d0611b7c4c7a0:

  Documentation: Remove ZBOOT MMC/SDHI utility and docs (2015-02-24 06:45:25 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC sh7372 SoC Removal Updates for v4.1

* Remove the sh7372 SoC and its mackerel board

----------------------------------------------------------------
Magnus Damm (12):
      ARM: shmobile: mackerel: Remove ZBOOT code
      ARM: shmobile: mackerel: Remove Legacy C board code
      ARM: shmobile: mackerel dts: Remove Legacy DTS file
      ARM: shmobile: mackerel: Remove DT binding documentation
      ARM: shmobile: mackerel: Remove mach-type entry
      ARM: shmobile: mackerel: Remove defconfig
      ARM: shmobile: mackerel: Remove from MAINTAINERS
      ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
      ARM: shmobile: sh7372: Remove Legacy C SoC code
      ARM: shmobile: sh7372: Remove DT binding documentation
      ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
      Documentation: Remove ZBOOT MMC/SDHI utility and docs

 Documentation/Makefile                             |    2 +-
 Documentation/arm/Makefile                         |    1 -
 Documentation/arm/SH-Mobile/Makefile               |    7 -
 Documentation/arm/SH-Mobile/vrl4.c                 |  170 ---
 Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt    |   29 -
 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt     |   42 -
 Documentation/devicetree/bindings/arm/shmobile.txt |    4 -
 MAINTAINERS                                        |    1 -
 arch/arm/Kconfig                                   |   29 -
 arch/arm/Kconfig.debug                             |    7 +-
 arch/arm/boot/compressed/Makefile                  |   15 -
 arch/arm/boot/compressed/head-shmobile.S           |   30 -
 arch/arm/boot/compressed/mmcif-sh7372.c            |   88 --
 arch/arm/boot/compressed/sdhi-sh7372.c             |   95 --
 arch/arm/boot/compressed/sdhi-shmobile.c           |  449 ------
 arch/arm/boot/compressed/sdhi-shmobile.h           |   11 -
 arch/arm/boot/dts/Makefile                         |    1 -
 arch/arm/boot/dts/sh7372-mackerel.dts              |   26 -
 arch/arm/boot/dts/sh7372.dtsi                      |   35 -
 arch/arm/configs/mackerel_defconfig                |  157 --
 arch/arm/mach-shmobile/Kconfig                     |   16 -
 arch/arm/mach-shmobile/Makefile                    |    6 -
 arch/arm/mach-shmobile/Makefile.boot               |    1 -
 arch/arm/mach-shmobile/board-mackerel.c            | 1522 --------------------
 arch/arm/mach-shmobile/clock-sh7372.c              |  620 --------
 arch/arm/mach-shmobile/common.h                    |    1 -
 arch/arm/mach-shmobile/entry-intc.S                |   54 -
 .../mach-shmobile/include/mach/head-mackerel.txt   |   93 --
 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h |   38 -
 arch/arm/mach-shmobile/include/mach/mmc.h          |   16 -
 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h  |   21 -
 arch/arm/mach-shmobile/include/mach/sdhi.h         |   16 -
 arch/arm/mach-shmobile/include/mach/zboot.h        |    5 +-
 arch/arm/mach-shmobile/intc-sh7372.c               |  672 ---------
 arch/arm/mach-shmobile/pm-sh7372.c                 |  549 -------
 arch/arm/mach-shmobile/setup-sh7372.c              | 1016 -------------
 arch/arm/mach-shmobile/sh7372.h                    |   84 --
 arch/arm/mach-shmobile/sleep-sh7372.S              |   98 --
 arch/arm/tools/mach-types                          |    1 -
 39 files changed, 5 insertions(+), 6023 deletions(-)
 delete mode 100644 Documentation/arm/Makefile
 delete mode 100644 Documentation/arm/SH-Mobile/Makefile
 delete mode 100644 Documentation/arm/SH-Mobile/vrl4.c
 delete mode 100644 Documentation/arm/SH-Mobile/zboot-rom-mmcif.txt
 delete mode 100644 Documentation/arm/SH-Mobile/zboot-rom-sdhi.txt
 delete mode 100644 arch/arm/boot/compressed/mmcif-sh7372.c
 delete mode 100644 arch/arm/boot/compressed/sdhi-sh7372.c
 delete mode 100644 arch/arm/boot/compressed/sdhi-shmobile.c
 delete mode 100644 arch/arm/boot/compressed/sdhi-shmobile.h
 delete mode 100644 arch/arm/boot/dts/sh7372-mackerel.dts
 delete mode 100644 arch/arm/boot/dts/sh7372.dtsi
 delete mode 100644 arch/arm/configs/mackerel_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-mackerel.c
 delete mode 100644 arch/arm/mach-shmobile/clock-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/entry-intc.S
 delete mode 100644 arch/arm/mach-shmobile/include/mach/head-mackerel.txt
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmc-mackerel.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmc.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sdhi.h
 delete mode 100644 arch/arm/mach-shmobile/intc-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/pm-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/setup-sh7372.c
 delete mode 100644 arch/arm/mach-shmobile/sh7372.h
 delete mode 100644 arch/arm/mach-shmobile/sleep-sh7372.S
