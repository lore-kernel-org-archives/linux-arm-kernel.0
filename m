From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Mar 2015 23:26:25 +0100
Subject: ARM: SoC fixes for 3.20-rc3
Message-ID: <2980862.5zoRejcBRG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to bfda4031621b048ca634abc5f6bce1aa490ac4e5:

  MAINTAINERS: Add myself as co-maintainer to the legacy support of the mvebu SoCs (2015-03-13 22:11:19 +0100)

----------------------------------------------------------------
ARM: SoC fixes for 3.20-rc3

This is a rather unpleasantly large set of bug fixes for arm-soc,
Most of them because of cross-tree dependencies for Exynos
where we should have figured out the right path to merge things
before the merge window, and then the maintainer being unable to
sort things out in time during a business trip.

The other changes contained here are the usual collection:

MAINTAINERS file updates
 - Gregory Clement is now a co-maintainer for the legacy Marvell EBU
   platforms
 - A MAINTAINERS entry for the Freescale Vybrid platform that was
   added last year
 - Matt Porter no longer works as a maintainer on Broadcom SoCs

Build-time issues
 - A compile-time error for at91
 - Several minor DT fixes on at91, imx, exynos, socfpga, and omap
 - The new digicolor platform was not correctly enabled at all

Configuration issues
 - Two defconfig fix for regressions using USB on versatile
   express and on OMAP3
 - Enabling all 8 CPUs on Allwinner/SUNxi
 - Enabling the new STiH410 platform to be usable

Bug fixes in platform code
 - A missing barrier for socfpga
 - Fixing LPDDR1 self-refresh mode on at91
 - Fixing RTC interrupt numbers on Exynos3250
 - Fixing a cache-coherency issues in CPU power-down
   on Exynos5
 - Multiple small OMAP power management fixes

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: enable TWL4030_USB in omap2plus_defconfig

Alexander Stein (1):
      ARM: at91/dt: at91sam9263: Fixup sram1 device tree node

Alexandre Belloni (4):
      ARM: at91: pm: fix at91rm9200 standby
      ARM: at91: pm: fix SRAM allocation
      ARM: at91/defconfig: add at91rm9200 ethernet support
      ARM: at91: debug: fix non MMU debug

Andrzej Hajda (1):
      ARM: dts: add display power domain for exynos5250

Anthony Harivel (1):
      ARM: at91/defconfig: remove CONFIG_SYSFS_DEPRECATED

Arnd Bergmann (8):
      Merge tag 'samsung-fixes-dt' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'samsung-fixes-1' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'at91-fixes' of git://git.kernel.org/.../nferre/linux-at91 into fixes
      Merge tag 'socfpga_fixes_for_v4.0' of git://git.rocketboards.org/linux-socfpga-next into fixes
      Merge tag 'at91-fixes2' of git://git.kernel.org/.../nferre/linux-at91 into fixes
      Merge tag 'fixes-v4.0-rc2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'imx-fixes-4.0' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'at91-fixes3' of git://git.kernel.org/.../nferre/linux-at91 into fixes

Baruch Siach (1):
      ARM: digicolor: add the machine directory to Makefile

Boris BREZILLON (2):
      ARM: at91/dt: sama5d4: rename lcd_clk into lcdc_clk
      ARM: at91/dt: sama5d4: fix lcdck clock definition

Boris Brezillon (3):
      ARM: at91/dt: at91sam9261: fix clocks and clock-names in udc definition
      ARM: at91/dt: declare matrix node as a syscon device
      ARM: at91/dt: fix at91 udc compatible strings

Chanwoo Choi (1):
      ARM: EXYNOS: Fix wrong hwirq of RTC interrupt for Exynos3250 SoC

Dave Gerlach (2):
      ARM: dts: am33xx: fix SLEWCTRL_FAST pinctrl binding
      ARM: dts: am43xx: fix SLEWCTRL_FAST pinctrl binding

Fabrice GASNIER (1):
      ARM: STi: Add STiH410 SoC support

George McCollister (1):
      ARM: dts: am335x-lxm: Use rmii-clock-ext

