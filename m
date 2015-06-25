From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Jun 2015 15:31:01 -0700
Subject: [GIT PULL 2/5] ARM: SoC: platform support for v4.2
In-Reply-To: <1435271464-11455-1-git-send-email-khilman@kernel.org>
References: <1435271464-11455-1-git-send-email-khilman@kernel.org>
Message-ID: <1435271464-11455-3-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our SoC branch usually contains expanded support for new SoCs and
other core platform code. Some highlights from this round:

- sunxi: SMP support for A23 SoC
- socpga: big-endian support
- pxa: conversion to common clock framework
- bcm: SMP support for BCM63138
- imx: support new I.MX7D SoC
- zte: basic support for ZX296702 SoC

Conflicts:
	arch/arm/mach-socfpga/core.h

Trivial remove/remove conflict with our cleanup branch.
Resolution: remove both sides

----------------------------------------------------------------

The following changes since commit 8d2977bf36bf6fc66d0c8e64263711cc2f0c1e4b:

  Merge tag 'armsoc-cleanup' into test-merge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to 2879e43f09122f8b3ef5456e3d7e48716b086e60:

  Merge tag 'omap-for-v4.2/soc-pt1-take2' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/soc

----------------------------------------------------------------

Alan Tull (1):
      ARM: socfpga: support suspend to ram

Anson Huang (3):
      ARM: imx: using unsigned variable for do_div
      ARM: imx7d: add low level debug uart support
      ARM: imx: add msl support for imx7d

Arnd Bergmann (17):
      Merge tag 'sunxi-core-for-4.2' of https://git.kernel.org/.../mripard/linux into next/soc
      Merge tag 'socfpga_updates_for_v4.2' of git://git.kernel.org/.../dinguyen/linux into next/soc
      Merge tag 'tegra-for-4.2-soc' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'rpi-soc-for-armsoc-v4.2' of git://git.kernel.org/.../rpi/linux-rpi into next/soc
      Merge tag 'pxa-for-4.2' of https://github.com/rjarzmik/linux into next/soc
      ARM: uniphier: only select TWD for SMP
      Merge tag 'zynq-soc-for-4.2' of https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'arm-soc/for-4.2/maintainers' of http://github.com/broadcom/stblinux into next/soc
      Merge branch 'irq/for-arm' of git://git.kernel.org/.../tip/tip into next/soc
      Merge tag 'arm-soc/for-4.2/soc-take2' of http://github.com/broadcom/stblinux into next/soc
      Merge tag 'omap-for-v4.2/omap1-v2' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      ARM: zx: fix building with CONFIG_THUMB2_KERNEL
      ARM: shmobile: only select sound drivers that build
      Merge tag 'renesas-soc-for-v4.2' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'arm-soc/for-4.2/soc-part2' of http://github.com/broadcom/stblinux into next/soc
      ARM: imx: make imx51/3 suspend optional
      ARM: imx: imx7d requires anatop

Bartlomiej Zolnierkiewicz (5):
      ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
      ARM: EXYNOS: make exynos_core_restart() less verbose
      ARM: EXYNOS: add exynos_set_boot_addr() helper
      ARM: EXYNOS: add exynos_get_boot_addr() helper
      ARM: EXYNOS: add coupled cpuidle support for Exynos3250

Ben Dooks (3):
      ARM: debug: fix big endian operation for 8250 word mode
      ARM: socfpga: enable big endian for secondary core(s)
      ARM: socfpga: support big endian for socfpga

Bintian Wang (1):
      arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig

Brian Norris (1):
      MAINTAINERS: add brcmstb regex

Chen-Yu Tsai (1):
      ARM: sun8i: Add SMP support for the Allwinner A23

Dan Carpenter (1):
      ARM: BCM63xx: fix an error path in bcm63xx_pmb_power_on_cpu()

Dave Gerlach (1):
      ARM: OMAP: AM43xx hwmod: Add data for am43xx emif hwmod

David Riley (1):
      soc/tegra: pmc: move to using a restart handler

