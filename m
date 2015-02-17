From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Feb 2015 00:33:24 -0800
Subject: [GIT PULL 3/7] ARM: SoC platform changes
In-Reply-To: <1424162008-23768-1-git-send-email-olof@lixom.net>
References: <1424162008-23768-1-git-send-email-olof@lixom.net>
Message-ID: <1424162008-23768-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New and updated SoC support. Also included are some cleanups where the
platform maintainers hadn't separated cleanups from new developent in
separate branches.

Some of the larger things worth pointing out:

- A large set of changes from Alexandre Belloni and Nicolas Ferre
preparing at91 platforms for multiplatform and cleaning up quite a
bit in the process.
- Removal of CSR's "Marco" SoC platform that never made it out to the
market. We love seeing these since it means the vendor published
support before product was out, which is exactly what we want!

New platforms this release are:

- Conexant Digicolor (CX92755 SoC)
- Hisilicon HiP01 SoC
- CSR/sirf Atlas7 SoC


Conflicts:

arch/arm/Kconfig.debug: add/add: NETX, SIRFSOC and DIGICOLOR_UA0 are new

----------------------------------------------------------------

The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/soc-for-linus

for you to fetch changes up to df1a66812535e04bfd960e15d5be4893853b6730:

  Merge tag 'at91-soc4' of git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91 into next/soc

----------------------------------------------------------------

Aida Mynzhasova (1):
      ARM: OMAP2+: Add clock domain support for dm816x

Alexander Stein (1):
      ARM: at91/dt: sam9263: Fix typo: ac91_clk -> ac97_clk

Alexandre Belloni (27):
      ARM: at91: Add Special Function Registers binding documentation
      ARM: at91: sama5d3: Add SFR
      ARM: at91: sama5d4: Add SFR
      ARM: at91/dt: at91sam9n12: Add RTC node
      ARM: at91/dt: rm9200: add RTC node
      ARM: at91/dt: at91rm9200ek: enable RTC
      ARM: at91/dt: add SRAM nodes
      ARM: at91/dt: Add a dtsi for at91sam9xe
      ARM: at91/dt: ethernut5: use at91sam9xe.dtsi
      ARM: at91: pm: rework cpu detection
      ARM: at91: pm: use the mmio-sram pool to access SRAM
      ARM: at91: pm: add UDP and UHP checks to newer SoCs
      ARM: at91: pm: prepare for multiplatform
      ARM: at91: remove useless map_io
      ARM: at91: sama5d4: remove useless call to at91_init_sram
      ARM: at91: remove unused at91_init_sram
      ARM: at91: move at91rm9200_idle() to clk/at91/pmc.c
      ARM: at91: mark const init data with __initconst instead of __initdata
      ARM: at91: fix sam9n12 and sam9x5 arm_pm_idle
      ARM: at91: sam9: set arm_pm_idle from sam9_dt_device_init
      ARM: at91: stop using HAVE_AT91_DBGUx
      ARM: at91: remove unused mach/system_rev.h
      ARM: at91: pm: remove warning to remove SOC_AT91SAM9263 usage
      ARM: at91: at91rm9200: set idle and restart from rm9200_dt_device_init()
      ARM: at91: merge all SOC_AT91SAM9xxx
      ARM: at91: remove at91_boot_soc
      ARM: at91: remove at91_dt_initialize and machine init_early()

Andrew Lunn (1):
      Merge branch 'mvebu/fixes-3' into mvebu/soc

Andy Gross (1):
      MAINTAINERS: Add co-maintainer for ARM/Qualcomm Support

Anson Huang (3):
      ARM: imx: correct the hardware clock gate setting for shared nodes
      ARM: imx: remove unnecessary setting for DSM
      ARM: imx: support arm power off in cpuidle for i.mx6sx

Barry Song (4):
      ARM: sirf: drop Marco low-level debug port
      ARM: sirf: drop Marco support in reset controller module
      ARM: sirf: drop Marco machine
      ARM: sirf: move to debug_ll_io_init and drop map_io

