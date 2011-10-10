From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 10 Oct 2011 13:38:03 +0530
Subject: [PATCH V2 0/2]: Add SPI Support on Exynos4
Message-ID: <1318234084-19960-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds SPI support and register the SPI bus clock
with clkdev using generic connection ID on EXYNOS4. This patch
set is depend on the following patches as it uses a common macro
CLKDEV_INIT to create clk_lookup structure and it also avoids
passing clock names through platform data.

ARM: CLKDEV: Add Common Macro for clk_lookup
ARM: SAMSUNG: Remove SPI bus clocks from platform data

V1 patch series are:
  http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg06986.html
  ARM: EXYNOS4: Add SPI support to EXYNOS4
  SPI: EXYNOS4: Enable the SPI driver for EXYNOS4

Changes Since V1:
	Reworked the patches as per the following link. Patch series in
        the following link removed & and , from the macro declaration and added
        in the macro defination.
        http://www.spinics.net/lists/arm-kernel/msg143663.html

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
