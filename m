From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon,  8 Oct 2012 02:10:50 +0900
Subject: [PATCH v2 0/5] clk: exynos4: migrate to common clock framework
Message-ID: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series removes the usage of Samsung specific clock for Exynos4
based platforms and migrates to use the common clock framework to register
the clocks. Both legacy and device tree enabled Exynos4 platforms are
supported. For legacy platforms, the clock instances are statically listed.
For device tree based platforms, the device tree is searched for clock nodes
and all available clock nodes are registered.

Thomas Abraham (5):
  clk: samsung: add common clock framework support for Samsung platforms
  clk: exynos4: register clocks using common clock framework
  ARM: dts: Add Exynos4210 clock nodes
  ARM: dts: list the clock providers for serial ports
  ARM: Exynos4: Migrate clock support to common clock framework

 arch/arm/boot/dts/exynos4-clock.dtsi       |  389 +++++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi             |    9 +
 arch/arm/mach-exynos/Kconfig               |    1 +
 arch/arm/mach-exynos/Makefile              |    3 -
 arch/arm/mach-exynos/clock-exynos4.h       |   35 --
 arch/arm/mach-exynos/clock-exynos4210.c    |  188 --------
 arch/arm/mach-exynos/clock-exynos4212.c    |  192 --------
 arch/arm/mach-exynos/common.c              |   22 +-
 arch/arm/mach-exynos/common.h              |    3 +
 arch/arm/mach-exynos/mach-armlex4210.c     |    1 -
 arch/arm/mach-exynos/mach-exynos4-dt.c     |    1 -
 arch/arm/mach-exynos/mach-nuri.c           |    1 -
 arch/arm/mach-exynos/mach-origen.c         |    1 -
 arch/arm/mach-exynos/mach-smdk4x12.c       |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c       |    1 -
 arch/arm/mach-exynos/mach-universal_c210.c |    1 -
 arch/arm/mach-exynos/mct.c                 |   11 +-
 arch/arm/plat-samsung/Kconfig              |    4 +-
 drivers/clk/Makefile                       |    1 +
 drivers/clk/samsung/Makefile               |    6 +
 drivers/clk/samsung/clk-exynos4.c          |  647 ++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.c                  |  414 ++++++++++++++++++
 drivers/clk/samsung/clk.h                  |  212 +++++++++
 23 files changed, 1696 insertions(+), 448 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4-clock.dtsi
 delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
 delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
 delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
 create mode 100644 drivers/clk/samsung/Makefile
 create mode 100644 drivers/clk/samsung/clk-exynos4.c
 create mode 100644 drivers/clk/samsung/clk.c
 create mode 100644 drivers/clk/samsung/clk.h

-- 
1.7.5.4
