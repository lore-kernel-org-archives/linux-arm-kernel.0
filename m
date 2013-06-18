From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 05:00:52 +0900
Subject: [GIT PULL 08/10] Samsung SoC EXYNOS5420 for v3.11
Message-ID: <51C0BC74.1060502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 79d743c177f99d6854e152d9e7fac5bbbeb7c25e:

   clk: exynos5250: Add enum entries for divider clock of i2s1 and i2s2 
(2013-06-19 03:28:43 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/soc-exynos5420-1

for you to fetch changes up to eff4e7c7f32a4e4be60b19b209ffab5cb430b385:

   ARM: EXYNOS: extend soft-reset support for EXYNOS5420 (2013-06-19 
04:09:37 +0900)

----------------------------------------------------------------
based on tags/common-clk-audio
- add support for exynos5420 SoC

----------------------------------------------------------------
Chander Kashyap (10):
       ARM: dts: fork out common EXYNOS5 nodes
       ARM: dts: list the CPU nodes for EXYNOS5250
       ARM: EXYNOS: Add support for EXYNOS5420 SoC
       serial: samsung: select EXYNOS specific driver data if 
ARCH_EXYNOS is defined
       ARM: EXYNOS: use four additional chipid bits to identify EXYNOS 
family
       clk: exynos5420: register clocks using common clock framework
       ARM: dts: Add initial device tree support for EXYNOS5420
       clocksource: exynos_mct: use (request/free)_irq calls for local 
timer registration
       ARM: EXYNOS: add secondary CPU boot base location for EXYNOS5420
       ARM: EXYNOS: extend soft-reset support for EXYNOS5420

  .../devicetree/bindings/clock/exynos5420-clock.txt | 201 ++++++
  arch/arm/boot/dts/Makefile                         |   1 +
  arch/arm/boot/dts/exynos5.dtsi                     | 111 +++
  arch/arm/boot/dts/exynos5250.dtsi                  |  78 +--
  arch/arm/boot/dts/exynos5420-smdk5420.dts          |  33 +
  arch/arm/boot/dts/exynos5420.dtsi                  | 103 +++
  arch/arm/mach-exynos/Kconfig                       |  10 +
  arch/arm/mach-exynos/common.c                      |  18 +-
  arch/arm/mach-exynos/include/mach/uncompress.h     |   7 +-
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   1 +
  arch/arm/mach-exynos/platsmp.c                     |  12 +-
  arch/arm/plat-samsung/include/plat/cpu.h           |   8 +
  drivers/clk/samsung/Makefile                       |   1 +
  drivers/clk/samsung/clk-exynos5420.c               | 762 
+++++++++++++++++++++
  drivers/clocksource/exynos_mct.c                   |  35 +-
  drivers/tty/serial/samsung.c                       |   4 +-
  16 files changed, 1279 insertions(+), 106 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5420-clock.txt
  create mode 100644 arch/arm/boot/dts/exynos5.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5420-smdk5420.dts
  create mode 100644 arch/arm/boot/dts/exynos5420.dtsi
  create mode 100644 drivers/clk/samsung/clk-exynos5420.c