Baruch Siach (3):
      ARM: initial support for Conexant Digicolor CX92755 SoC
      ARM: digicolor: add low level debug support
      ARM: digicolor: select syscon and timer

Bhuvanchandra DV (1):
      ARM: imx: clk-vf610: Add clock for UART4 and UART5

Bo Shen (3):
      ARM: at91: dts: sama5d3: split isi pinctrl
      ARM: at91: dts: sama5d3: add missing pins of isi
      ARM: at91: dts: sama5d3: move the isi mck pin to mb

Brian Norris (1):
      ARM: brcmstb: update CPU power management sequence

Chanwoo Choi (1):
      ARM: EXYNOS: Add exynos3250 suspend-to-ram support

Chen-Yu Tsai (1):
      ARM: sunxi: Register cpufreq-dt for sun[45678]i

Chris Zhong (2):
      ARM: rockchip: add suspend and resume for RK3288
      ARM: rockchip: Add pmu-sram binding

Geert Uytterhoeven (7):
      ARM: shmobile: sh73a0 legacy/reference: Add missing INTCA0 clock for irqpin module
      ARM: shmobile: R-Mobile: Use generic_pm_domain.attach_dev() for pm_clk setup
      ARM: shmobile: R-Mobile: Store SYSC base address in rmobile_pm_domain
      ARM: shmobile: R-Mobile: Add DT support for PM domains
      ARM: shmobile: R-Mobile: Consolidate rmobile_pd_suspend_*()
      ARM: shmobile: R-Mobile: Generalize adding/looking up special PM domains
      ARM: shmobile: R-Mobile: Special-case PM domains with memory-controllers

Gregory CLEMENT (1):
      ARM: mvebu: Update the SoC ID and revision definitions

Guo Zeng (1):
      ARM: sirf: add two debug ports for CSRatlas7 SoC

Hans de Goede (1):
      ARM: sunxi: Add "allwinner,sun6i-a31s" to mach-sunxi

Heiko Stuebner (1):
      ARM: rockchip: remove cpu-core name from machine name

Josh Wu (5):
      ARM: at91/dt: sama5d3: enable D2 as the heartbeat LED
      ARM: at91: dts: sama5d3: add isi clock
      ARM: at91: dts: sama5d3: change name of pinctrl_isi_{power,reset}
      ARM: at91: dts: sama5d3: change name of pinctrl of ISI_MCK
      ARM: at91: dts: sama5d3: add ov2640 camera sensor support

Lina Iyer (1):
      ARM: qcom: Add SCM warmboot flags for quad core targets.

Magnus Damm (2):
      ARM: shmobile: Fix is_e2 warning
      ARM: shmobile: r8a7779: No TWD setup in C for Multiplatform

Matthias Brugger (1):
      ARM: mediatek: Low-level-debug for mt6592

Maxime COQUELIN (1):
      ARM: STi: Add STiH418 SoC support

Maxime Ripard (2):
      ARM: mvebu: Rename DEBUG_LL to indicate UART index
      ARM: mvebu: Add UART1 as DEBUG_LL possible target

Michal Mazur (1):
      bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x

Michal Simek (2):
      ARM: zynq: Setup default gpio number for Xilinx Zynq
      ARM: zynq: Simplify SLCR initialization

Mikko Perttunen (3):
      of: Add descriptions of thermtrip properties to Tegra PMC bindings
      ARM: tegra: Add PMC thermtrip programming to Jetson TK1 device tree
      soc: tegra: Add thermal reset (thermtrip) support to PMC

Moritz Fischer (1):
      ARM: zynq: PM: Fixed simple typo.

Nicolas Ferre (9):
      Merge tag 'at91-dt' into at91-3.20-cleanup
      ARM: at91: fix Kconfig.debug by adding DEBUG_AT91_UART option
      ARM: at91: fix PM initialization for newer SoCs
      ARM: at91: fix ordering of SRAM and PM initialization
      Merge branch 'at91-3.19-fixes' into at91-3.20-soc
      Merge tag 'at91-cleanup3' into at91-3.20-soc
      ARM: at91: move alternative initial mapping to board-dt-sama5.c
      ARM: at91: change board files into SoC files
      ARM: at91/trivial: unify functions and machine names

