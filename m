From: olof@lixom.net (Olof Johansson)
Date: Tue, 21 Apr 2015 23:11:10 -0700
Subject: [GIT PULL 3/9] ARM: SoC platform updates for v4.1
In-Reply-To: <1429683076-19881-1-git-send-email-olof@lixom.net>
References: <1429683076-19881-1-git-send-email-olof@lixom.net>
Message-ID: <1429683076-19881-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our SoC branch usually contains expanded support for new SoCs and other core
platform code. In this case, that includes:

- Support for the new Annapurna Labs "Alpine" platform
- A rework greatly simplifying adding new platform support to the MCPM
subsystem (Multi-cluster power management)
- Cpuidle and PM improvements for Exynos3250
- Misc updates for Renesas, OMAP, Meson, i.MX. Some of these could have
gone in other branches but ended up here for various reasons.


Conflicts:
arch/arm/mach-exynos/platsmp.c: Conflict with a fix for 4.0. Keep
the core_conf variable, but go with the soc_is_*() version if the if
statement.

arch/arm/mach-exynos/suspend.c:
Keep the const version, but move it down to the lower position

----------------------------------------------------------------

The following changes since commit 05999d25d26bb99ed09ed2d08aa33e3f116bdd88:

  Merge tag 'armsoc-cleanup' into testmerge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to a018bb2ff95868ea592212b6735b35836fda268b:

  ARM: alpine: add support for generic pci

----------------------------------------------------------------

Alison Chaiken (1):
      bus: imx-weim: improve error handling upon child probe-failure

Andrzej Hajda (1):
      ARM: EXYNOS: add support for async-bridge clocks for pm_domains

Arnd Bergmann (5):
      Merge tag 'renesas-soc-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'for-v4.0-rc/meson-soc' of https://github.com/carlocaione/linux-meson into next/soc
      Merge tag 'mvebu-soc-4.1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'renesas-da9063-da9210-quirk-for-v4.1' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'arm-soc/for-4.1/soc' of http://github.com/broadcom/stblinux into next/soc

Bartlomiej Zolnierkiewicz (4):
      ARM: EXYNOS: fix CPU1 hotplug on Exynos3250
      ARM: EXYNOS: add code for setting/clearing boot flag
      ARM: EXYNOS: add AFTR mode support for Exynos3250
      ARM: EXYNOS: allow cpuidle driver usage on Exynos3250 SoC

Beniamino Galvani (3):
      ARM: meson: select PINCTRL_MESON and ARCH_REQUIRE_GPIOLIB
      of: Add vendor prefix for MINIX
      of: Define board compatible for MINIX NEO-X8

Charles Keepax (1):
      ARM: S3C64XX: Use fixed IRQ bases to avoid conflicts on Cragganmore

Chris Zhong (2):
      ARM: rockchip: decrease the wait time for resume
      ARM: rockchip: disable watchdog during suspend

Geert Uytterhoeven (5):
      ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator quirk
      ARM: shmobile: koelsch dts: Add da9210 regulator interrupt
      ARM: shmobile: koelsch: Add da9063 PMIC device node for system restart
      ARM: shmobile: lager dts: Add da9210 regulator interrupt
      ARM: shmobile: lager: Add da9063 PMIC device node for system restart

Grygorii Strashko (1):
      ARM: omap-device: add missed callback for suspend-to-disk

Krzysztof Kozlowski (5):
      ARM: rockchip: Constify struct regmap_config and staticize local function
      ARM: EXYNOS: Use platform device name as power domain name
      ARM: EXYNOS: use static in suspend.c
      ARM: EXYNOS: Constify exynos_pm_data array
      ARM: EXYNOS: Remove left over 'extra_save'

Liu Ying (6):
      ARM: imx6q: Add GPR3 MIPI muxing control register field shift bits definition
      ARM: imx6q: clk: Add the video_27m clock
      ARM: imx6q: clk: Change hdmi_isfr clock's parent to be video_27m clock
      ARM: imx6q: clk: Change hsi_tx clock to be a shared clock gate
      ARM: imx6q: clk: Add support for mipi_core_cfg clock as a shared clock gate
      ARM: imx6q: clk: Add support for mipi_ipg clock as a shared clock gate

Magnus Damm (1):
      ARM: shmobile: No R-Car Gen2 CMA reservation when HIGHMEM=n

Nicolas Pitre (5):
      ARM: MCPM: move the algorithmic complexity to the core code
      ARM: vexpress: migrate TC2 to the new MCPM backend abstraction
      ARM: vexpress: DCSCB: tighten CPU validity assertion
      ARM: vexpress: migrate DCSCB to the new MCPM backend abstraction
      ARM: Exynos: migrate DCSCB to the new MCPM backend abstraction

Olof Johansson (4):
      Merge tag 'v4.1-rockchip-soc1' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'v4.1-soc' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'imx-soc-4.1' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'samsung-updates' of git://git.kernel.org/.../kgene/linux-samsung into next/soc

Philipp Zabel (2):
      Documentation: Add device tree bindings for Freescale i.MX GPC
      ARM: imx6: gpc: Add PU power domain for GPU/VPU

Sourav Poddar (1):
      ARM: OMAP2: hwmod: AM43XX: Add hwmod support for HDQ-1W

Stefan Agner (3):
      ARM: vf610: use SMP_ON_UP for Vybrid SoC
      ARM: imx: depend MXC debug board on 3DS machines
      ARM: cygnus: fix const declaration bcm_cygnus_dt_compat

