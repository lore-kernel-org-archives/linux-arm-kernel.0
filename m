From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 14 Dec 2011 10:15:57 -0500
Subject: [PATCH V3 0/6] SPI platform device consolidation
Message-ID: <1323875763-21197-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI platform devices are defined in respective machine folder of
Samsung S3C64XX and S5P series SoCs.This patchset moves S3C64XX
and S5P series of SPI platform devices to a common place plat-samsung.
This patchset also creates SPI setup files for GPIO configurations and
platform data initialization.

V2 Changes:
Platform data initialized in a centralized setup file as suggested-by
Mark Brown
SPI Controller number is added in SPI controller defining structure.

V3 Changes:
Reverted the SPI Controller number addition because device tree doesn't support
enumeration using device instance number.

Padmavathi Venna (6):
  ARM: SAMSUNG: Consolidation of SPI platform devices to plat-samsung
  ARM: S3C64XX: Modified files for SPI consolidation work
  ARM: S5PC100: Modified files for SPI consolidation work
  ARM: S5P64X0: Modified files for SPI consolidation work
  ARM: S5PV210: Modified files for SPI consolidation work
  ARM: S3C64XX: Modified according to SPI consolidation work.

 arch/arm/mach-s3c64xx/Kconfig                    |    8 +-
 arch/arm/mach-s3c64xx/Makefile                   |    2 +-
 arch/arm/mach-s3c64xx/dev-spi.c                  |  173 -----------------
 arch/arm/mach-s3c64xx/include/mach/map.h         |    2 +
 arch/arm/mach-s3c64xx/setup-spi.c                |   45 +++++
 arch/arm/mach-s5p64x0/Kconfig                    |    7 +-
 arch/arm/mach-s5p64x0/Makefile                   |    2 +-
 arch/arm/mach-s5p64x0/dev-spi.c                  |  218 ---------------------
 arch/arm/mach-s5p64x0/include/mach/map.h         |    3 +
 arch/arm/mach-s5p64x0/setup-spi.c                |   55 ++++++
 arch/arm/mach-s5pc100/Kconfig                    |    5 +
 arch/arm/mach-s5pc100/Makefile                   |    2 +-
 arch/arm/mach-s5pc100/dev-spi.c                  |  220 ----------------------
 arch/arm/mach-s5pc100/include/mach/map.h         |    3 +
 arch/arm/mach-s5pc100/setup-spi.c                |   65 +++++++
 arch/arm/mach-s5pv210/Kconfig                    |    5 +
 arch/arm/mach-s5pv210/Makefile                   |    2 +-
 arch/arm/mach-s5pv210/dev-spi.c                  |  169 -----------------
 arch/arm/mach-s5pv210/include/mach/map.h         |    2 +
 arch/arm/mach-s5pv210/setup-spi.c                |   51 +++++
 arch/arm/plat-samsung/Kconfig                    |   14 ++-
 arch/arm/plat-samsung/devs.c                     |  127 +++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h        |    8 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   22 ++-
 24 files changed, 409 insertions(+), 801 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-spi.c
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi.c
 delete mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi.c
 delete mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi.c
 delete mode 100644 arch/arm/mach-s5pv210/dev-spi.c
 create mode 100644 arch/arm/mach-s5pv210/setup-spi.c