Olav Haugan (1):
      ARM: qcom: scm: Add logging of actual return code from scm call

Olof Johansson (22):
      ARM: SAMSUNG: print CPU id on probe
      Merge tag 'renesas-soc-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'arm-soc/for-3.20/brcmstb-smp' of http://github.com/broadcom/stblinux into next/soc
      Merge tag 'mvebu-soc-3.20' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'atlas7-lldebug-for-3.20' of git://git.kernel.org/.../baohua/linux into next/soc
      Merge tag 'new-atlas7mach-for-3.20' of git://git.kernel.org/.../baohua/linux into next/soc
      Merge tag 'at91-cleanup2' of git://git.kernel.org/.../nferre/linux-at91 into next/soc
      Merge tag 'sti-soc-for-v3.20-1' of git://git.stlinux.com/devel/kernel/linux-sti into next/soc
      Merge tag 'renesas-soc2-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'renesas-soc3-for-v3.20' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'v3.20-rockchip-soc1' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'mvebu-soc-3.20-2' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'v3.20-next-soc1' of https://github.com/mbgg/linux-mediatek into next/soc
      Merge tag 'imx-soc-3.20' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'tegra-for-3.20-soc' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'qcom-soc-for-3.20-2' of git://git.kernel.org/.../galak/linux-qcom into next/soc
      Merge tag 'at91-cleanup3' of git://git.kernel.org/.../nferre/linux-at91 into next/soc
      Merge tag 'sunxi-core-for-3.20' of https://git.kernel.org/.../mripard/linux into next/soc
      Merge tag 'omap-for-v3.20/dm816x-data' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'samsung-update' of git://git.kernel.org/.../kgene/linux-samsung into next/soc
      Merge tag 'zynq-soc-for-3.20' of https://github.com/Xilinx/linux-xlnx into next/soc
      Merge tag 'at91-soc4' of git://git.kernel.org/.../nferre/linux-at91 into next/soc

Paul Walmsley (1):
      soc/tegra: pmc: restrict compilation of suspend-related support to ARM

Sanchayan Maity (1):
      ARM: imx: clk-vf610: Add clock for SNVS

Sebastian Andrzej Siewior (1):
      ARM i.MX6q: unmap memory mapped at imx6q_opp_check_speed_grading()

Shawn Guo (1):
      ARM: imx: drop CPUIDLE_FLAG_TIME_VALID from cpuidle-imx6sx

Shengjiu Wang (1):
      ARM: clk-imx6q: refine esai_ipg's parent

Sjoerd Simons (1):
      ARM: EXYNOS: Recognize Samsung MFC v8 devices

Soren Brinkmann (1):
      ARM: zynq: Enable pinctrl

Stefan Agner (2):
      ARM vf610: add compatibilty strings of supported Vybrid SoC's
      ARM: imx: pllv3: add shift for frequency multiplier

Stephen Boyd (8):
      ARM: debug: Update MSM and QCOM DEBUG_LL help
      ARM: debug: msm: Support big-endian CPUs
      ARM: qcom: Select ARCH_SUPPORTS_BIG_ENDIAN
      ARM: qcom: scm: Fix incorrect cache invalidation
      ARM: qcom: scm: Get cacheline size from CTR
      ARM: qcom: scm: Clarify boot interface
      ARM: qcom: Fix SCM interface for big-endian kernels
      ARM: qcom: Drop unnecessary selects from ARCH_QCOM

Thierry Reding (5):
      clocksource: Build Tegra timer on 32-bit ARM only
      soc/tegra: Add Tegra132 support
      soc/tegra: fuse: Constify tegra_fuse_info structures
      soc/tegra: fuse: Add Tegra132 support
      soc/tegra: pmc: Add Tegra132 support

Thomas Petazzoni (3):
      bus: mvebu-mbus: use automatic I/O synchronization barriers
      ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware I/O coherency
      bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window

Tony Lindgren (2):
      ARM: OMAP2+: Add board-generic.c entry for ti81xx
      ARM: OMAP2+: Add dm816x hwmod support

