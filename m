From: padma.v@samsung.com (Padmavathi Venna)
Date: Fri, 04 Nov 2011 09:00:05 -0400
Subject: [PATCH V4] Add SPI Support on Exynos4
Message-ID: <1320411606-11518-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SPI support and register the SPI bus clock
with clkdev using generic connection ID on EXYNOS4. This patch
is dependent on 

[PATCH 1/6] ARM: SAMSUNG: Consolidation of SPI platform devices to plat-samsung

V2 Changes:
Reworked the patches as per the following link. Patch series in
the following link removed & and , from the macro declaration and added
in the macro defination.
http://www.spinics.net/lists/arm-kernel/msg143663.html

V4 Changes:
Rebased on latest for-next branch. Reworked the patche based on SPI 
platform device consolidation.This patchset is dependent on the following patch.
[PATCH 1/5] ARM: SAMSUNG: Consolidation of SPI platform devices to plat-samsung.

Padmavathi Venna (1):
  ARM: EXYNOS4: Add SPI support

 arch/arm/mach-exynos4/Kconfig                   |    5 ++
 arch/arm/mach-exynos4/Makefile                  |    1 +
 arch/arm/mach-exynos4/clock.c                   |   72 +++++++++++++---------
 arch/arm/mach-exynos4/include/mach/irqs.h       |    3 +
 arch/arm/mach-exynos4/include/mach/map.h        |    6 ++
 arch/arm/mach-exynos4/include/mach/spi-clocks.h |   16 +++++
 arch/arm/mach-exynos4/mach-smdkv310.c           |   35 +++++++++++
 arch/arm/mach-exynos4/setup-spi.c               |   47 +++++++++++++++
 8 files changed, 155 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-exynos4/setup-spi.c
