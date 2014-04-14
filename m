From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Mon, 14 Apr 2014 11:17:37 +0400
Subject: [PATCH v8 0/3] Exynos 5410 support
Message-ID: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches represent support of Exynos 5410 SoC

The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture

Patches add new platform description, support of clock controller and device
tree for Exynos 5410.

Has been build on Linux Kernel v3.15-rc1
Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
		    2) Odroid-XU board (exynos_defconfig)

I hope, this will be commited to Linux v3.15...

Tarek.

Tarek Dakhran (3):
  ARM: EXYNOS: Add support for EXYNOS5410 SoC
  clk: exynos5410: register clocks using common clock framework
  ARM: dts: Add initial device tree support for EXYNOS5410

 .../devicetree/bindings/clock/exynos5410-clock.txt |   51 +++++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   65 ++++++
 arch/arm/boot/dts/exynos5410.dtsi                  |  140 ++++++++++++
 arch/arm/mach-exynos/Kconfig                       |    8 +
 arch/arm/mach-exynos/exynos.c                      |   12 ++
 arch/arm/mach-exynos/hotplug.c                     |    4 +-
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/platsmp.c                     |   10 +-
 arch/arm/mach-exynos/regs-pmu.h                    |    4 +-
 arch/arm/plat-samsung/include/plat/cpu.h           |   11 +-
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5410.c               |  223 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5410.h             |   33 +++
 14 files changed, 556 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
 create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5410.c
 create mode 100644 include/dt-bindings/clock/exynos5410.h

-- 
1.7.9.5
