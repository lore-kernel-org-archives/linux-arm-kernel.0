From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Mon, 10 Feb 2014 19:08:28 +0900
Subject: [PATCH v6 0/3] Exynos 5410 support
Message-ID: <1392026911-21308-1-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches represent support of Exynos 5410 SoC

The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture

Patches add new platform description, support of clock controller and device 
tree for Exynos 5410.

Dual cluster support for Exynos 5410 (EDCS) has been removed from this series 
This patches is activating only the big cluster (2xA15 cores)

EDCS patch, which allows all 8 CPU cores (4 x A7 and 4 x A15) 
to run at the same time, will be released separately

Has been build on v3.14-rc1
Has been tested on Exynos 5410 reference board (exynos_defconfig)

Thanks for all your comments to Tomasz Figa, Dave Martin and Nicolas Pitre.
I hope, this is enough clean and hasn't any dependencies to go through 
Samsung tree.

Tarek.


Changelog:

v6:
	small changes in Makefiles for resolving conflicts related to changes in 
	Samsung tree.

Tarek Dakhran (3):
  ARM: EXYNOS: Add support for EXYNOS5410 SoC
  clk: exynos5410: register clocks using common clock framework
  ARM: dts: Add initial device tree support for EXYNOS5410

 .../devicetree/bindings/clock/exynos5410-clock.txt |   54 +++++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   72 ++++++
 arch/arm/boot/dts/exynos5410.dtsi                  |  140 ++++++++++++
 arch/arm/mach-exynos/Kconfig                       |   10 +
 arch/arm/mach-exynos/common.c                      |   18 ++
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 +
 arch/arm/mach-exynos/platsmp.c                     |    2 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    3 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5410.c               |  239 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5410.h             |   32 +++
 14 files changed, 582 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
 create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5410.c
 create mode 100644 include/dt-bindings/clock/exynos5410.h

-- 
1.7.10.4
