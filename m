From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Dec 2013 13:34:46 +0800
Subject: [GIT PULL 1/2] ARM: imx: soc changes for 3.14
Message-ID: <20131231053444.GB22122@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.14

for you to fetch changes up to 48c95841110036a95840c6782f27d841ead9a583:

  ARM: imx: improve the comment of CCM lpm SW workaround (2013-12-31 09:36:48 +0800)

----------------------------------------------------------------
i.MX SoC changes for 3.14:
 - Add the initial i.MX50 SoC support
 - Support device tree boot for i.MX35
 - Move imx5 clock driver to use macros for clock ID
 - Some random updates and non-critical fixes on clock drivers
 - A few defconfig updates and minor cleanups

----------------------------------------------------------------
Alexander Shiyan (2):
      ARM: i.MX5x: Add SAHARA clock for i.MX5x CPUs
      ARM: imx: pllv1: Fix PLL calculation for i.MX27

Anson Huang (4):
      ARM: imx: clk: correct arm clock usecount
      ARM: imx: add necessary interface for pfd
      ARM: imx: improve status check of clock gate
      ARM: imx: improve the comment of CCM lpm SW workaround

Denis Carikli (3):
      ARM: imx_v4_v5_defconfig: Enable gpio regulator and gpio button/keyboard.
      ARM: imx_v6_v7_defconfig: Enable tsc2007 support.
      ARM i.MX25: build in pinctrl support.

Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Select CONFIG_HIGHMEM
      ARM: imx_v6_v7_defconfig: Select MX35 and MX50 device tree support
      ARM: imx_v6_v7_defconfig: Select CONFIG_REGULATOR_PFUZE100

Greg Ungerer (4):
      ARM: imx: add debug uart support for IMX50 SoC
      ARM: imx: add clocking support code for the IMX50 SoC
      ARM: imx: allow configuration of the IMX50 SoC
      ARM: imx: add support code for IMX50 based machines

Jingchang Lu (1):
      ARM: imx: Add DMAMUX clock for Vybrid vf610 SoC

John Tobias (1):
      ARM: imx: Add cpu frequency scaling support

Lothar Wa?mann (1):
      ARM i.MX5: fix obvious typo in ldb_di0_gate clk definition

Lucas Stach (1):
      ARM: imx5: introduce DT includes for clock provider

Marc Kleine-Budde (2):
      ARM i.MX5: fix "shift" value for lp_apm_sel on i.MX50 and i.MX53
      ARM i.MX5: set CAN peripheral clock to 24 MHz parent

Marek Vasut (2):
      ARM: imx_v6_v7_defconfig: Enable STMPE touchscreen
      ARM: imx: imx53: Add SATA PHY clock

Markus Pargmann (1):
      ARM: imx27: enable pinctrl

Nicolin Chen (3):
      ARM: imx6: Derive spdif clock from pll3_pfd3_454m
      ARM: imx6sl: Add missing pll4_audio_div to the clock tree
      ARM: imx6sl: Add missing spba clock to clock tree

Russell King (1):
      ARM: imx: update imx_v6_v7_defconfig

Shawn Guo (4):
      ARM: imx: remove mxc_iomux_v3_init() call from imx53_init_early()
      ARM: imx: select PINCTRL at sub-architecure level
      ARM: imx: rename IMX6SL_CLK_CLK_END to IMX6SL_CLK_END
      ARM: imx: use __initconst for const init definition

Steffen Trumtrar (1):
      ARM i.MX35: Add devicetree support.

Tim Harvey (1):
      ARM: imx: add PCI fixup for PEX860X on Gateworks board

Uwe Kleine-K?nig (1):
      ARM: imx: drop support for irq priorisation

Wei Yongjun (1):
      ARM i.MX53: remove duplicated include from clk-imx51-imx53.c

 .../devicetree/bindings/clock/imx35-clock.txt      |  113 +++
 .../devicetree/bindings/clock/imx5-clock.txt       |  195 +----
 arch/arm/Kconfig.debug                             |    9 +
 arch/arm/configs/imx_v4_v5_defconfig               |    2 +
 arch/arm/configs/imx_v6_v7_defconfig               |   13 +-
 arch/arm/include/debug/imx-uart.h                  |   10 +
 arch/arm/mach-imx/Kconfig                          |   35 +-
 arch/arm/mach-imx/Makefile                         |    2 +
 arch/arm/mach-imx/avic.c                           |   25 -
 arch/arm/mach-imx/clk-gate2.c                      |    2 +-
 arch/arm/mach-imx/clk-imx35.c                      |   14 +
 arch/arm/mach-imx/clk-imx51-imx53.c                |  804 ++++++++++----------
 arch/arm/mach-imx/clk-imx6q.c                      |    5 +-
 arch/arm/mach-imx/clk-imx6sl.c                     |   11 +-
 arch/arm/mach-imx/clk-pfd.c                        |   11 +
 arch/arm/mach-imx/clk-pllv1.c                      |   23 +-
 arch/arm/mach-imx/clk-vf610.c                      |    5 +
 arch/arm/mach-imx/common.h                         |    1 +
 arch/arm/mach-imx/imx31-dt.c                       |    2 +-
 arch/arm/mach-imx/imx35-dt.c                       |   50 ++
 arch/arm/mach-imx/imx51-dt.c                       |    2 +-
 arch/arm/mach-imx/irq-common.h                     |    1 -
 arch/arm/mach-imx/mach-imx50.c                     |   38 +
 arch/arm/mach-imx/mach-imx53.c                     |    2 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   32 +-
 arch/arm/mach-imx/mach-imx6sl.c                    |   10 +-
 arch/arm/mach-imx/mach-vf610.c                     |    2 +-
 arch/arm/mach-imx/mm-imx5.c                        |    8 -
 arch/arm/mach-imx/pm-imx6q.c                       |   16 +-
 include/dt-bindings/clock/imx5-clock.h             |  203 +++++
 include/dt-bindings/clock/imx6sl-clock.h           |    4 +-
 include/dt-bindings/clock/vf610-clock.h            |    6 +-
 32 files changed, 1002 insertions(+), 654 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
 create mode 100644 arch/arm/mach-imx/imx35-dt.c
 create mode 100644 arch/arm/mach-imx/mach-imx50.c
 create mode 100644 include/dt-bindings/clock/imx5-clock.h
