From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 May 2012 18:06:49 +0900
Subject: [GIT PULL] Samsung devel-1 for v3.5
In-Reply-To: <064f01cd31a5$d2300660$76901320$%kim@samsung.com>
References: <4FAF0156.5080306@samsung.com>
 <CAOesGMhwEpQstrM5Zc4ie=CX2BAoSsfAvJbZYxUpg66NUnxrjw@mail.gmail.com>
 <064f01cd31a5$d2300660$76901320$%kim@samsung.com>
Message-ID: <07fe01cd327a$0fde53c0$2f9afb40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Olof Johansson wrote:
> >
> > On Sat, May 12, 2012 at 5:33 PM, Kukjin Kim <kgene.kim@samsung.com>
> wrote:
> > > Hi Arnd, Olof
> > >
> > > Please pull Samsung devel for v3.5
> > >
> > > This is including exynos/iommu, platform of drm and fimc-lite, dma for
> > > exynos5250 and s3c24xx-hsspi.
> > >
> > > Note, the exynos/iommu patch got the ack from Joerg and this should be
> > sent
> > > to upstream via arm tree and since it depends on
cleanup-samsung-iommu,
> > the
> > > cleanup branch is included(merged) in here.
> > >
> > > If any problems, please let me know.
> >
> > Same here, I'll hold off pulling this until we've sorted out the
> > cleanup-samsung-iommu request.
> >
> Please hold this off for a moment because I need to sort out regarding
> s3c-hsotg patches which cause build error because some patches have been
> already in usb tree for it.
> 
> If required, I will send separate branch to you.
> 
Hi Arnd and Olof,

I updated the next/devel-samsung branch. As I said, I separate out the
regarding s3c-hsotg patches from here and it will be sent to usb tree. And
added support suspend/resume for EXYNOS4412, others same as before.

Please pull Samsung devel-1 for v3.5 from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/devel-samsung

If any problems, please kindly let me know.

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

Inderpal Singh (1):
      ARM: EXYNOS: Support Suspend/Resume for EXYNOS4412

Kukjin Kim (2):
      Merge branch 'next/devel-samsung-iommu' into next/devel-samsung
      Merge branch 'next/devel-s3c24xx-hsspi' into next/devel-samsung

KyongHo Cho (3):
      S5P: SYSMMU: Remove System MMU device driver
      ARM: EXYNOS: Change System MMU platform device definitions
      iommu/exynos: Add iommu driver for EXYNOS Platforms

Kyoungil Kim (1):
      ARM: EXYNOS: To use common config for EXYNOS4 and EXYNOS5 SPI

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
 arch/arm/mach-exynos/include/mach/irqs.h        |   25 +-
 arch/arm/mach-exynos/include/mach/map.h         |   41 +
 arch/arm/mach-exynos/include/mach/regs-clock.h  |    5 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h    |   10 +-
 arch/arm/mach-exynos/include/mach/regs-sysmmu.h |   28 -
 arch/arm/mach-exynos/include/mach/spi-clocks.h  |    2 +-
 arch/arm/mach-exynos/include/mach/sysmmu.h      |   88 ++-
 arch/arm/mach-exynos/mach-armlex4210.c          |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c            |    1 -
 arch/arm/mach-exynos/pm.c                       |    2 +-
 arch/arm/mach-exynos/pmu.c                      |   24 +-
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
 42 files changed, 1918 insertions(+), 805 deletions(-)
 create mode 100644 arch/arm/mach-exynos/dev-drm.c
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-sysmmu.h
 create mode 100644 arch/arm/mach-s3c24xx/setup-spi.c
 delete mode 100644 arch/arm/plat-s5p/sysmmu.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/sysmmu.h
 create mode 100644 drivers/iommu/exynos-iommu.c
