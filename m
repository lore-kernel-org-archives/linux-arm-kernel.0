From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 16:37:44 +0000
Subject: [GIT PULL] arm-soc bug fixes
Message-ID: <201203061637.45150.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are all the fixes I got after sending the last pull request.
These fix mostly regressions on exynos, at91, pxa and ep93xx.
They are available in the 'fixes' branch or the 'fixes-3.3-rc7'
tag.

	Arnd

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-3.3-rc7

Arnd Bergmann (3):
      Merge branch 'at91-fixes' of git://github.com/at91linux/linux-at91 into fixes
      Merge branch 'v3.3-samsung-fixes-4' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge branch 'fixes' of git://github.com/hzhuang1/linux into fixes

Bartlomiej Zolnierkiewicz (1):
      ARM: EXYNOS: fix touchscreen IRQ setup on Universal C210 board

Gusakov Andrey (1):
      ARM: S3C24XX: DMA resume regression fix

H Hartley Sweeten (1):
      ARM: ep93xx: convert vision_ep9307 to MULTI_IRQ_HANDLER

Haojian Zhuang (3):
      ARM: pxa: add dummy clock for pxa25x and pxa27x
      ARM: pxa: remove duplicated registeration on pxa-gpio
      ARM: pxa: fix invalid mfp pin issue

Heiko Stuebner (1):
      ARM: S3C24XX: Fix restart on S3C2442

Joonyoung Shim (1):
      ARM: SAMSUNG: Fix memory size for hsotg

Nicolas Ferre (2):
      ARM: at91/dma: remove platform data from DMA controller
      ARM: at91/dma: DMA controller registering with DT support

 arch/arm/mach-at91/at91sam9g45_devices.c   |   19 ++++++++++---------
 arch/arm/mach-at91/at91sam9rl_devices.c    |    8 +-------
 arch/arm/mach-ep93xx/vision_ep9307.c       |    2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |    2 ++
 arch/arm/mach-pxa/generic.h                |    1 -
 arch/arm/mach-pxa/mfp-pxa2xx.c             |    7 +++++++
 arch/arm/mach-pxa/pxa25x.c                 |    2 +-
 arch/arm/mach-pxa/pxa27x.c                 |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                 |    1 -
 arch/arm/mach-pxa/pxa95x.c                 |    1 -
 arch/arm/mach-s3c2440/common.h             |    2 +-
 arch/arm/mach-s3c2440/mach-anubis.c        |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c     |    2 +-
 arch/arm/mach-s3c2440/mach-gta02.c         |    2 +-
 arch/arm/mach-s3c2440/mach-mini2440.c      |    2 +-
 arch/arm/mach-s3c2440/mach-nexcoder.c      |    2 +-
 arch/arm/mach-s3c2440/mach-osiris.c        |    2 +-
 arch/arm/mach-s3c2440/mach-rx1950.c        |    2 +-
 arch/arm/mach-s3c2440/mach-rx3715.c        |    2 +-
 arch/arm/mach-s3c2440/mach-smdk2440.c      |    2 +-
 arch/arm/mach-s3c2440/s3c2440.c            |   13 -------------
 arch/arm/mach-s3c2440/s3c244x.c            |   11 +++++++++++
 arch/arm/plat-s3c24xx/dma.c                |    2 +-
 arch/arm/plat-samsung/devs.c               |    2 +-
 24 files changed, 47 insertions(+), 46 deletions(-)