Dinh Nguyen (5):
      ARM: socfpga: Add support for UART1 debug uart for earlyprintk
      ARM: socfpga: remove the need to map uart_io_desc
      ARM: socfpga: use of_iomap to map the SCU
      ARM: socfpga: use CPU_METHOD_OF_DECLARE for socfpga_cyclone5
      ARM: socfpga: add CPU_METHOD_OF_DECLARE for Arria 10

Dmitry Osipenko (1):
      ARM: tegra20: Store CPU "resettable" status in IRAM

Eric Anholt (3):
      ARM: bcm2835: Skip doing our own iotable_init() initialization
      ARM: bcm2835: Drop the init_irq() hook
      ARM: bcm2835: Move the restart/power_off handling to the WDT driver

Fabio Estevam (2):
      clk: imx: clk-cpu: Include "clk.h" header file
      ARM: imx: mmdc: Include "common.h" header file

Florian Fainelli (5):
      ARM: BCM63xx: Add Broadcom BCM63xx PMB controller helpers
      ARM: BCM63xx: Add secondary CPU PMB initialization sequence
      ARM: vfp: Add include guards
      ARM: vfp: Add vfp_disable for problematic platforms
      ARM: BCM63xx: Add SMP support for BCM63138

Frank Li (3):
      dt-bindings: add imx7d clock ID definitions
      ARM: clk: imx: update pllv3 to support imx7
      ARM: imx: add imx7d clk tree support

Gregory Fong (2):
      ARM: brcmstb: Select ARCH_WANT_OPTIONAL_GPIOLIB
      ARM: brcmstb: Add default gpio number

Joachim Eastwood (3):
      ARM: lpc18xx: add basic support for NXP LPC18xx/43xx SoCs
      MAINTAINERS: Add entry for NXP LPC18xx/43xx MCUs
      ARM: lpc18xx: define low-level debug symbol for LPC18xx/43xx

Joe Perches (1):
      ARM: mach-imx: iomux-imx31: Use DECLARE_BITMAP

Josh Cartwright (2):
      ARM: zynq: Use restart_handler mechanism for slcr reset
      ARM: zynq: Drop use of slcr_unlock in zynq_slcr_system_restart

Jun Nie (8):
      ARM: zx: add basic support for ZTE ZX296702
      ARM: zx: add low level debug support for zx296702
      ARM: zx: enable SMP and hotplug for zx296702
      MAINTAINERS: add entry for ARM ZTE architecture
      dt-bindings: Add #defines for ZTE ZX296702 clocks
      clk: zx: add clock support to zx296702
      ARM: dts: zx: add an initial zx296702 dts and doc
      ARM: zx: Add basic defconfig support for ZX296702

Kevin Cernekee (1):
      bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties

Kevin Hilman (8):
      Merge branch 'socfpga/soc' into next/soc
      Merge tag 'imx-soc-4.2' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'hi6220-soc-for-4.2' of git://github.com/hisilicon/linux-hisi into next/soc
      Merge tag 'samsung-mach-1' of git://git.kernel.org/.../kgene/linux-samsung into next/soc
      ARM: socfpga: fix build error due to secondary_startup
      Merge branch 'socfpga/soc' into next/soc
      Merge branch 'zte/soc' into next/soc
      Merge tag 'omap-for-v4.2/soc-pt1-take2' of git://git.kernel.org/.../tmlind/linux-omap into next/soc

Krzysztof Kozlowski (9):
      ARM: pxa: Constify irq_domain_ops
      ARM: imx: Constify irq_domain_ops
      ARM: EXYNOS: Handle of of_iomap() failure
      ARM: EXYNOS: Handle of_find_device_by_node() and kstrdup() failures
      ARM: EXYNOS: Add missing of_node_put() when parsing power domains
      ARM: EXYNOS: Get current parent clock for power domain on/off
      ARM: EXYNOS: Constify irq_domain_ops
      ARM: SAMSUNG: Constify platform_device_id
      MAINTAINERS: ARM64: EXYNOS: Extend entry for ARM64 DTS

