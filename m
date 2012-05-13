From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 09:33:26 +0900
Subject: [GIT PULL] Samsung devel-1 for v3.5
Message-ID: <4FAF0156.5080306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull Samsung devel for v3.5

This is including exynos/iommu, platform of drm and fimc-lite, dma for 
exynos5250 and s3c24xx-hsspi.

Note, the exynos/iommu patch got the ack from Joerg and this should be 
sent to upstream via arm tree and since it depends on 
cleanup-samsung-iommu, the cleanup branch is included(merged) in here.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

   Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/devel-samsung

Boojin Kim (1):
       ARM: EXYNOS: Support DMA for EXYNOS5250 SoC

Heiko Stuebner (6):
       ARM: S3C24XX: Add forgotten clock lookup table to S3C2443
       ARM: S3C24XX: claim spi channels for hsspi in dma-s3c2443
       ARM: S3C24XX: Add map entries needed by the s3c64xx-spi devices
       ARM: S3C24XX: Add clock-lookup entries required by s3c64xx-spi
       ARM: S3C24XX: Add HSSPI setup callback for s3c64xx-spi driver
       spi/s3c64xx: Allow usage for ARCH_S3C24XX

Kukjin Kim (2):
       Merge branch 'next/devel-samsung-iommu' into next/devel-samsung
       Merge branch 'next/devel-s3c24xx-hsspi' into next/devel-samsung

KyongHo Cho (3):
       S5P: SYSMMU: Remove System MMU device driver
       ARM: EXYNOS: Change System MMU platform device definitions
       iommu/exynos: Add iommu driver for EXYNOS Platforms

Kyoungil Kim (1):
       ARM: EXYNOS: To use common config for EXYNOS4 and EXYNOS5 SPI

Lukasz Majewski (1):
       ARM: EXYNOS: Add usb otg phy control for EXYNOS4210

Marek Szyprowski (1):
       ARM: EXYNOS: add platform device for core DRM subsystem

Olof Johansson (1):
       ARM: EXYNOS: add dts files to dtbs target

Sylwester Nawrocki (1):
       ARM: EXYNOS: Add platform resource definitions for FIMC-LITE

  arch/arm/mach-exynos/Kconfig                    |   24 +-
  arch/arm/mach-exynos/Makefile                   |    7 +-
  arch/arm/mach-exynos/Makefile.boot              |    3 +
  arch/arm/mach-exynos/clock-exynos4.c            |   79 +-
  arch/arm/mach-exynos/clock-exynos4.h            |    2 +
  arch/arm/mach-exynos/clock-exynos4210.c         |   11 +
  arch/arm/mach-exynos/clock-exynos4212.c         |   38 +-
  arch/arm/mach-exynos/clock-exynos5.c            |   90 ++
  arch/arm/mach-exynos/dev-drm.c                  |   29 +
  arch/arm/mach-exynos/dev-sysmmu.c               |  457 ++++++-----
  arch/arm/mach-exynos/dma.c                      |  141 +++-
  arch/arm/mach-exynos/include/mach/irqs.h        |   26 +-
  arch/arm/mach-exynos/include/mach/map.h         |   45 +
  arch/arm/mach-exynos/include/mach/regs-clock.h  |    5 +
  arch/arm/mach-exynos/include/mach/regs-pmu.h    |    3 +
  arch/arm/mach-exynos/include/mach/regs-sysmmu.h |   28 -
  arch/arm/mach-exynos/include/mach/spi-clocks.h  |    2 +-
  arch/arm/mach-exynos/include/mach/sysmmu.h      |   88 ++-
  arch/arm/mach-exynos/mach-armlex4210.c          |    1 -
  arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
  arch/arm/mach-exynos/setup-usb-phy.c            |   95 ++-
  arch/arm/mach-s3c24xx/Kconfig                   |    5 +
  arch/arm/mach-s3c24xx/Makefile                  |    1 +
  arch/arm/mach-s3c24xx/clock-s3c2416.c           |    1 +
  arch/arm/mach-s3c24xx/clock-s3c2443.c           |    6 +
  arch/arm/mach-s3c24xx/common-s3c2443.c          |   15 +-
  arch/arm/mach-s3c24xx/dma-s3c2443.c             |   16 +-
  arch/arm/mach-s3c24xx/include/mach/dma.h        |    4 +
  arch/arm/mach-s3c24xx/include/mach/map.h        |    5 +
  arch/arm/mach-s3c24xx/setup-spi.c               |   39 +
  arch/arm/plat-s5p/Kconfig                       |    8 -
  arch/arm/plat-s5p/Makefile                      |    1 -
  arch/arm/plat-s5p/sysmmu.c                      |  313 -------
  arch/arm/plat-samsung/Kconfig                   |    2 +-
  arch/arm/plat-samsung/include/plat/devs.h       |    3 +-
  arch/arm/plat-samsung/include/plat/dma-pl330.h  |    1 +
  arch/arm/plat-samsung/include/plat/sysmmu.h     |   95 --
  drivers/iommu/Kconfig                           |   21 +
  drivers/iommu/Makefile                          |    1 +
  drivers/iommu/exynos-iommu.c                    | 1076 
+++++++++++++++++++++++
  drivers/spi/Kconfig                             |    2 +-
  41 files changed, 1966 insertions(+), 824 deletions(-)
  create mode 100644 arch/arm/mach-exynos/dev-drm.c
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-sysmmu.h
  create mode 100644 arch/arm/mach-s3c24xx/setup-spi.c
  delete mode 100644 arch/arm/plat-s5p/sysmmu.c
  delete mode 100644 arch/arm/plat-samsung/include/plat/sysmmu.h
  create mode 100644 drivers/iommu/exynos-iommu.c
