From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Nov 2014 15:03:07 +0800
Subject: [GIT PULL] ARM: imx: SoC updates for 3.19
Message-ID: <20141119070306.GF27759@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

  Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.19

for you to fetch changes up to dc7aaa041842eb40be7ad7bde0a7e37ac1efd79c:

  ARM: configs: imx_v6_v7_defconfig: add power off driver (2014-11-19 11:51:55 +0800)

----------------------------------------------------------------
The i.MX SoC update for 3.19:
 - Update i.MX6 suspend code to check DDR instead of CPU type, as the
   difference we need to handle is between LPDDR2 and DDR3, not SoCs.
 - Set anatop properly for LPDDR2 in DSM mode
 - Add support for new SoC LS1021A which integrates dual Cortex-A7
 - Add ENET initialization for i.MX6SX platform
 - Add cpufreq support for i.MX53 platform
 - Add a SNVS based poweroff driver for i.MX6 platforms
 - Use ARM  Global Timer as clocksource on VF610
 - Some defconfig updates

----------------------------------------------------------------
Anson Huang (2):
      ARM: imx: replace cpu type check with ddr type check
      ARM: imx: add anatop settings for LPDDR2 when enter DSM mode

Arnd Bergmann (1):
      ARM: imx: temporarily remove CONFIG_SOC_FSL from LS1021A

Dmitry Lavnikevich (1):
      ARM: imx_v6_v7_defconfig: enable tlv320aic3x audio codec by default

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select thermal related drivers

Fugang Duan (2):
      ARM: imx6sx: add imx6sx iomux-gpr field define
      ARM: imx: add enet init for i.mx6sx

Jingchang Lu (2):
      ARM: imx: Add initial support for Freescale LS1021A
      ARM: imx: Add Freescale LS1021A SMP support

Lucas Stach (4):
      ARM: imx5: add step clock, used when reprogramming PLL1
      ARM: imx: add CPU clock type
      ARM: imx53: clk: add ARM clock
      ARM: imx53: add cpufreq support

Robin Gong (2):
      power: reset: imx-snvs-poweroff: add power off driver for i.mx6
      ARM: configs: imx_v6_v7_defconfig: add power off driver

Soeren Moch (1):
      ARM: imx_v6_v7_defconfig: enable DS1307 rtc and gpio fan by default

Stefan Agner (2):
      ARM: vf610: Add ARM Global Timer clocksource option
      ARM: imx: clk-vf610: get input clocks from assigned clocks

 .../bindings/power_supply/imx-snvs-poweroff.txt    |  23 +++++
 arch/arm/configs/imx_v6_v7_defconfig               |  10 +-
 arch/arm/mach-imx/Kconfig                          |  31 +++++-
 arch/arm/mach-imx/Makefile                         |   6 +-
 arch/arm/mach-imx/anatop.c                         |  34 ++++++-
 arch/arm/mach-imx/clk-cpu.c                        | 107 +++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |  14 ++-
 arch/arm/mach-imx/clk-vf610.c                      |  21 +++-
 arch/arm/mach-imx/clk.h                            |   4 +
 arch/arm/mach-imx/common.h                         |   2 +
 arch/arm/mach-imx/mach-imx53.c                     |   2 +
 arch/arm/mach-imx/mach-imx6sx.c                    |  51 ++++++++++
 arch/arm/mach-imx/mach-ls1021a.c                   |  22 +++++
 arch/arm/mach-imx/mmdc.c                           |  17 ++++
 arch/arm/mach-imx/mxc.h                            |   2 +
 arch/arm/mach-imx/platsmp.c                        |  33 +++++++
 arch/arm/mach-imx/pm-imx6.c                        |  10 +-
 arch/arm/mach-imx/suspend-imx6.S                   |  14 +--
 drivers/power/reset/Kconfig                        |   9 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/imx-snvs-poweroff.c            |  66 +++++++++++++
 include/dt-bindings/clock/imx5-clock.h             |   5 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |  39 ++++++++
 23 files changed, 496 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
 create mode 100644 arch/arm/mach-imx/clk-cpu.c
 create mode 100644 arch/arm/mach-imx/mach-ls1021a.c
 create mode 100644 drivers/power/reset/imx-snvs-poweroff.c
