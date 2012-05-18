From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Fri, 18 May 2012 15:16:26 +0530
Subject: [PATCH 0/6] ARM: Exynos: Enable SPI platform support for Exynos4 and
 Exynos5
Message-ID: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set enables device tree based platform support for the three spi
controllers on Samsung's Exynos4 and Exynos5 SoC's.

Thomas Abraham (6):
  ARM: Exynos4: Fix the incorrect hierarchy of spi controller bus clock
  ARM: Exynos5: Add spi clock support
  ARM: Exynos4: Enable platform support for SPI controllers
  ARM: Exynos5: Enable platform support for SPI controllers
  ARM: dts: Add nodes for spi controllers for Samsung Exynos4 platforms
  ARM: dts: Add nodes for spi controllers for Samsung Exynos5 platforms

 arch/arm/boot/dts/exynos4210-origen.dts        |   12 +++
 arch/arm/boot/dts/exynos4210-smdkv310.dts      |   44 +++++++++++
 arch/arm/boot/dts/exynos4210.dtsi              |   30 +++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts      |   47 +++++++++++-
 arch/arm/boot/dts/exynos5250.dtsi              |   46 +++++++++++
 arch/arm/mach-exynos/Kconfig                   |    2 +
 arch/arm/mach-exynos/clock-exynos4.c           |   48 ++++++++++--
 arch/arm/mach-exynos/clock-exynos5.c           |   98 ++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/irqs.h       |    4 +
 arch/arm/mach-exynos/include/mach/map.h        |    3 +
 arch/arm/mach-exynos/include/mach/regs-clock.h |    4 +
 arch/arm/mach-exynos/mach-exynos4-dt.c         |    6 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    6 ++
 13 files changed, 341 insertions(+), 9 deletions(-)
