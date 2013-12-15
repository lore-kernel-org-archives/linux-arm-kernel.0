From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 05:23:01 +0900
Subject: [GIT PULL 7/7] Samsung SoC for v3.14
Message-ID: <52AE0FA5.3090804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-soc

for you to fetch changes up to 538cfbb4c40ab59688236484138133b8e3e89220:

   ARM: dts: Add initial support for Arndale Octa board (2013-12-16 
05:05:43 +0900)

----------------------------------------------------------------
Samsung SoC updates for v3.14
- Add exynos5410 SoC and smdk5410 board support
   : add supporting SoC and board DT files
   : add clk-exynos5410 with using CCF
- Add exynos5420-arndale-octa board support
   : basic supporting for Arndale Octa board

----------------------------------------------------------------
Sachin Kamat (1):
       ARM: dts: Add initial support for Arndale Octa board

Tarek Dakhran (3):
       ARM: EXYNOS: Add support for EXYNOS5410 SoC
       clk: exynos5410: register clocks using common clock framework
       ARM: dts: Add initial device tree support for EXYNOS5410

  .../devicetree/bindings/clock/exynos5410-clock.txt |  54 +++++
  arch/arm/boot/dts/Makefile                         |   2 +
  arch/arm/boot/dts/exynos5410-smdk5410.dts          |  72 +++++++
  arch/arm/boot/dts/exynos5410.dtsi                  | 145 +++++++++++++
  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  66 ++++++
  arch/arm/mach-exynos/Kconfig                       |  10 +
  arch/arm/mach-exynos/common.c                      |  18 ++
  arch/arm/mach-exynos/include/mach/map.h            |   1 +
  arch/arm/mach-exynos/mach-exynos5-dt.c             |   1 +
  arch/arm/mach-exynos/platsmp.c                     |   2 +
  arch/arm/plat-samsung/include/plat/cpu.h           |   8 +
  arch/arm/plat-samsung/include/plat/map-s5p.h       |   3 +
  drivers/clk/samsung/Makefile                       |   1 +
  drivers/clk/samsung/clk-exynos5410.c               | 239 
+++++++++++++++++++++
  include/dt-bindings/clock/exynos5410.h             |  32 +++
  15 files changed, 654 insertions(+)
  create mode 100644 
Documentation/devicetree/bindings/clock/exynos5410-clock.txt
  create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
  create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
  create mode 100644 arch/arm/boot/dts/exynos5420-arndale-octa.dts
  create mode 100644 drivers/clk/samsung/clk-exynos5410.c
  create mode 100644 include/dt-bindings/clock/exynos5410.h
