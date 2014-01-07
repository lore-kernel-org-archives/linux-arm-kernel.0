From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 07 Jan 2014 18:28:58 +0530
Subject: [PATCH V2 00/10] exynos: add basic support for exynos5260 SoC
Message-ID: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for exynos5260 SoC.

This series is based on linux-next, Kukjin's for-next and
Mike's clk-for-linus-3.13 branches.

This patch is dependent on the following series from
Tomasz Figa <t.figa@samsung.com>:
http://www.spinics.net/lists/arm-kernel/msg280223.html

V2:
  1) Move suspend resume handling to Exynos5410 Clock file.
  2) Removed Unused Macros and Condition checks for Exynos5260.
  3) Add spin lock to clock provider context.
  4) Add clock provider context for Exynos5410.
  5) Uniform implementation for callbacks for PLL2550xx.
  6) Split Exynos5260 clock file patch to bring it under 100 Kb limit.
  7) Replace aclk/pclk/hclk gates with combined gates.
  8) Remove CLK_IGNORE_UNUSED flag for gate clocks.
  9) Split up DT patch into SoC and Board patch.

Pankaj Dubey (2):
  ARM: EXYNOS: initial board support for exynos5260 SoC
  clk/samsung: add support for pll2550xx

Rahul Sharma (7):
  clk/exynos5410: Move suspend/resume handling to SoC driver
  clk/samsung: add support for multuple clock providers
  clk/samsung: add support for pll2650xx
  clk/exynos5260: add macros and documentation for exynos5260
  clk/exynos5260: add clock file for exynos5260
  ARM: dts: add dts files for exynos5260 SoC
  ARM: dts: add dts files for xyref5260 board

Young-Gun Jang (1):
  pinctrl: exynos: add exynos5260 SoC specific data

 .../devicetree/bindings/clock/exynos5260-clock.txt |  299 +++
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          |  572 ++++++
 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts    |  105 +
 arch/arm/boot/dts/exynos5260.dtsi                  |  317 +++
 arch/arm/mach-exynos/Kconfig                       |    9 +
 arch/arm/mach-exynos/common.c                      |   19 +-
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    1 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos4.c                  |   47 +-
 drivers/clk/samsung/clk-exynos5250.c               |   26 +-
 drivers/clk/samsung/clk-exynos5260.c               | 2062 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5260.h               |  496 +++++
 drivers/clk/samsung/clk-exynos5410.c               |   59 +-
 drivers/clk/samsung/clk-exynos5420.c               |   24 +-
 drivers/clk/samsung/clk-exynos5440.c               |   18 +-
 drivers/clk/samsung/clk-pll.c                      |  223 ++-
 drivers/clk/samsung/clk-pll.h                      |    3 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |   44 +-
 drivers/clk/samsung/clk.c                          |  115 +-
 drivers/clk/samsung/clk.h                          |   72 +-
 drivers/pinctrl/pinctrl-exynos.c                   |   82 +
 drivers/pinctrl/pinctrl-samsung.c                  |    2 +
 drivers/pinctrl/pinctrl-samsung.h                  |    1 +
 include/dt-bindings/clk/exynos5260-clk.h           |  234 +++
 29 files changed, 4684 insertions(+), 159 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260-evt0.dts
 create mode 100644 arch/arm/boot/dts/exynos5260.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5260.c
 create mode 100644 drivers/clk/samsung/clk-exynos5260.h
 create mode 100644 include/dt-bindings/clk/exynos5260-clk.h

-- 
1.7.9.5
