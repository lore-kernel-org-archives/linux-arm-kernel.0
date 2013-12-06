From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Fri, 06 Dec 2013 21:26:24 +0530
Subject: [PATCH 0/7] exynos: add basic support for exynos5260 SoC
Message-ID: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add basic support for exynos5260 SoC.

This series is based on linux-next, Kukjin's for-next and
Mike's clk-for-linus-3.13 branches.

This patch is dependent on the following series from
Tomasz Figa <t.figa@samsung.com>:
http://www.spinics.net/lists/arm-kernel/msg280223.html

Arun Kumar K (1):
  ARM: dts: add dts files for exynos5260 SoC

Pankaj Dubey (2):
  ARM: EXYNOS: initial board support for exynos5260 SoC
  clk/samsung: add support for pll2550xx

Rahul Sharma (3):
  clk/samsung: add support for multuple clock providers
  clk/samsung: add support for pll2650xx
  clk/exynos5260: add clock file for exynos5260

Young-Gun Jang (1):
  pinctrl: exynos: add exynos5260 SoC specific data

 .../devicetree/bindings/clock/exynos5260-clock.txt |  228 ++
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          |  586 +++++
 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts    |   85 +
 arch/arm/boot/dts/exynos5260.dtsi                  |  315 +++
 arch/arm/mach-exynos/Kconfig                       |    9 +
 arch/arm/mach-exynos/common.c                      |   19 +-
 arch/arm/mach-exynos/cpuidle.c                     |    2 +-
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/include/mach/regs-pmu.h       |    4 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    1 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos4.c                  |   47 +-
 drivers/clk/samsung/clk-exynos5250.c               |   26 +-
 drivers/clk/samsung/clk-exynos5260.c               | 2661 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5260.h               |  496 ++++
 drivers/clk/samsung/clk-exynos5420.c               |   24 +-
 drivers/clk/samsung/clk-exynos5440.c               |   18 +-
 drivers/clk/samsung/clk-pll.c                      |  222 +-
 drivers/clk/samsung/clk-pll.h                      |    3 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |   44 +-
 drivers/clk/samsung/clk.c                          |  110 +-
 drivers/clk/samsung/clk.h                          |   46 +-
 drivers/pinctrl/pinctrl-exynos.c                   |   82 +
 drivers/pinctrl/pinctrl-samsung.c                  |    2 +
 drivers/pinctrl/pinctrl-samsung.h                  |    1 +
 include/dt-bindings/clk/exynos5260-clk.h           |  169 ++
 30 files changed, 5076 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
 create mode 100644 arch/arm/boot/dts/exynos5260.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5260.c
 create mode 100644 drivers/clk/samsung/clk-exynos5260.h
 create mode 100644 include/dt-bindings/clk/exynos5260-clk.h

-- 
1.7.9.5