Gregory CLEMENT (1):
      MAINTAINERS: Add myself as co-maintainer to the legacy support of the mvebu SoCs

Jonas Andersson (1):
      ARM: at91/dt: at91sam9260: fix usart pinctrl

Kishon Vijay Abraham I (1):
      ARM: DRA7: hwmod_data: Fix hwmod data for pcie

Krzysztof Kozlowski (1):
      ARM: EXYNOS: Don't use LDREX and STREX after disabling cache coherency

Lukasz Majewski (9):
      ARM: dts: Enable TMU for exynos4210-trats
      ARM: dts: Add LDO10 for TMU for exynos4412-odroid-common
      ARM: dts: Enable TMU for exynos4412-odriod-common
      ARM: dts: Adding CPU cooling binding for Exynos SoCs
      ARM: dts: add TMU default definitions for exynos4412
      ARM: dts: default trip points definition for exynos5420
      ARM: dts: define default thermal-zones for exynos4
      ARM: dts: Trip points and sensor configuration data for exynos5440
      ARM: dts: Provide dt bindings identical for Exynos TMU

Marek Szyprowski (6):
      dt-bindings: document a note about power domain subdomains
      ARM: EXYNOS: add support for sub-power domains
      ARM: dts: add hdmi related nodes for exynos4 SoCs
      ARM: dts: add dependency between TV and LCD0 power domains for exynos4
      ARM: dts: enable hdmi support for exynos4412-odroid-common
      ARM: dts: add 'hdmi' clock to mixer nodes for exynos5250 and exynos5420

Matt Porter (2):
      ARM: dts: am335x-bone-common: enable aes and sham
      MAINTAINERS: Remove self as ARM mach-bcm co-maintainer

Michel Marti (1):
      ARM: at91/dt: keep watchdog running in idle mode

Nicolas Ferre (2):
      ARM: at91/dt: sama5d4: add missing alias for i2c0
      ARM: at91/dt: fix USB high-speed clock to select UTMI

Patrice Vilchez (1):
      ARM: at91/pm: MOR register KEY was missing

Peter Chen (2):
      ARM: imx6qdl-sabresd: set swbst_reg as vbus's parent reg
      ARM: imx6sl-evk: set swbst_reg as vbus's parent reg

Peter Rosin (1):
      pm: at91: Workaround DDRSDRC self-refresh bug with LPDDR1 memories.

Peter Ujfalusi (1):
      ARM: omap2+: omap_hwmod: Set unique lock_class_key per hwmod

Ravikumar Kattekola (2):
      ARM: dts: DRA7x: Fix the bypass clock source for dpll_iva and others
      ARM: dts: OMAP5: Fix the bypass clock source for dpll_iva and others

Roger Quadros (2):
      ARM: dts: dra7x-evm: Don't use dcan1_rx.gpio1_15 in DCAN pinctrl
      ARM: dts: dra7x-evm: avoid possible contention while muxing on CAN lines

Russell King (1):
      ARM: socfpga: make sure socfpga_cpu1start_addr is properly flushed

Stefan Agner (1):
      MAINTAINERS: add Freescale Vybrid SoC

Steffen Trumtrar (1):
      ARM: socfpga: fix uart DMA binding error

Sudeep Holla (1):
      ARM: vexpress: update CONFIG_USB_ISP1760 option

Sylvain Rochet (2):
      pm: at91: pm_slowclock: fix suspend/resume hang up in timeouts
      dts: Documentation: AT91 Watchdog, explain what atmel,idle-halt property really do

Tero Kristo (3):
      ARM: OMAP2+: hwmod: fix deassert hardreset clkdm usecounting
      ARM: OMAP4+: PRM: fix omap4 version of prm_save_and_clear_irqen
      ARM: dts: OMAP5: fix polling intervals for thermal zones

Tomasz Stanislawski (1):
      ARM: dts: enable hdmi support for exynos4210-universal_c210

Tony Lindgren (2):
      Merge tag 'for-v4.0-rc/omap-fixes-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.0/fixes
      ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot

