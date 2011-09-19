From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 19 Sep 2011 19:36:35 +0900
Subject: [GIT PULL] Samsung cleanup for v3.2
Message-ID: <001901cc76b8$018d4fc0$04a7ef40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This is Samsung cleanup for v3.2.

Please pull from:
  git://github.com/kgene/linux-samsung.git next-samsung-cleanup

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://github.com/kgene/linux-samsung.git next-samsung-cleanup

Abhilash Kesavan (1):
      ARM: S5PV210: Remove unnecessary symbol for PM

Banajit Goswami (1):
      ARM: SAMSUNG: Consolidate common function to set SDHCI plat data

Heiko Stuebner (2):
      ARM: S3C24XX: Remove hw_addr from s3c24xx dma channel declarations
      ARM: S3C24XX: Remove s3c24xx_dma_addr definition

Jonghwan Choi (1):
      ARM: S5P: Remove duplicate kdiv calculation

Kukjin Kim (6):
      ARM: EXYNOS4: Turn the mach-smdkc210.c into mach-smdv310.c
      Merge branch 'next/topic-cleanup-dma' into next-samsung-cleanup
      ARM: S3C24XX: remove unused gpio codes
      Merge branch 'next/topic-cleanup-smdkv310' into next-samsung-cleanup
      ARM: SAMSUNG: Move map header file into plat-samsung
      Merge branch 'next/topic-plat-samsung-1' into next-samsung-cleanup

Mark Brown (1):
      ARM: S3C64XX: Remove unused CPU devices for Cragganmore

Naveen Krishna Chatradhi (1):
      ARM: SAMSUNG: Remove unnecessary duplication of plat_data on TSADC

 arch/arm/mach-exynos4/Kconfig                      |   17 +-
 arch/arm/mach-exynos4/Makefile                     |    2 +-
 arch/arm/mach-exynos4/mach-smdkc210.c              |  309
--------------------
 arch/arm/mach-exynos4/mach-smdkv310.c              |   78 +++++
 arch/arm/mach-s3c2410/Kconfig                      |    6 -
 arch/arm/mach-s3c2410/Makefile                     |    1 -
 arch/arm/mach-s3c2410/dma.c                        |   14 -
 arch/arm/mach-s3c2410/gpio.c                       |   72 -----
 arch/arm/mach-s3c2410/include/mach/map.h           |   52 +++-
 arch/arm/mach-s3c2412/Kconfig                      |    1 -
 arch/arm/mach-s3c2412/Makefile                     |    1 -
 arch/arm/mach-s3c2412/dma.c                        |   18 --
 arch/arm/mach-s3c2412/gpio.c                       |   62 ----
 arch/arm/mach-s3c2440/Kconfig                      |    2 -
 arch/arm/mach-s3c2440/dma.c                        |   17 -
 arch/arm/mach-s3c2443/dma.c                        |   27 --
 arch/arm/mach-s3c64xx/include/mach/map.h           |    9 +-
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    3 -
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    8 +-
 arch/arm/mach-s3c64xx/mach-real6410.c              |    8 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    8 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    8 +-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    8 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    8 +-
 arch/arm/mach-s5pv210/Kconfig                      |    6 -
 arch/arm/mach-s5pv210/Makefile                     |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    8 +-
 arch/arm/plat-s3c24xx/include/plat/map.h           |  100 -------
 arch/arm/plat-s5p/include/plat/pll.h               |    1 -
 arch/arm/plat-samsung/dev-hsmmc.c                  |   19 +--
 arch/arm/plat-samsung/dev-hsmmc1.c                 |   19 +--
 arch/arm/plat-samsung/dev-hsmmc2.c                 |   19 +--
 arch/arm/plat-samsung/dev-hsmmc3.c                 |   19 +--
 arch/arm/plat-samsung/dev-ts.c                     |    9 +
 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h   |    6 -
 arch/arm/plat-samsung/include/plat/map-s3c.h       |   84 ++++++
 .../include/plat/map-s5p.h                         |    6 +-
 arch/arm/plat-samsung/include/plat/sdhci.h         |    7 +
 arch/arm/plat-samsung/platformdata.c               |   22 ++
 39 files changed, 264 insertions(+), 802 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/mach-smdkc210.c
 delete mode 100644 arch/arm/mach-s3c2410/gpio.c
 delete mode 100644 arch/arm/mach-s3c2412/gpio.c
 delete mode 100644 arch/arm/plat-s3c24xx/include/plat/map.h
 create mode 100644 arch/arm/plat-samsung/include/plat/map-s3c.h
 rename arch/arm/{plat-s5p => plat-samsung}/include/plat/map-s5p.h (94%)
