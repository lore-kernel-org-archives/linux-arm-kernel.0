From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Mon, 24 Feb 2014 12:43:52 +0900
Subject: [PATCH v7 0/3] Exynos 5410 support
Message-ID: <1393213435-20863-1-git-send-email-t.dakhran@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series of patches represent support of Exynos 5410 SoC

The Exynos 5410 is the first Samsung SoC based on bigLITTLE architecture

Patches add new platform description, support of clock controller and device 
tree for Exynos 5410.

Has been build on Linux Kernel v3.14-rc1 (Samsung kernel,
	for-next branch,
	commit aaeeda6f57833c7c0e16fef3d76205f36882c21b,
	"Merge branch 'v3.15-next/cleanup-samsung' into for-next")
Has been tested on Exynos 5410 reference board (exynos_defconfig)

I hope, this is enough clean and hasn't any dependencies to go through 
Samsung tree.

Tarek.

Changelog:

v7:
	small changes for resolving conflicts related to changes in 
	Samsung tree.

Tarek Dakhran (3):
  ARM: EXYNOS: Add support for EXYNOS5410 SoC
  clk: exynos5410: register clocks using common clock framework
  ARM: dts: Add initial device tree support for EXYNOS5410

 .../devicetree/bindings/clock/exynos5410-clock.txt |   54 +++++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   72 +++++++
 arch/arm/boot/dts/exynos5410.dtsi                  |  140 +++++++++++++
 arch/arm/mach-exynos/Kconfig                       |   10 +
 arch/arm/mach-exynos/common.c                      |   18 ++
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 +
 arch/arm/mach-exynos/platsmp.c                     |    2 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 arch/arm/plat-samsung/include/plat/map-s5p.h       |    3 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5410.c               |  208 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5410.h             |   32 +++
 14 files changed, 551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5410-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5410-smdk5410.dts
 create mode 100644 arch/arm/boot/dts/exynos5410.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5410.c
 create mode 100644 include/dt-bindings/clock/exynos5410.h

-- 
1.7.10.4