Suman Anna (2):
      ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
      ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

Thomas Petazzoni (4):
      devicetree: bindings: add DT binding for the Marvell Armada 39x SoC family
      devicetree: bindings: add new SMP enable method for Marvell Armada 39x
      ARM: mvebu: add core support for Armada 39x
      Documentation: arm: update supported Marvell EBU processors

Tony Lindgren (1):
      Merge tag 'for-v4.1/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.1/soc

Tsahee Zidenberg (6):
      ARM: Alpine: Initial support for Alpine platform
      ARM: Alpine: early-debug print support
      ARM: Alpine: smp support
      ARM: dts: Alpine platform binding documentation
      MAINTAINERS: add maintainer for Alpine Arm machine
      ARM: alpine: add support for generic pci


 Documentation/arm/Marvell/README                |   5 +
 .../devicetree/bindings/arm/al,alpine.txt       |  88 ++++++
 .../devicetree/bindings/arm/amlogic.txt         |   4 +
 .../devicetree/bindings/arm/armada-39x.txt      |  20 ++
 .../arm/cpu-enable-method/al,alpine-smp         |  52 ++++
 Documentation/devicetree/bindings/arm/cpus.txt  |   1 +
 .../devicetree/bindings/arm/geniatech.txt       |   5 -
 .../devicetree/bindings/power/fsl,imx-gpc.txt   |  59 ++++
 .../devicetree/bindings/vendor-prefixes.txt     |   2 +
 MAINTAINERS                                     |   5 +
 arch/arm/Kconfig                                |   2 +
 arch/arm/Kconfig.debug                          |  12 +-
 arch/arm/Makefile                               |   1 +
 arch/arm/boot/dts/r8a7790-lager.dts             |  18 ++
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  18 ++
 arch/arm/common/mcpm_entry.c                    | 202 +++++++++++--
 arch/arm/include/asm/mcpm.h                     |  65 ++++-
 arch/arm/mach-alpine/Kconfig                    |  12 +
 arch/arm/mach-alpine/Makefile                   |   2 +
 arch/arm/mach-alpine/alpine_cpu_pm.c            |  70 +++++
 arch/arm/mach-alpine/alpine_cpu_pm.h            |  26 ++
 arch/arm/mach-alpine/alpine_cpu_resume.h        |  38 +++
 arch/arm/mach-alpine/alpine_machine.c           |  28 ++
 arch/arm/mach-alpine/platsmp.c                  |  49 ++++
 arch/arm/mach-bcm/bcm_cygnus.c                  |   2 +-
 arch/arm/mach-exynos/common.h                   |   6 +
 arch/arm/mach-exynos/exynos.c                   |   1 +
 arch/arm/mach-exynos/firmware.c                 |  33 ++-
 arch/arm/mach-exynos/mcpm-exynos.c              | 247 ++++------------
 arch/arm/mach-exynos/platsmp.c                  |  23 +-
 arch/arm/mach-exynos/pm.c                       |  12 +-
 arch/arm/mach-exynos/pm_domains.c               |  29 +-
 arch/arm/mach-exynos/regs-pmu.h                 |   3 +
 arch/arm/mach-exynos/smc.h                      |   9 +
 arch/arm/mach-exynos/suspend.c                  |  22 +-
 arch/arm/mach-imx/Kconfig                       |   3 +
 arch/arm/mach-imx/clk-imx6q.c                   |   8 +-
 arch/arm/mach-imx/gpc.c                         | 213 ++++++++++++++
 arch/arm/mach-meson/Kconfig                     |   3 +
 arch/arm/mach-mvebu/Kconfig                     |  14 +
 arch/arm/mach-mvebu/board-v7.c                  |  14 +
 arch/arm/mach-mvebu/platsmp-a9.c                |   2 +
 arch/arm/mach-omap2/omap_device.c               |   3 +
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |  36 +++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       | 113 ++++++-
 arch/arm/mach-omap2/prcm43xx.h                  |   1 +
 arch/arm/mach-rockchip/platsmp.c                |   4 +-
 arch/arm/mach-rockchip/pm.c                     |  14 +-
 arch/arm/mach-rockchip/pm.h                     |   6 +
 arch/arm/mach-s3c64xx/crag6410.h                |   1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c           |   1 +
 arch/arm/mach-shmobile/Kconfig                  |   2 +
 arch/arm/mach-shmobile/Makefile                 |   2 +
 .../mach-shmobile/regulator-quirk-rcar-gen2.c   | 147 ++++++++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |   3 +-
 arch/arm/mach-vexpress/dcscb.c                  | 197 +++++--------
 arch/arm/mach-vexpress/tc2_pm.c                 | 291 ++++++-------------
 drivers/bus/imx-weim.c                          |  13 +-
 include/dt-bindings/clock/imx6qdl-clock.h       |   5 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h     |   1 +
 60 files changed, 1638 insertions(+), 630 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/al,alpine.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armada-39x.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpu-enable-method/al,alpine-smp
 delete mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
 create mode 100644 arch/arm/mach-alpine/Kconfig
 create mode 100644 arch/arm/mach-alpine/Makefile
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.c
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_pm.h
 create mode 100644 arch/arm/mach-alpine/alpine_cpu_resume.h
 create mode 100644 arch/arm/mach-alpine/alpine_machine.c
 create mode 100644 arch/arm/mach-alpine/platsmp.c
 create mode 100644 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
