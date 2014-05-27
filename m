From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 28 May 2014 07:07:54 +0900
Subject: [GIT PULL 4th 2/2 v2] Samsung Exynos 2nd SoC updates for 3.16
Message-ID: <53850CBA.2000000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f7b163d16d412e14be49f47240ffaba328aaab6c:

   cpufreq: exynos: Fix driver compilation with ARCH_MULTIPLATFORM 
(2014-05-27 23:52:50 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-soc-2-2nd

for you to fetch changes up to 179147bc72cf803da6d29ce7a5a6606c48debcea:

   ARM: dts: Add initial device tree support for EXYNOS5410 (2014-05-27 
23:55:48 +0900)

----------------------------------------------------------------
Exynos 2nd new SoC support for 3.16

- Add support for exynos5410 and exynos5410-smdk5410.
   Tested with exynos_defconfig and multi_v7_defconfig
   and it works fine.

----------------------------------------------------------------
Tarek Dakhran (3):
       ARM: EXYNOS: Add support for EXYNOS5410 SoC
       clk: exynos5410: register clocks using common clock framework
       ARM: dts: Add initial device tree support for EXYNOS5410

  .../devicetree/bindings/clock/exynos5410-clock.txt |  45 +++++
  arch/arm/boot/dts/Makefile                         |   1 +
  arch/arm/boot/dts/exynos5410-smdk5410.dts          |  82 ++++++++
  arch/arm/boot/dts/exynos5410.dtsi                  | 206 
++++++++++++++++++++
  arch/arm/mach-exynos/Kconfig                       |   5 +
  arch/arm/mach-exynos/common.h                      |  12 +-
  drivers/clk/samsung/Makefile                       |   1 +
  drivers/clk/samsung/clk-exynos5410.c               | 209 
+++++++++++++++++++++
  include/dt-bindings/clock/exynos5410.h             |  33 ++++
  9 files changed, 592 insertions(+), 2 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5410-clock.txt
  create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
  create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
  create mode 100644 include/dt-bindings/clock/exynos5410.h
