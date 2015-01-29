From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 29 Jan 2015 09:33:39 +0900
Subject: [GIT PULL 1/4] Samsung Cleanup for v3.20
Message-ID: <54C97FE3.3030600@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Please pull Samsung cleanup for v3.20.

This cleanup is very nice, Samsung SoCs no more use specific DMA and
remove i2c sys from mach-exynos. Thanks to Arnd and all involved guys.

- Kukjin


The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-cleanup

for you to fetch changes up to d50b9e2e788dce9b120b5ac1140f0cdd1bf905eb:

  ARM: SAMSUNG: remove unused DMA infrastructure (2015-01-24 13:09:54 +0900)

----------------------------------------------------------------
Samsung cleanup for v3.20

- remove i2c sys configuration from mach-exynos/
  : all related codes moved into i2c driver
- remove Samsung specific DMA
  : every Samsung stuff uses dmaengine APIs

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: SAMSUNG: remove unused DMA infrastructure

Pankaj Dubey (1):
      ARM: EXYNOS: Remove i2c sys configuration related code

 Documentation/arm/Samsung-S3C24XX/DMA.txt        |   46 -
 arch/arm/mach-exynos/exynos.c                    |   39 +-
 arch/arm/mach-exynos/include/mach/dma.h          |   26 -
 arch/arm/mach-exynos/include/mach/map.h          |    3 -
 arch/arm/mach-exynos/pm.c                        |    3 +-
 arch/arm/mach-exynos/regs-sys.h                  |   22 -
 arch/arm/mach-exynos/suspend.c                   |    7 -
 arch/arm/mach-s3c24xx/Kconfig                    |   42 -
 arch/arm/mach-s3c24xx/Makefile                   |    7 -
 arch/arm/mach-s3c24xx/dma-s3c2410.c              |  182 ---
 arch/arm/mach-s3c24xx/dma-s3c2412.c              |  150 ---
 arch/arm/mach-s3c24xx/dma-s3c2440.c              |  193 ---
 arch/arm/mach-s3c24xx/dma-s3c2443.c              |  179 ---
 arch/arm/mach-s3c24xx/dma.c                      | 1465
----------------------
 arch/arm/mach-s3c24xx/include/mach/dma.h         |  159 ---
 arch/arm/mach-s3c64xx/include/mach/dma.h         |   15 -
 arch/arm/plat-samsung/Kconfig                    |   15 -
 arch/arm/plat-samsung/Makefile                   |    6 -
 arch/arm/plat-samsung/dma-ops.c                  |  146 ---
 arch/arm/plat-samsung/dma.c                      |   84 --
 arch/arm/plat-samsung/include/plat/dma-core.h    |   22 -
 arch/arm/plat-samsung/include/plat/dma-ops.h     |   69 -
 arch/arm/plat-samsung/include/plat/dma-pl330.h   |  121 --
 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h |   73 --
 arch/arm/plat-samsung/include/plat/dma.h         |  130 --
 arch/arm/plat-samsung/include/plat/regs-dma.h    |  151 ---
 arch/arm/plat-samsung/s3c-dma-ops.c              |  146 ---
 drivers/dma/Kconfig                              |    2 +-
 28 files changed, 5 insertions(+), 3498 deletions(-)
 delete mode 100644 Documentation/arm/Samsung-S3C24XX/DMA.txt
 delete mode 100644 arch/arm/mach-exynos/include/mach/dma.h
 delete mode 100644 arch/arm/mach-exynos/regs-sys.h
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/dma.c
 delete mode 100644 arch/arm/plat-samsung/dma-ops.c
 delete mode 100644 arch/arm/plat-samsung/dma.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-core.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-ops.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-pl330.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma-s3c24xx.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/dma.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-dma.h
 delete mode 100644 arch/arm/plat-samsung/s3c-dma-ops.c
