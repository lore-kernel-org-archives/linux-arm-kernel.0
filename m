From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Dec 2011 10:00:52 +0900
Subject: [GIT PULL] Samsung cleanup-spi for v3.3
Message-ID: <088001ccc1d7$7c0da460$7428ed20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the samsung-cleanup-spi for v3.3.
It depends on samsung-devel-spi3 branch...

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit a153e31abb01484d0088ac28425dc98204848ad4:

  ARM: SAMSUNG: Remove SPI bus clocks from platform data (2011-12-23
10:10:46 +0900)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next-samsung-cleanup-spi4

Padmavathi Venna (6):
      ARM: SAMSUNG: Consolidation of SPI platform devices to plat-samsung
      ARM: S3C64XX: Modified files for SPI consolidation work
      ARM: S5PC100: Modified files for SPI consolidation work
      ARM: S5P64X0: Modified files for SPI consolidation work
      ARM: S5PV210: Modified files for SPI consolidation work
      ARM: S3C64XX: Modified according to SPI consolidation work

 arch/arm/mach-s3c64xx/Kconfig                    |    8 +-
 arch/arm/mach-s3c64xx/Makefile                   |    2 +-
 arch/arm/mach-s3c64xx/dev-spi.c                  |  173 -----------------
 arch/arm/mach-s3c64xx/include/mach/map.h         |    2 +
 arch/arm/mach-s3c64xx/setup-spi.c                |   45 +++++
 arch/arm/mach-s5p64x0/Kconfig                    |    7 +-
 arch/arm/mach-s5p64x0/Makefile                   |    2 +-
 arch/arm/mach-s5p64x0/dev-spi.c                  |  218
---------------------
 arch/arm/mach-s5p64x0/include/mach/map.h         |    2 +
 arch/arm/mach-s5p64x0/setup-spi.c                |   55 ++++++
 arch/arm/mach-s5pc100/Kconfig                    |    5 +
 arch/arm/mach-s5pc100/Makefile                   |    2 +-
 arch/arm/mach-s5pc100/dev-spi.c                  |  220
----------------------
 arch/arm/mach-s5pc100/include/mach/map.h         |    3 +
 arch/arm/mach-s5pc100/setup-spi.c                |   65 +++++++
 arch/arm/mach-s5pv210/Kconfig                    |    5 +
 arch/arm/mach-s5pv210/Makefile                   |    2 +-
 arch/arm/mach-s5pv210/dev-spi.c                  |  169 -----------------
 arch/arm/mach-s5pv210/include/mach/map.h         |    2 +
 arch/arm/mach-s5pv210/setup-spi.c                |   51 +++++
 arch/arm/plat-samsung/Kconfig                    |   16 ++-
 arch/arm/plat-samsung/devs.c                     |  127 +++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h        |    8 +-
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   22 ++-
 24 files changed, 409 insertions(+), 802 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-spi.c
 create mode 100644 arch/arm/mach-s3c64xx/setup-spi.c
 delete mode 100644 arch/arm/mach-s5p64x0/dev-spi.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-spi.c
 delete mode 100644 arch/arm/mach-s5pc100/dev-spi.c
 create mode 100644 arch/arm/mach-s5pc100/setup-spi.c
 delete mode 100644 arch/arm/mach-s5pv210/dev-spi.c
 create mode 100644 arch/arm/mach-s5pv210/setup-spi.c
