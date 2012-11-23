From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Nov 2012 10:37:03 +0900
Subject: [GIT PULL 3/3] Samsung exynos5440 for v3.8
Message-ID: <10d401cdc91b$09fe1980$1dfa4c80$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is adding support for exynos5440, including Quad ARM Cortex-A15 cores
and its reference board SSDK5440.

Note, at this moment, just enabled minimal system part for initial kernel
boot and pinctrl driver.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/soc-exynos5440

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/soc-exynos5440

Kukjin Kim (2):
      ARM: EXYNOS: add support for EXYNOS5440 SoC
      ARM: dts: add initial dts file for EXYNOS5440, SSDK5440

Thomas Abraham (2):
      pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC
      ARM: dts: Add pin controller node for Samsung EXYNOS5440 SoC

 arch/arm/boot/dts/Makefile                   |    3 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts    |   46 ++
 arch/arm/boot/dts/exynos5440.dtsi            |  159 +++++
 arch/arm/mach-exynos/Kconfig                 |   11 +-
 arch/arm/mach-exynos/Makefile                |    2 +-
 arch/arm/mach-exynos/common.c                |   68 ++-
 arch/arm/mach-exynos/include/mach/irqs.h     |    5 +
 arch/arm/mach-exynos/include/mach/map.h      |    5 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c       |   31 +-
 arch/arm/mach-exynos/mct.c                   |   11 +-
 arch/arm/mach-exynos/setup-i2c0.c            |    2 +-
 arch/arm/plat-samsung/include/plat/cpu.h     |    8 +
 drivers/pinctrl/Kconfig                      |    5 +
 drivers/pinctrl/Makefile                     |    1 +
 drivers/pinctrl/pinctrl-exynos5440.c         |  919
++++++++++++++++++++++++++
 drivers/tty/serial/samsung.c                 |    3 +-
 17 files changed, 1258 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5440-ssdk5440.dts
 create mode 100644 arch/arm/boot/dts/exynos5440.dtsi
 create mode 100644 drivers/pinctrl/pinctrl-exynos5440.c