Marek Szyprowski (2):
      ARM: EXYNOS: use PS_HOLD based poweroff for all supported SoCs
      ARM: EXYNOS: register power domain driver from core_initcall

Martin Fuzzey (1):
      ARM: imx53: Set DDR pins to high impedance when in suspend to RAM.

Masahiro Yamada (2):
      ARM: UniPhier: add basic support for UniPhier architecture
      MAINTAINERS: add myself as ARM/UniPhier maintainer

Maxime Coquelin (3):
      ARM: Add STM32 family machine
      MAINTAINERS: Add entry for STM32 MCUs
      ARM: Kconfig: Select clocksource in STM32 entry

Mika Westerberg (1):
      ARM: ep93xx: simone: support for SPI-based MMC/SD cards

Mirza Krak (1):
      ARM: imx: clk-v610: Add clock for I2C2 and I2C3

Nicholas Mc Guire (1):
      soc/tegra: Watch wait_for_completion_timeout() return type

Pali Roh?r (2):
      ARM: OMAP2+: Return correct error values from device and hwmod
      ARM: OMAP3: Fix crypto support for HS devices

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Ignore another (BCM4709 specific) fault code

Ray Jui (1):
      ARM: BCM: Enable NAND support for iProc SoCs

Robert Jarzmik (7):
      ARM: pxa: change clocks init sequence
      ARM: pxa: move gpio11 clock to board files
      clk: pxa: add missing pxa27x clocks for Irda and sa1100-rtc
      ARM: pxa: pxa27x skip default device initialization with DT
      ARM: pxa: Transition pxa25x and pxa27x to clk framework
      ARM: pxa: convert eseries to clock framework
      ARM: pxa: Transition pxa25x, pxa27x, pxa3xx to clk framework

Sergiy Kibrik (1):
      ARM: SAMSUNG: fix clk_enable() WARNing in S3C24XX ADC

Shawn Guo (27):
      ARM: imx: use dynamic mapping for timer
      ARM: imx: use dynamic mapping for CCM
      ARM: imx: move revision definitions and declarations into a header
      ARM: imx5: let pm code map CCM block on its own
      ARM: imx6: set initial power mode in pm function
      ARM: imx6: let pm code map CCM block on its own
      ARM: imx6: do not use cpu_is_xxx() in clock driver
      ARM: imx: add clk-pllv1 type support
      ARM: imx: remove inclusions of platform headers
      ARM: imx: move clock drivers into drivers/clk
      MAINTAINERS: add new folders into IMX entry
      ARM: imx: drop epit timer initialization from imx35 clock driver
      ARM: imx6: initialize CCM_CLPCR_LPM into RUN mode earlier
      ARM: imx: use relaxed IO accessor in timer driver
      ARM: imx: move timer resources into a structure
      ARM: imx: define an enum for gpt timer device type
      ARM: imx: initialize gpt device type for DT boot
      ARM: imx: setup tctl register in device specific function
      ARM: imx: set up .set_next_event hook via imx_gpt_data
      ARM: imx: move clock event variables into imx_timer
      ARM: imx: define gpt register offset per device type
      ARM: imx: get rid of variable timer_base
      ARM: imx: provide gpt device specific irq functions
      ARM: imx: remove platform headers from timer driver
      ARM: imx: move timer driver into drivers/clocksource
      clocksource: timer-imx-gpt: remove include of <asm/mach/time.h>
      MAINTAINERS: update Shawn's email to use kernel.org one

Shenwei Wang (2):
      ARM: imx: Remove the duplicated function declaration
      ARM: imx: Correct the comments in time.c

