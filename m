From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 27 Oct 2012 02:55:47 +0900
Subject: [PATCH 0/7] ARM: EXYNOS: add support for new EXYNOS5440 SoC
Message-ID: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is for adding support EXYNOS5440 SoC which is including Cortex-A15 Quad cores and SSDK5440 board.

Note: this is based on Samsung common clk work and 3rd patch for uart is wip.

[PATCH 1/7] ARM: EXYNOS: add support for EXYNOS5440 SoC
[PATCH 2/7] clk: exynos5440: add common clock support for Samsung EXYNOS5440
[PATCH 3/7] ARM: EXYNOS: add support uart for EXYNOS SoCs - WIP
[PATCH 4/7] ARM: dts: add initial dts file for EXYNOS5440, SSDK5440
[PATCH 5/7] ARM: dts: add clock controller node for Samsung EXYNOS5440
[PATCH 6/7] pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC
[PATCH 7/7] ARM: dts: Add pin controller node for Samsung EXYNOS5440 SoC

Kukjin Kim (3):
      ARM: EXYNOS: add support for EXYNOS5440 SoC
      ARM: EXYNOS: add support uart for EXYNOS SoCs - WIP
      ARM: dts: add initial dts file for EXYNOS5440, SSDK5440

Thomas Abraham (4):
      clk: exynos5440: add common clock support for Samsung EXYNOS5440
      ARM: dts: add clock controller node for Samsung EXYNOS5440
      pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC
      ARM: dts: Add pin controller node for Samsung EXYNOS5440 SoC

 arch/arm/boot/dts/exynos5440-clock.dtsi      |  143 ++++
 arch/arm/boot/dts/exynos5440-ssdk5440.dts    |   49 ++
 arch/arm/boot/dts/exynos5440.dtsi            |  159 +++++
 arch/arm/mach-exynos/Kconfig                 |   20 +
 arch/arm/mach-exynos/Makefile                |    3 +-
 arch/arm/mach-exynos/common.c                |   85 +++-
 arch/arm/mach-exynos/common.h                |    2 +
 arch/arm/mach-exynos/dev-uart.c              |   14 +
 arch/arm/mach-exynos/include/mach/irqs.h     |    5 +
 arch/arm/mach-exynos/include/mach/map.h      |    8 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c       |   34 +-
 arch/arm/mach-exynos/mct.c                   |   15 +
 arch/arm/mach-exynos/setup-i2c0.c            |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h     |    8 +
 arch/arm/plat-samsung/include/plat/devs.h    |    1 +
 drivers/clk/samsung/Makefile                 |    1 +
 drivers/clk/samsung/clk-exynos5440.c         |   66 ++
 drivers/pinctrl/Kconfig                      |    5 +
 drivers/pinctrl/Makefile                     |    1 +
 drivers/pinctrl/pinctrl-exynos5440.c         |  919 ++++++++++++++++++++++++++
 drivers/tty/serial/samsung.c                 |    3 +-
 22 files changed, 1527 insertions(+), 17 deletions(-)
