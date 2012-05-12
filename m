From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 13 May 2012 08:18:43 +0900
Subject: [GIT PULL] cleanup samsung plat-s3c24xx and s5p for v3.5
Message-ID: <4FAEEFD3.9040907@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull cleanup plat-s3c24xx-s5p for v3.5 Samsung stuff.

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
next/cleanup-plat-s3c24xx-s5p

We can remove plat-s5p directory with this series and I think, the 
plat-s3c24xx can be removed next time for one plat-samsung of Samsung stuff.

Note, this is including cleanup-samsung-iommu which is removing s5p 
iommu stuff in plat-s5p.

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
next/cleanup-plat-s3c24xx-s5p

Heiko Stuebner (4):
       ARM: S3C24XX: move plat-s3c24xx/cpu.c
       ARM: S3C24XX: move plat-s3c24xx/dev-uart.c into common.c
       ARM: S3C24XX: move common power-management code to mach-s3c24xx
       ARM: S3C24XX: move common clock init into common.c

Kukjin Kim (9):
       ARM: SAMSUNG: move clock part for common s5p into plat-samsung
       ARM: SAMSUNG: move interrupt part for common s5p into plat-samsung
       ARM: SAMSUNG: move pm part for common s5p into plat-samsung
       ARM: SAMSUNG: move hr timer for common s5p into plat-samsung
       ARM: SAMSUNG: move platform device for s5p uart into plat-samsung
       ARM: SAMSUNG: move setup code for s5p mfc and mipiphy into 
plat-samsung
       ARM: SAMSUNG: move options for common s5p into plat-samsung/Kconfig
       ARM: SAMSUNG: merge plat-s5p into plat-samsung
       Merge branch 'next/cleanup-plat-s3c24xx' into 
next/cleanup-plat-s3c24xx-s5p

KyongHo Cho (2):
       S5P: SYSMMU: Remove System MMU device driver
       ARM: EXYNOS: Change System MMU platform device definitions

  arch/arm/mach-exynos/clock-exynos4.h               |    2 +
  arch/arm/mach-exynos/clock-exynos4210.c            |   11 +
  arch/arm/mach-exynos/clock-exynos4212.c            |   28 ++-
  arch/arm/mach-exynos/clock-exynos5.c               |   90 ++++
  arch/arm/mach-exynos/dev-sysmmu.c                  |  457 
+++++++++++---------
  arch/arm/mach-exynos/include/mach/irqs.h           |   25 +-
  arch/arm/mach-exynos/include/mach/map.h            |   38 ++
  arch/arm/mach-exynos/include/mach/regs-clock.h     |    5 +
  arch/arm/mach-exynos/include/mach/regs-sysmmu.h    |   28 --
  arch/arm/mach-exynos/include/mach/sysmmu.h         |   88 +++--
  arch/arm/mach-exynos/mach-armlex4210.c             |    1 -
  arch/arm/mach-exynos/mach-smdkv310.c               |    1 -
  arch/arm/mach-s3c24xx/Makefile                     |    6 +
  .../{plat-s3c24xx/cpu.c => mach-s3c24xx/common.c}  |   69 +++-
  arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c   |    0
  arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c       |    0
  arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S    |    0
  arch/arm/plat-s3c24xx/Makefile                     |    6 -
  arch/arm/plat-s3c24xx/clock.c                      |   59 ---
  arch/arm/plat-s3c24xx/dev-uart.c                   |  100 -----
  arch/arm/plat-s5p/Kconfig                          |  140 ------
  arch/arm/plat-s5p/Makefile                         |   28 --
  arch/arm/plat-s5p/sysmmu.c                         |  313 --------------
  arch/arm/plat-samsung/Kconfig                      |  140 ++++++
  arch/arm/plat-samsung/Makefile                     |   13 +
  arch/arm/plat-samsung/include/plat/devs.h          |    1 -
  arch/arm/plat-samsung/include/plat/sysmmu.h        |   95 ----
  .../{plat-s5p/clock.c => plat-samsung/s5p-clock.c} |    3 +-
  .../dev-mfc.c => plat-samsung/s5p-dev-mfc.c}       |    4 +-
  .../dev-uart.c => plat-samsung/s5p-dev-uart.c}     |   78 +---
  .../irq-eint.c => plat-samsung/s5p-irq-eint.c}     |    3 +-
  .../s5p-irq-gpioint.c}                             |    3 +-
  .../irq-pm.c => plat-samsung/s5p-irq-pm.c}         |    3 +-
  .../arm/{plat-s5p/irq.c => plat-samsung/s5p-irq.c} |    3 +-
  arch/arm/{plat-s5p/pm.c => plat-samsung/s5p-pm.c}  |    3 +-
  .../{plat-s5p/sleep.S => plat-samsung/s5p-sleep.S} |    3 +-
  arch/arm/{plat-s5p => plat-samsung}/s5p-time.c     |    3 +-
  .../arm/{plat-s5p => plat-samsung}/setup-mipiphy.c |    0
  43 files changed, 781 insertions(+), 1163 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-sysmmu.h
  rename arch/arm/{plat-s3c24xx/cpu.c => mach-s3c24xx/common.c} (76%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq-pm.c (100%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/pm.c (100%)
  rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/sleep.S (100%)
  delete mode 100644 arch/arm/plat-s3c24xx/clock.c
  delete mode 100644 arch/arm/plat-s3c24xx/dev-uart.c
  delete mode 100644 arch/arm/plat-s5p/Kconfig
  delete mode 100644 arch/arm/plat-s5p/Makefile
  delete mode 100644 arch/arm/plat-s5p/sysmmu.c
  delete mode 100644 arch/arm/plat-samsung/include/plat/sysmmu.h
  rename arch/arm/{plat-s5p/clock.c => plat-samsung/s5p-clock.c} (99%)
  rename arch/arm/{plat-s5p/dev-mfc.c => plat-samsung/s5p-dev-mfc.c} (97%)
  rename arch/arm/{plat-s5p/dev-uart.c => plat-samsung/s5p-dev-uart.c} (57%)
  rename arch/arm/{plat-s5p/irq-eint.c => plat-samsung/s5p-irq-eint.c} (99%)
  rename arch/arm/{plat-s5p/irq-gpioint.c => 
plat-samsung/s5p-irq-gpioint.c} (99%)
  rename arch/arm/{plat-s5p/irq-pm.c => plat-samsung/s5p-irq-pm.c} (98%)
  rename arch/arm/{plat-s5p/irq.c => plat-samsung/s5p-irq.c} (96%)
  rename arch/arm/{plat-s5p/pm.c => plat-samsung/s5p-pm.c} (95%)
  rename arch/arm/{plat-s5p/sleep.S => plat-samsung/s5p-sleep.S} (98%)
  rename arch/arm/{plat-s5p => plat-samsung}/s5p-time.c (99%)
  rename arch/arm/{plat-s5p => plat-samsung}/setup-mipiphy.c (100%)
