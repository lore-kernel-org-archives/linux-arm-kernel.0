From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 30 Sep 2011 17:09:38 +0530
Subject: [PATCH 0/2]: Add SPI Support on Exynos4
Message-ID: <1317382780-3083-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds SPI support and register the SPI bus clock
with clkdev using generic connection ID on EXYNOS4. This patch
set is depend on the following patches as it uses a common macro
CLKDEV_INIT to create clk_lookup structure and it also avoids
passing clock names through platform data.

ARM: CLKDEV: Add Common Macro for clk_lookup
ARM: SAMSUNG: Remove SPI bus clocks from platform data

Padmavathi Venna (2):
  ARM: EXYNOS4: Add SPI support to EXYNOS4
  SPI: EXYNOS4: Enable the SPI driver for EXYNOS4

 arch/arm/mach-exynos4/Kconfig                    |    1 +
 arch/arm/mach-exynos4/Makefile                   |    1 +
 arch/arm/mach-exynos4/clock.c                    |   82 +++++---
 arch/arm/mach-exynos4/dev-spi.c                  |  225 ++++++++++++++++++++++
 arch/arm/mach-exynos4/include/mach/irqs.h        |    3 +
 arch/arm/mach-exynos4/include/mach/map.h         |    3 +
 arch/arm/mach-exynos4/include/mach/spi-clocks.h  |   16 ++
 arch/arm/mach-exynos4/mach-smdkv310.c            |  127 ++++++++++++-
 arch/arm/plat-samsung/include/plat/devs.h        |    3 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    1 +
 drivers/spi/Kconfig                              |    2 +-
 11 files changed, 432 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/dev-spi.c
 create mode 100644 arch/arm/mach-exynos4/include/mach/spi-clocks.h

-- 
1.7.4.4
