From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 21:42:04 +0800
Subject: [GIT PULL] ARM: imx: soc changes for 3.11
Message-ID: <20130617134203.GH31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the imx soc change set I queued for 3.11.  There is a trivial
merge conflict with branch mvebu/regmap, and linux-next should have
the resolution.

Shawn

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.11

for you to fetch changes up to 3bfbc6cd9b41f937a134ba65a4a1eefba062b9a8:

  ARM: imx_v6_v7_defconfig: Enable Vybrid VF610 (2013-06-17 15:45:17 +0800)

----------------------------------------------------------------
imx soc changes for 3.11:

* New SoCs i.MX6 Sololite and Vybrid VF610 support
* imx5 and imx6 clock fixes and additions
* Update clock driver to use of_clk_init() function
* Refactor restart routine mxc_restart() to get it work for DT boot
  as well
* Clean up mxc specific ulpi access ops
* imx defconfig updates

----------------------------------------------------------------
Dirk Behme (3):
      ARM: i.MX6: add i.MX6 specific L2 cache configuration
      ARM: i.MX6: clk: add i.MX6 DualLite differences
      ARM: i.MX6: clk: add different DualLite MLB clock config

Fabio Estevam (6):
      ARM: imx: imx_v6_v7_defconfig: Select CONFIG_DRM_IMX_TVE
      ARM: imx: Enable mx6 solo-lite support
      ARM: imx: irq-common: Include header to avoid sparse warning
      ARM: imx: clk: No need to initialize phandle struct
      ARM: imx_v6_v7_defconfig: Enable PWM and backlight options
      ARM: imx_v6_v7_defconfig: Enable Vybrid VF610

Huang Shijie (1):
      ARM: imx6q: clk: add the eim_slow clock

Jiada Wang (2):
      ARM: imx: disable pll8_mlb in mx6q_clks
      ARM: imx: remove MLB PLL from pllv3

Jingchang Lu (2):
      ARM: imx: add VF610 clock support
      ARM: imx: add initial support for VF610

Markus Pargmann (1):
      ARM: imx: Remove mxc specific ulpi access ops

Martin Fuzzey (1):
      ARM: i.MX5: Allow DT clock providers

Nicolin Chen (2):
      ARM: clk-imx6qdl: Add clko1 configuration for imx6qdl-sabresd
      ARM: imx_v6_v7_defconfig: Enable imx-wm8962 by default

Philipp Zabel (1):
      ARM i.MX5: Add S/PDIF clocks

Rogerio Pimentel (1):
      ARM: imx_v6_v7_defconfig: enable parallel display

Sascha Hauer (1):
      ARM i.MX53: Add SATA clock

Shawn Guo (8):
      ARM: imx: include <asm/io.h> in hardware.h
      ARM: imx: move clk_prepare() out from mxc_restart()
      ARM: imx: create mxc_arch_reset_init_dt() for DT boot
      ARM: imx: add clock support for imx6sl
      ARM: imx: enable low-level debug support for imx6sl
      ARM: imx: add initial support for imx6sl
      ARM: imx6q: call of_clk_init() to register fixed rate clocks
      ARM: imx6: use common of_clk_init() call to initialize clocks

 .../devicetree/bindings/clock/imx5-clock.txt       |   13 +
 .../devicetree/bindings/clock/imx6q-clock.txt      |    1 +
 .../devicetree/bindings/clock/imx6sl-clock.txt     |   10 +
 .../devicetree/bindings/clock/vf610-clock.txt      |   26 ++
 arch/arm/Kconfig.debug                             |   13 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   10 +
 arch/arm/include/debug/imx-uart.h                  |   10 +
 arch/arm/mach-imx/Kconfig                          |   63 +++-
 arch/arm/mach-imx/Makefile                         |    4 +-
 arch/arm/mach-imx/clk-imx51-imx53.c                |   73 +++--
 arch/arm/mach-imx/clk-imx6q.c                      |   48 +--
 arch/arm/mach-imx/clk-imx6sl.c                     |  267 ++++++++++++++++
 arch/arm/mach-imx/clk-pllv3.c                      |   10 -
 arch/arm/mach-imx/clk-vf610.c                      |  319 ++++++++++++++++++++
 arch/arm/mach-imx/clk.c                            |   35 +++
 arch/arm/mach-imx/clk.h                            |    4 +-
 arch/arm/mach-imx/common.h                         |    2 +-
 arch/arm/mach-imx/hardware.h                       |    1 +
 arch/arm/mach-imx/imx25-dt.c                       |    2 +
 arch/arm/mach-imx/imx27-dt.c                       |    2 +
 arch/arm/mach-imx/imx31-dt.c                       |    2 +
 arch/arm/mach-imx/imx51-dt.c                       |    2 +
 arch/arm/mach-imx/irq-common.c                     |    1 +
 arch/arm/mach-imx/mach-imx53.c                     |    3 +
 arch/arm/mach-imx/mach-imx6q.c                     |   81 ++++-
 arch/arm/mach-imx/mach-imx6sl.c                    |   52 ++++
 arch/arm/mach-imx/mach-pca100.c                    |    4 +-
 arch/arm/mach-imx/mach-vf610.c                     |   48 +++
 arch/arm/mach-imx/mm-imx1.c                        |    2 +-
 arch/arm/mach-imx/mm-imx21.c                       |    2 +-
 arch/arm/mach-imx/mm-imx25.c                       |    2 +-
 arch/arm/mach-imx/mm-imx27.c                       |    2 +-
 arch/arm/mach-imx/mm-imx3.c                        |    4 +-
 arch/arm/mach-imx/mm-imx5.c                        |    3 +-
 arch/arm/mach-imx/system.c                         |   47 ++-
 arch/arm/mach-imx/ulpi.c                           |  118 --------
 arch/arm/mach-imx/ulpi.h                           |   11 +-
 include/dt-bindings/clock/imx6sl-clock.h           |  148 +++++++++
 include/dt-bindings/clock/vf610-clock.h            |  163 ++++++++++
 39 files changed, 1374 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/vf610-clock.txt
 create mode 100644 arch/arm/mach-imx/clk-imx6sl.c
 create mode 100644 arch/arm/mach-imx/clk-vf610.c
 create mode 100644 arch/arm/mach-imx/mach-imx6sl.c
 create mode 100644 arch/arm/mach-imx/mach-vf610.c
 delete mode 100644 arch/arm/mach-imx/ulpi.c
 create mode 100644 include/dt-bindings/clock/imx6sl-clock.h
 create mode 100644 include/dt-bindings/clock/vf610-clock.h