Ulrich Hecht (1):
      ARM: shmobile: r8a73a4: Multiplatform support

Vikram Mulukutla (1):
      ARM: qcom: scm: Flush the command buffer only instead of the entire cache

Wang Long (5):
      ARM: debug: add HiP01 debug uart
      ARM: hisi: enable HiP01 SoC
      ARM: hisi: rename smp_prepares_cpus function
      ARM: hisi: rename secondary_startup function
      ARM: hisi: enable smp for HiP01

Yingjoe Chen (1):
      ARM: mediatek: Add config options for mediatek SoCs.

Zhiwu Song (2):
      ARM: sirf: move platsmp to support Atlas7 SoC
      ARM: sirf: add Atlas7 machine support


 Documentation/arm/sti/stih418-overview.txt      |   20 +
 Documentation/arm/sunxi/README                  |    1 -
 .../devicetree/bindings/arm/atmel-at91.txt      |   17 +
 Documentation/devicetree/bindings/arm/fsl.txt   |   12 +
 .../bindings/arm/rockchip/pmu-sram.txt          |   16 +
 Documentation/devicetree/bindings/arm/sti.txt   |    4 +
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt   |   26 +
 MAINTAINERS                                     |    3 +
 arch/arm/Kconfig                                |    4 +-
 arch/arm/Kconfig.debug                          |  114 +-
 arch/arm/boot/dts/at91rm9200.dtsi               |   12 +
 arch/arm/boot/dts/at91rm9200ek.dts              |    4 +
 arch/arm/boot/dts/at91sam9260.dtsi              |    5 +
 arch/arm/boot/dts/at91sam9261.dtsi              |    5 +
 arch/arm/boot/dts/at91sam9263.dtsi              |   12 +-
 arch/arm/boot/dts/at91sam9g20.dtsi              |    9 +
 arch/arm/boot/dts/at91sam9g45.dtsi              |    7 +-
 arch/arm/boot/dts/at91sam9n12.dtsi              |   12 +
 arch/arm/boot/dts/at91sam9rl.dtsi               |    5 +
 arch/arm/boot/dts/at91sam9x5.dtsi               |    5 +
 arch/arm/boot/dts/at91sam9xe.dtsi               |   60 +
 arch/arm/boot/dts/ethernut5.dts                 |    2 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |   34 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi               |    1 +
 arch/arm/boot/dts/sama5d3xmb.dtsi               |   40 +-
 arch/arm/boot/dts/sama5d4.dtsi                  |   10 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |    7 +
 arch/arm/configs/at91_dt_defconfig              |   10 +-
 arch/arm/include/debug/digicolor.S              |   35 +
 arch/arm/include/debug/msm.S                    |    6 +
 arch/arm/include/debug/sirf.S                   |   30 +-
 arch/arm/mach-at91/Kconfig                      |  112 +-
 arch/arm/mach-at91/Makefile                     |   18 +-
 arch/arm/mach-at91/at91rm9200.c                 |   66 +-
 arch/arm/mach-at91/at91sam9.c                   |   87 ++
 arch/arm/mach-at91/at91sam9260.c                |   59 -
 arch/arm/mach-at91/at91sam9261.c                |   40 -
 arch/arm/mach-at91/at91sam9263.c                |   37 -
 arch/arm/mach-at91/at91sam9g45.c                |   36 -
 arch/arm/mach-at91/at91sam9n12.c                |   26 -
 arch/arm/mach-at91/at91sam9rl.c                 |   49 -
 arch/arm/mach-at91/at91sam9x5.c                 |   26 -
 arch/arm/mach-at91/board-dt-rm9200.c            |   43 -
 arch/arm/mach-at91/board-dt-sam9.c              |   36 -
 arch/arm/mach-at91/generic.h                    |   20 +-
 arch/arm/mach-at91/include/mach/cpu.h           |   52 +-
 arch/arm/mach-at91/include/mach/system_rev.h    |   27 -
 arch/arm/mach-at91/pm.c                         |  160 ++-
 arch/arm/mach-at91/pm_slowclock.S               |    9 -
 .../arm/mach-at91/{board-dt-sama5.c => sama5.c} |   46 +-
 arch/arm/mach-at91/sama5d3.c                    |   35 -
 arch/arm/mach-at91/sama5d4.c                    |   64 -
 arch/arm/mach-at91/setup.c                      |   97 --
 arch/arm/mach-at91/soc.h                        |   77 --
 arch/arm/mach-bcm/platsmp-brcmstb.c             |   85 +-
 arch/arm/mach-digicolor/Kconfig                 |    7 +
 arch/arm/mach-digicolor/Makefile                |    1 +
 arch/arm/mach-digicolor/digicolor.c             |   18 +
 arch/arm/mach-exynos/exynos.c                   |    1 +
 arch/arm/mach-exynos/regs-pmu.h                 |    3 +
 arch/arm/mach-exynos/suspend.c                  |   77 ++
 arch/arm/mach-hisi/Kconfig                      |    8 +
 arch/arm/mach-hisi/core.h                       |    5 +-
 arch/arm/mach-hisi/headsmp.S                    |    2 +-
 arch/arm/mach-hisi/hisilicon.c                  |   10 +
 arch/arm/mach-hisi/hotplug.c                    |   31 +
 arch/arm/mach-hisi/platsmp.c                    |   56 +-
 arch/arm/mach-imx/Makefile                      |    3 +-
 arch/arm/mach-imx/clk-gate2.c                   |   23 +-
 arch/arm/mach-imx/clk-imx6q.c                   |    2 +-
 arch/arm/mach-imx/clk-pllv3.c                   |   10 +-
 arch/arm/mach-imx/clk-vf610.c                   |    8 +-
 arch/arm/mach-imx/clk.h                         |    1 +
 arch/arm/mach-imx/common.h                      |    4 +
 arch/arm/mach-imx/cpuidle-imx6sx.c              |  105 ++
 arch/arm/mach-imx/cpuidle.h                     |    5 +
 arch/arm/mach-imx/gpc.c                         |   25 +-
 arch/arm/mach-imx/mach-imx6q.c                  |    2 +-
 arch/arm/mach-imx/mach-imx6sx.c                 |    2 +-
 arch/arm/mach-imx/mach-vf610.c                  |    5 +-
 arch/arm/mach-imx/pm-imx6.c                     |    7 +-
 arch/arm/mach-mediatek/Kconfig                  |   22 +-
 arch/arm/mach-mvebu/coherency.c                 |   58 +-
 arch/arm/mach-mvebu/mvebu-soc-id.h              |   18 +
 arch/arm/mach-omap2/Makefile                    |    4 +
 arch/arm/mach-omap2/board-generic.c             |   36 +
 arch/arm/mach-omap2/clockdomain.h               |    1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c     |  194 +++
 arch/arm/mach-omap2/cm81xx.h                    |   61 +
 arch/arm/mach-omap2/io.c                        |   82 +-
 arch/arm/mach-omap2/omap_hwmod.c                |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h                |    1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c      | 1136 ++++++++++++++++++
 arch/arm/mach-prima2/Kconfig                    |   22 +-
 arch/arm/mach-prima2/Makefile                   |    1 -
 arch/arm/mach-prima2/common.c                   |   22 +-
 arch/arm/mach-prima2/lluart.c                   |   35 -
 arch/arm/mach-prima2/platsmp.c                  |   52 +-
 arch/arm/mach-prima2/rstc.c                     |   41 +-
 arch/arm/mach-prima2/rtciobrg.c                 |    1 -
 arch/arm/mach-qcom/Kconfig                      |    3 +-
 arch/arm/mach-qcom/scm-boot.c                   |   10 +-
 arch/arm/mach-qcom/scm-boot.h                   |    4 +-
 arch/arm/mach-qcom/scm.c                        |   85 +-
 arch/arm/mach-rockchip/Makefile                 |    1 +
 arch/arm/mach-rockchip/pm.c                     |  260 ++++
 arch/arm/mach-rockchip/pm.h                     |   99 ++
 arch/arm/mach-rockchip/rockchip.c               |    4 +-
 arch/arm/mach-rockchip/sleep.S                  |   73 ++
 arch/arm/mach-shmobile/Kconfig                  |    8 +-
 arch/arm/mach-shmobile/clock-sh73a0.c           |   10 +
 arch/arm/mach-shmobile/pm-r8a7740.c             |   14 +
 arch/arm/mach-shmobile/pm-rmobile.c             |  314 ++++-
 arch/arm/mach-shmobile/pm-rmobile.h             |    3 +-
 arch/arm/mach-shmobile/pm-sh7372.c              |   11 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |    4 +-
 arch/arm/mach-shmobile/smp-r8a7779.c            |    2 +-
 arch/arm/mach-sti/board-dt.c                    |    1 +
 arch/arm/mach-sunxi/platsmp.c                   |    2 +-
 arch/arm/mach-sunxi/sunxi.c                     |   11 +
 arch/arm/mach-tegra/Kconfig                     |    4 +
 arch/arm/mach-zynq/Kconfig                      |    2 +
 arch/arm/mach-zynq/common.c                     |    2 -
 arch/arm/mach-zynq/pm.c                         |    2 +-
 arch/arm/mach-zynq/slcr.c                       |   35 +-
 arch/arm/plat-samsung/cpu.c                     |    4 +
 drivers/bus/mvebu-mbus.c                        |  286 +++--
 drivers/clk/at91/pmc.c                          |    9 +
 drivers/clk/sunxi/clk-sunxi.c                   |    1 +
 drivers/clocksource/Kconfig                     |    3 +
 drivers/clocksource/Makefile                    |    2 +-
 drivers/soc/tegra/fuse/fuse-tegra.c             |    1 +
 drivers/soc/tegra/fuse/fuse-tegra30.c           |    9 +-
 drivers/soc/tegra/pmc.c                         |  124 +-
 include/dt-bindings/clock/vf610-clock.h         |    3 +-
 include/soc/tegra/fuse.h                        |    1 +
 include/soc/tegra/pm.h                          |    2 +-
 137 files changed, 4076 insertions(+), 1378 deletions(-)
 create mode 100644 Documentation/arm/sti/stih418-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/pmu-sram.txt
 create mode 100644 arch/arm/boot/dts/at91sam9xe.dtsi
 create mode 100644 arch/arm/include/debug/digicolor.S
 create mode 100644 arch/arm/mach-at91/at91sam9.c
 delete mode 100644 arch/arm/mach-at91/at91sam9260.c
 delete mode 100644 arch/arm/mach-at91/at91sam9261.c
 delete mode 100644 arch/arm/mach-at91/at91sam9263.c
 delete mode 100644 arch/arm/mach-at91/at91sam9g45.c
 delete mode 100644 arch/arm/mach-at91/at91sam9n12.c
 delete mode 100644 arch/arm/mach-at91/at91sam9rl.c
 delete mode 100644 arch/arm/mach-at91/at91sam9x5.c
 delete mode 100644 arch/arm/mach-at91/board-dt-rm9200.c
 delete mode 100644 arch/arm/mach-at91/board-dt-sam9.c
 delete mode 100644 arch/arm/mach-at91/include/mach/system_rev.h
 rename arch/arm/mach-at91/{board-dt-sama5.c => sama5.c} (54%)
 delete mode 100644 arch/arm/mach-at91/sama5d3.c
 delete mode 100644 arch/arm/mach-at91/sama5d4.c
 delete mode 100644 arch/arm/mach-at91/soc.h
 create mode 100644 arch/arm/mach-digicolor/Kconfig
 create mode 100644 arch/arm/mach-digicolor/Makefile
 create mode 100644 arch/arm/mach-digicolor/digicolor.c
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6sx.c
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm81xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c
 delete mode 100644 arch/arm/mach-prima2/lluart.c
 create mode 100644 arch/arm/mach-rockchip/pm.c
 create mode 100644 arch/arm/mach-rockchip/pm.h
 create mode 100644 arch/arm/mach-rockchip/sleep.S