Tyler Baker (2):
      ARM: sunxi_defconfig: increase the number of maximum number of CPUs to 8
      ARM: multi_v7_defconfig: increase the number of maximum number of CPUs to 16

Vignesh R (2):
      ARM: dts: am33xx-clocks: Fix ehrpwm tbclk data on am33xx
      ARM: dts: am43xx-clocks: Fix ehrpwm tbclk data on am43xx

Vince Bridgers (1):
      ARM: socfpga: Correct SCU virtual mapping in socfpga

Wenyou Yang (1):
      ARM: at91: pm_slowclock: fix the compilation error

 .../bindings/arm/exynos/power_domain.txt           |   2 +
 Documentation/devicetree/bindings/arm/sti.txt      |   4 +
 .../devicetree/bindings/power/power_domain.txt     |  29 ++++++
 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   5 +
 MAINTAINERS                                        |  12 ++-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/am335x-bone-common.dtsi          |   8 ++
 arch/arm/boot/dts/am335x-bone.dts                  |   8 --
 arch/arm/boot/dts/am335x-lxm.dts                   |   4 +
 arch/arm/boot/dts/am33xx-clocks.dtsi               |   6 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  12 +--
 arch/arm/boot/dts/at91sam9260.dtsi                 |   7 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   9 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   5 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   3 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   1 -
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   5 +-
 arch/arm/boot/dts/dra7-evm.dts                     |  10 +-
 arch/arm/boot/dts/dra72-evm.dts                    |  10 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  90 ++++++++++++++++--
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  52 +++++++++++
 arch/arm/boot/dts/exynos4.dtsi                     |  45 +++++++++
 arch/arm/boot/dts/exynos4210-trats.dts             |  19 ++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  57 ++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  |  38 +++++++-
 arch/arm/boot/dts/exynos4212.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  64 +++++++++++++
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  24 +++++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  15 +++
 arch/arm/boot/dts/exynos4412.dtsi                  |   5 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |  12 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |  44 ++++++++-
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  35 +++++++
 arch/arm/boot/dts/exynos5420.dtsi                  |  33 ++++++-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  24 +++++
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      |  25 +++++
 arch/arm/boot/dts/exynos5440.dtsi                  |  18 ++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   2 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |   2 +
 arch/arm/boot/dts/omap5-core-thermal.dtsi          |   2 +-
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi           |   2 +-
 arch/arm/boot/dts/omap5.dtsi                       |   4 +
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |  41 +++++++-
 arch/arm/boot/dts/sama5d3.dtsi                     |   3 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   9 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   6 ++
 arch/arm/configs/at91_dt_defconfig                 |   1 +
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 arch/arm/configs/omap2plus_defconfig               |   1 +
 arch/arm/configs/sama5_defconfig                   |   2 -
 arch/arm/configs/sunxi_defconfig                   |   1 +
 arch/arm/configs/vexpress_defconfig                |   2 +-
 arch/arm/include/debug/at91.S                      |   5 +-
 arch/arm/mach-at91/pm.c                            |  22 ++---
 arch/arm/mach-at91/pm.h                            |   2 +-
 arch/arm/mach-at91/pm_slowclock.S                  |  80 +++++++++-------
 arch/arm/mach-exynos/platsmp.c                     |   3 +-
 arch/arm/mach-exynos/pm_domains.c                  |  28 ++++++
 arch/arm/mach-exynos/suspend.c                     |   4 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  10 +-
 arch/arm/mach-omap2/omap_hwmod.h                   |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 103 +++++----------------
 arch/arm/mach-omap2/pdata-quirks.c                 |   1 +
 arch/arm/mach-omap2/prm44xx.c                      |   4 +-
 arch/arm/mach-socfpga/core.h                       |   2 +-
 arch/arm/mach-socfpga/socfpga.c                    |   5 +
 arch/arm/mach-sti/board-dt.c                       |   1 +
 include/dt-bindings/pinctrl/am33xx.h               |   3 +-
 include/dt-bindings/pinctrl/am43xx.h               |   3 +-
 include/soc/at91/at91sam9_ddrsdr.h                 |   2 +-
 71 files changed, 882 insertions(+), 225 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