Stefan Agner (10):
      irqdomain: Add non-hierarchy helper irq_domain_set_info
      genirq: Add irq_chip_(enable/disable)_parent
      genirq: generic chip: Support hierarchy domain
      irqchip: nvic: Support hierarchy irq domain
      irqchip: vf610-mscm: Support NVIC parent chip
      ARM: unify MMU/!MMU addruart calls
      ARM: introduce ARM_SINGLE_ARMV7M for ARMv7-M platforms
      ARM: vf610: enable Cortex-M4 configuration on Vybrid SoC
      ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
      ARM: imx: clk-vf610: enable debug access port by default

S?bastien Szymanski (1):
      ARM: clk-imx6q: refine sata's parent

Tony Lindgren (8):
      ARM: OMAP1: Move UART defines to prepare for sparse IRQ
      ARM: OMAP1: Switch to use generic irqchip in preparation for sparse IRQ
      ARM: omap1: Switch to use MULTI_IRQ
      ARM: OMAP1: Change interrupt numbering for sparse IRQ
      ARM: OMAP1: Fix randconfig builds if ARCH_OMAP15XX not selected
      ARM: OMAP1: Fix section mismatch warnings for omap_cfg_reg
      memory: omap-gpmc: Add Kconfig option for debug
      Merge tag 'for-v4.2/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.2/soc


 Documentation/arm/stm32/overview.txt            |  32 +
 Documentation/arm/stm32/stm32f429-overview.txt  |  22 +
 Documentation/devicetree/bindings/arm/cpus.txt  |   1 +
 .../bindings/arm/exynos/power_domain.txt        |   7 +-
 Documentation/devicetree/bindings/arm/fsl.txt   |   3 +
 Documentation/devicetree/bindings/arm/zte.txt   |  15 +
 .../devicetree/bindings/clock/zx296702-clk.txt  |  35 +
 .../devicetree/bindings/serial/pl011.txt        |   2 +-
 .../devicetree/bindings/vendor-prefixes.txt     |   1 +
 MAINTAINERS                                     |  38 +-
 arch/arm/Kconfig                                |  72 +-
 arch/arm/Kconfig.debug                          |  66 +-
 arch/arm/Makefile                               |   4 +
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/zx296702-ad1.dts              |  48 ++
 arch/arm/boot/dts/zx296702.dtsi                 | 139 +++
 arch/arm/configs/efm32_defconfig                |   1 +
 arch/arm/configs/zx_defconfig                   | 129 +++
 arch/arm/include/asm/firmware.h                 |   4 +
 arch/arm/include/asm/vfp.h                      |   9 +
 arch/arm/include/debug/8250.S                   |   3 +
 arch/arm/include/debug/efm32.S                  |   2 +-
 arch/arm/include/debug/imx-uart.h               |  15 +-
 arch/arm/include/debug/pl01x.S                  |   7 +
 arch/arm/kernel/debug.S                         |   2 +-
 arch/arm/mach-bcm/Kconfig                       |   2 +
 arch/arm/mach-bcm/Makefile                      |   7 +-
 arch/arm/mach-bcm/bcm63xx_headsmp.S             |  23 +
 arch/arm/mach-bcm/bcm63xx_pmb.c                 | 221 +++++
 arch/arm/mach-bcm/bcm63xx_smp.c                 | 169 ++++
 arch/arm/mach-bcm/bcm63xx_smp.h                 |   9 +
 arch/arm/mach-bcm/bcm_5301x.c                   |   9 +-
 arch/arm/mach-bcm/board_bcm2835.c               |  91 --
 arch/arm/mach-ep93xx/simone.c                   | 135 ++-
 arch/arm/mach-exynos/common.h                   |   4 +-
 arch/arm/mach-exynos/exynos.c                   |   3 +-
 arch/arm/mach-exynos/firmware.c                 |  18 +
 arch/arm/mach-exynos/platsmp.c                  |  86 +-
 arch/arm/mach-exynos/pm.c                       |  51 +-
 arch/arm/mach-exynos/pm_domains.c               |  53 +-
 arch/arm/mach-exynos/pmu.c                      |   6 +-
 arch/arm/mach-exynos/suspend.c                  |   2 +-
 arch/arm/mach-imx/Kconfig                       |  49 +-
 arch/arm/mach-imx/Makefile                      |  31 +-
 arch/arm/mach-imx/Makefile.boot                 |   0
 arch/arm/mach-imx/anatop.c                      |   5 +-
 arch/arm/mach-imx/common.h                      |  15 +-
 arch/arm/mach-imx/cpu.c                         |   3 +
 arch/arm/mach-imx/cpuidle-imx6q.c               |   4 +-
 arch/arm/mach-imx/cpuidle-imx6sl.c              |   4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c              |   4 +-
 arch/arm/mach-imx/gpc.c                         |   2 +-
 arch/arm/mach-imx/hardware.h                    |   1 +
 arch/arm/mach-imx/iomux-imx31.c                 |   2 +-
 arch/arm/mach-imx/mach-imx6q.c                  |   1 +
 arch/arm/mach-imx/mach-imx6sl.c                 |   1 +
 arch/arm/mach-imx/mach-imx6sx.c                 |   1 +
 arch/arm/mach-imx/mach-imx7d.c                  |  43 +
 arch/arm/mach-imx/mach-vf610.c                  |   1 +
 arch/arm/mach-imx/mmdc.c                        |   2 +
 arch/arm/mach-imx/mx27.h                        |   4 -
 arch/arm/mach-imx/mx3x.h                        |   7 -
 arch/arm/mach-imx/mxc.h                         |  24 +-
 arch/arm/mach-imx/pm-imx5.c                     | 205 ++++-
 arch/arm/mach-imx/pm-imx6.c                     |  38 +-
 arch/arm/mach-imx/suspend-imx53.S               | 139 +++
 arch/arm/mach-imx/time.c                        | 385 ---------
 arch/arm/mach-lpc18xx/Makefile                  |   1 +
 arch/arm/mach-lpc18xx/Makefile.boot             |   3 +
 arch/arm/mach-lpc18xx/board-dt.c                |  22 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S     |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c           |   1 +
 arch/arm/mach-omap1/board-fsample.c             |   1 +
 arch/arm/mach-omap1/board-generic.c             |   1 +
 arch/arm/mach-omap1/board-h2.c                  |   1 +
 arch/arm/mach-omap1/board-h3-mmc.c              |   1 +
 arch/arm/mach-omap1/board-h3.c                  |   1 +
 arch/arm/mach-omap1/board-htcherald.c           |   1 +
 arch/arm/mach-omap1/board-innovator.c           |   1 +
 arch/arm/mach-omap1/board-nokia770.c            |   1 +
 arch/arm/mach-omap1/board-osk.c                 |   1 +
 arch/arm/mach-omap1/board-palmte.c              |   1 +
 arch/arm/mach-omap1/board-palmtt.c              |   1 +
 arch/arm/mach-omap1/board-palmz71.c             |   1 +
 arch/arm/mach-omap1/board-perseus2.c            |   1 +
 arch/arm/mach-omap1/board-sx1.c                 |   1 +
 arch/arm/mach-omap1/board-voiceblue.c           |   1 +
 arch/arm/mach-omap1/common.h                    |   7 +-
 arch/arm/mach-omap1/dma.c                       |   2 +-
 arch/arm/mach-omap1/gpio16xx.c                  |   2 +
 arch/arm/mach-omap1/gpio7xx.c                   |   2 +
 arch/arm/mach-omap1/i2c.c                       |   3 +-
 arch/arm/mach-omap1/include/mach/entry-macro.S  |  39 -
 arch/arm/mach-omap1/include/mach/irqs.h         | 124 ++-
 arch/arm/mach-omap1/include/mach/memory.h       |   4 +-
 arch/arm/mach-omap1/include/mach/serial.h       |   5 -
 arch/arm/mach-omap1/include/mach/soc.h          |   4 +
 arch/arm/mach-omap1/irq.c                       | 157 ++--
 arch/arm/mach-omap1/mux.c                       |   8 +-
 arch/arm/mach-omap1/pm.c                        |   1 +
 arch/arm/mach-omap1/serial.c                    |   1 +
 arch/arm/mach-omap1/timer.c                     |   4 +-
 arch/arm/mach-omap2/omap_device.c               |  30 +-
 arch/arm/mach-omap2/omap_hwmod.c                |  10 +-
 arch/arm/mach-omap2/omap_hwmod.h                |   6 +
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c   |  12 +-
 .../omap_hwmod_33xx_43xx_common_data.h          |   1 +
 .../omap_hwmod_33xx_43xx_ipblock_data.c         |  16 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c      |  13 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      | 119 ++-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |  22 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      |  11 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |   4 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      |   2 +
 arch/arm/mach-omap2/prcm43xx.h                  |   2 +
 arch/arm/mach-pxa/Makefile                      |   9 +-
 arch/arm/mach-pxa/clock-pxa2xx.c                |  55 --
 arch/arm/mach-pxa/clock-pxa3xx.c                | 212 -----
 arch/arm/mach-pxa/clock.c                       |  86 --
 arch/arm/mach-pxa/clock.h                       |  80 --
 arch/arm/mach-pxa/eseries.c                     |  27 +-
 arch/arm/mach-pxa/generic.c                     |   6 +
 arch/arm/mach-pxa/generic.h                     |   3 +
 arch/arm/mach-pxa/irq.c                         |   2 +-
 arch/arm/mach-pxa/lubbock.c                     |   4 +-
 arch/arm/mach-pxa/pxa25x.c                      | 183 ----
 arch/arm/mach-pxa/pxa27x.c                      | 182 +---
 arch/arm/mach-pxa/pxa300.c                      |  20 +-
 arch/arm/mach-pxa/pxa320.c                      |  10 -
 arch/arm/mach-pxa/pxa3xx.c                      |  59 --
 arch/arm/mach-pxa/raumfeld.c                    |   1 -
 arch/arm/mach-pxa/tosa.c                        |   1 -
 arch/arm/mach-shmobile/Kconfig                  |   4 +-
 arch/arm/mach-socfpga/Kconfig                   |  11 +-
 arch/arm/mach-socfpga/Makefile                  |   1 +
 arch/arm/mach-socfpga/core.h                    |  11 +-
 arch/arm/mach-socfpga/headsmp.S                 |   5 +-
 arch/arm/mach-socfpga/platsmp.c                 |  57 +-
 arch/arm/mach-socfpga/pm.c                      | 149 ++++
 arch/arm/mach-socfpga/self-refresh.S            | 136 +++
 arch/arm/mach-socfpga/socfpga.c                 |  41 +-
 arch/arm/mach-stm32/Makefile                    |   1 +
 arch/arm/mach-stm32/Makefile.boot               |   3 +
 arch/arm/mach-stm32/board-dt.c                  |  19 +
 arch/arm/mach-sunxi/platsmp.c                   |  69 ++
 arch/arm/mach-tegra/cpuidle-tegra20.c           |   5 +-
 arch/arm/mach-tegra/reset-handler.S             |  10 +-
 arch/arm/mach-tegra/reset.h                     |   4 +
 arch/arm/mach-tegra/sleep-tegra20.S             |  37 +-
 arch/arm/mach-tegra/sleep.h                     |   4 +
 arch/arm/mach-tegra/tegra.c                     |   1 -
 arch/arm/mach-uniphier/Kconfig                  |  11 +
 arch/arm/mach-uniphier/Makefile                 |   2 +
 arch/arm/mach-uniphier/platsmp.c                |  90 ++
 arch/arm/mach-uniphier/uniphier.c               |  30 +
 arch/arm/mach-zx/Kconfig                        |  18 +
 arch/arm/mach-zx/Makefile                       |   2 +
 arch/arm/mach-zx/core.h                         |  19 +
 arch/arm/mach-zx/headsmp.S                      |  33 +
 arch/arm/mach-zx/platsmp.c                      | 189 ++++
 arch/arm/mach-zx/zx296702.c                     |  25 +
 arch/arm/mach-zynq/common.c                     |   6 -
 arch/arm/mach-zynq/common.h                     |   1 -
 arch/arm/mach-zynq/slcr.c                       |  28 +-
 arch/arm/plat-omap/dma.c                        |   4 +
 arch/arm/plat-samsung/adc.c                     |   6 +-
 arch/arm/vfp/vfpmodule.c                        |  13 +
 arch/arm64/Kconfig                              |   5 +
 arch/arm64/configs/defconfig                    |   1 +
 drivers/bus/brcmstb_gisb.c                      |  13 +-
 drivers/clk/Makefile                            |   2 +
 drivers/clk/imx/Makefile                        |  26 +
 .../arm/mach-imx => drivers/clk/imx}/clk-busy.c |   0
 .../arm/mach-imx => drivers/clk/imx}/clk-cpu.c  |   1 +
 .../clk/imx}/clk-fixup-div.c                    |   0
 .../clk/imx}/clk-fixup-mux.c                    |   0
 .../clk/imx}/clk-gate-exclusive.c               |   0
 .../mach-imx => drivers/clk/imx}/clk-gate2.c    |   0
 .../arm/mach-imx => drivers/clk/imx}/clk-imx1.c |  17 +-
 .../mach-imx => drivers/clk/imx}/clk-imx21.c    |  14 +-
 .../mach-imx => drivers/clk/imx}/clk-imx25.c    |   6 +-
 .../mach-imx => drivers/clk/imx}/clk-imx27.c    |  15 +-
 .../mach-imx => drivers/clk/imx}/clk-imx31.c    |  35 +-
 .../mach-imx => drivers/clk/imx}/clk-imx35.c    |  36 +-
 .../clk/imx}/clk-imx51-imx53.c                  |   5 +-
 .../mach-imx => drivers/clk/imx}/clk-imx6q.c    |  36 +-
 .../mach-imx => drivers/clk/imx}/clk-imx6sl.c   |   7 -
 .../mach-imx => drivers/clk/imx}/clk-imx6sx.c   |   6 -
 drivers/clk/imx/clk-imx7d.c                     | 860 +++++++++++++++++++
 .../arm/mach-imx => drivers/clk/imx}/clk-pfd.c  |   0
 .../mach-imx => drivers/clk/imx}/clk-pllv1.c    |  33 +-
 .../mach-imx => drivers/clk/imx}/clk-pllv2.c    |   0
 .../mach-imx => drivers/clk/imx}/clk-pllv3.c    |  13 +-
 .../mach-imx => drivers/clk/imx}/clk-vf610.c    |   4 +
 {arch/arm/mach-imx => drivers/clk/imx}/clk.c    |   0
 {arch/arm/mach-imx => drivers/clk/imx}/clk.h    |  14 +-
 drivers/clk/pxa/clk-pxa27x.c                    |  32 +-
 drivers/clk/zte/Makefile                        |   2 +
 drivers/clk/zte/clk-pll.c                       | 172 ++++
 drivers/clk/zte/clk-zx296702.c                  | 657 ++++++++++++++
 drivers/clk/zte/clk.h                           |  32 +
 drivers/clocksource/Kconfig                     |   6 +
 drivers/clocksource/Makefile                    |   1 +
 drivers/clocksource/timer-imx-gpt.c             | 540 ++++++++++++
 drivers/irqchip/Kconfig                         |   1 +
 drivers/irqchip/irq-nvic.c                      |  28 +-
 drivers/irqchip/irq-vf610-mscm-ir.c             |  23 +-
 drivers/memory/Kconfig                          |   8 +
 drivers/memory/omap-gpmc.c                      |   6 +-
 drivers/soc/tegra/fuse/fuse-tegra20.c           |   6 +-
 drivers/soc/tegra/pmc.c                         |  23 +-
 drivers/watchdog/bcm2835_wdt.c                  |  62 ++
 include/dt-bindings/clock/imx7d-clock.h         | 450 ++++++++++
 include/dt-bindings/clock/vf610-clock.h         |   3 +-
 include/dt-bindings/clock/zx296702-clock.h      | 170 ++++
 include/linux/irq.h                             |   2 +
 include/linux/irqdomain.h                       |   8 +-
 include/linux/reset/bcm63xx_pmb.h               |  88 ++
 include/soc/imx/revision.h                      |  37 +
 include/soc/imx/timer.h                         |  26 +
 include/soc/tegra/pmc.h                         |   2 -
 include/uapi/linux/serial_reg.h                 |   3 +
 kernel/irq/chip.c                               |  28 +
 kernel/irq/generic-chip.c                       |   5 +-
 kernel/irq/irqdomain.c                          |  21 +
 225 files changed, 6675 insertions(+), 2075 deletions(-)
 create mode 100644 Documentation/arm/stm32/overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
 create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
 create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
 create mode 100644 arch/arm/boot/dts/zx296702.dtsi
 create mode 100644 arch/arm/configs/zx_defconfig
 create mode 100644 arch/arm/mach-bcm/bcm63xx_headsmp.S
 create mode 100644 arch/arm/mach-bcm/bcm63xx_pmb.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.c
 create mode 100644 arch/arm/mach-bcm/bcm63xx_smp.h
 create mode 100644 arch/arm/mach-imx/Makefile.boot
 create mode 100644 arch/arm/mach-imx/mach-imx7d.c
 create mode 100644 arch/arm/mach-imx/suspend-imx53.S
 delete mode 100644 arch/arm/mach-imx/time.c
 create mode 100644 arch/arm/mach-lpc18xx/Makefile
 create mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 create mode 100644 arch/arm/mach-lpc18xx/board-dt.c
 delete mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
 delete mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/clock.c
 delete mode 100644 arch/arm/mach-pxa/clock.h
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S
 create mode 100644 arch/arm/mach-stm32/Makefile
 create mode 100644 arch/arm/mach-stm32/Makefile.boot
 create mode 100644 arch/arm/mach-stm32/board-dt.c
 create mode 100644 arch/arm/mach-uniphier/Kconfig
 create mode 100644 arch/arm/mach-uniphier/Makefile
 create mode 100644 arch/arm/mach-uniphier/platsmp.c
 create mode 100644 arch/arm/mach-uniphier/uniphier.c
 create mode 100644 arch/arm/mach-zx/Kconfig
 create mode 100644 arch/arm/mach-zx/Makefile
 create mode 100644 arch/arm/mach-zx/core.h
 create mode 100644 arch/arm/mach-zx/headsmp.S
 create mode 100644 arch/arm/mach-zx/platsmp.c
 create mode 100644 arch/arm/mach-zx/zx296702.c
 create mode 100644 drivers/clk/imx/Makefile
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-busy.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-cpu.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-div.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-fixup-mux.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate-exclusive.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-gate2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx1.c (91%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx21.c (95%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx25.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx27.c (97%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx31.c (91%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx35.c (94%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx51-imx53.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6q.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sl.c (99%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-imx6sx.c (99%)
 create mode 100644 drivers/clk/imx/clk-imx7d.c
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pfd.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv1.c (75%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv2.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-pllv3.c (96%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk-vf610.c (98%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.c (100%)
 rename {arch/arm/mach-imx => drivers/clk/imx}/clk.h (94%)
 create mode 100644 drivers/clk/zte/Makefile
 create mode 100644 drivers/clk/zte/clk-pll.c
 create mode 100644 drivers/clk/zte/clk-zx296702.c
 create mode 100644 drivers/clk/zte/clk.h
 create mode 100644 drivers/clocksource/timer-imx-gpt.c
 create mode 100644 include/dt-bindings/clock/imx7d-clock.h
 create mode 100644 include/dt-bindings/clock/zx296702-clock.h
 create mode 100644 include/linux/reset/bcm63xx_pmb.h
 create mode 100644 include/soc/imx/revision.h
 create mode 100644 include/soc/imx/timer.h
