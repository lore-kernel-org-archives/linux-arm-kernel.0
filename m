From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sun, 03 Jun 2012 18:12:43 +0530
Subject: [PATCH v2 0/6] ARM: Exynos: Enable SPI platform support for Exynos4
 and Exynos5
Message-ID: <1338727369-18241-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Minor fixes based on comments from Olof, Kukjin and Padma.
- Rebased to Linux 3.5-rc1

This patch set enables device tree based platform support for the three spi
controllers on Samsung's Exynos4 and Exynos5 SoC's.

Thomas Abraham (6):
  ARM: Exynos4: Fix the incorrect hierarchy of spi controller bus clock
  ARM: Exynos5: Add spi clock support
  ARM: Exynos4: Enable platform support for SPI controllers
  ARM: Exynos5: Enable platform support for SPI controllers
  ARM: dts: Add nodes for spi controllers for Samsung Exynos4 platforms
  ARM: dts: Add nodes for spi controllers for Samsung Exynos5 platforms

 arch/arm/boot/dts/exynos4210-origen.dts   |   12 ++++
 arch/arm/boot/dts/exynos4210-smdkv310.dts |   38 +++++++++++
 arch/arm/boot/dts/exynos4210.dtsi         |   36 +++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   38 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi         |   36 +++++++++++
 arch/arm/mach-exynos/clock-exynos4.c      |   48 ++++++++++++---
 arch/arm/mach-exynos/clock-exynos5.c      |   98 +++++++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/irqs.h  |    4 +
 arch/arm/mach-exynos/include/mach/map.h   |    3 +
 arch/arm/mach-exynos/mach-exynos4-dt.c    |    6 ++
 arch/arm/mach-exynos/mach-exynos5-dt.c    |    6 ++
 11 files changed, 317 insertions(+), 8 deletions(-)
