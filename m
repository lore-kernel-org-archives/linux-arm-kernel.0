From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 May 2012 11:07:25 +0800
Subject: [GIT PULL] imx device tree changes for v3.5
Message-ID: <20120512030722.GD17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following imx device tree changes for v3.5.  I chose
to base it on Sascha's imx-common-clk series than -rc, because otherwise
it will keep patching clock file that has been removed by imx-common-clk
series.  It also depends on imx-pinctrl pull-request I just sent to be
functional.

Note: when imx-common-clk and imx-pinctrl get merged together, the
following files will have conflicts.  But the conflicts should not be
so hard to resolve.

    Conflicts:
        drivers/mmc/host/sdhci-esdhc-imx.c
        drivers/net/ethernet/freescale/fec.c
        drivers/spi/spi-imx.c
        drivers/tty/serial/imx.c

If you prefer, I can rebase my imx-pinctrl on top of imx-common-clk
to save the conflicts.

Regards,
Shawn

The following changes since commit c818f97bc3266f0fbf619f2348d951272f8ac335:

  ARM i.MX: remove now unused clock files (2012-05-09 09:00:40 +0200)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt/for-3.5

Dirk Behme (1):
      ARM: imx6: Add UART2 for low-level debug

Dong Aisheng (1):
      ARM: dts: imx6q-arm2: add pinctrl state for usdhc

Fabio Estevam (4):
      ARM: dts: imx: Remove bootargs field
      ARM: imx6q-arm2: Remove hardcoded mac address
      ARM: dts: Add basic support for imx6q-sabresd
      ARM: dts: imx6q-sabrelite: Add SPI NOR support

Richard Zhao (9):
      ARM: imx6q: move imx6q_sabrelite specific code to a dedicated function
      ARM: dts: imx6q-sabrelite: add ssi device
      ARM: dts: imx6q-sabrelite: add audmux device
      ARM: dts: imx6q-sabrelite: add i2c1 pinctrl support
      ARM: dts: imx6q-sabrelite: add audmux pinctrl support
      ARM: imx6q: add ssi1_ipg clk_lookup
      ARM: imx6q_sabrelite: clk_register_clkdev cko1 for sgtl5000
      ARM: dts: imx6q-sabrelite: add sound device imx6q-sabrelite-sgtl5000
      ARM: dts: imx6q-sabrelite: add serial2 pinctrl support

Shawn Guo (7):
      ARM: imx: rename uart and fec device tree nodes
      ARM: imx6q: register phy fixup only when CONFIG_PHYLIB is enabled
      ARM: imx: add more imx5 ssi clocks
      ARM: imx: add audmux pad setting for imx51-babbage
      ARM: imx: add audio codec clk lookup for imx53-qsb
      ARM: dts: imx51-babbage: enable audio support
      ARM: dts: imx53-qsb: enable audio support

Ying-Chun Liu (PaulLiu) (2):
      ARM: dts: imx6q: add anatop regulators
      ARM: dts: imx53-qsb: Add Dialog DA9053 PMIC support

 Documentation/devicetree/bindings/arm/fsl.txt      |    4 +
 Documentation/devicetree/bindings/net/fsl-fec.txt  |    2 +-
 .../bindings/tty/serial/fsl-imx-uart.txt           |    2 +-
 arch/arm/Kconfig.debug                             |    8 +
 arch/arm/boot/dts/imx27-phytec-phycore.dts         |    8 +-
 arch/arm/boot/dts/imx27.dtsi                       |   14 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   40 ++++-
 arch/arm/boot/dts/imx51.dtsi                       |   41 +++++-
 arch/arm/boot/dts/imx53-ard.dts                    |    6 +-
 arch/arm/boot/dts/imx53-evk.dts                    |    8 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |  121 +++++++++++++-
 arch/arm/boot/dts/imx53-smd.dts                    |   12 +-
 arch/arm/boot/dts/imx53.dtsi                       |   45 +++++-
 arch/arm/boot/dts/imx6q-arm2.dts                   |   13 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   50 ++++++-
 arch/arm/boot/dts/imx6q-sabresd.dts                |   53 ++++++
 arch/arm/boot/dts/imx6q.dtsi                       |  171 ++++++++++++++++++-
 arch/arm/mach-imx/Makefile.boot                    |    3 +-
 arch/arm/mach-imx/clk-imx51-imx53.c                |   40 +++++
 arch/arm/mach-imx/clk-imx6q.c                      |   35 +++--
 arch/arm/mach-imx/imx53-dt.c                       |   19 +++
 arch/arm/mach-imx/lluart.c                         |    6 +
 arch/arm/mach-imx/mach-imx6q.c                     |   55 ++++++-
 arch/arm/mach-imx/mach-mx51_babbage.c              |    6 +
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +
 arch/arm/plat-mxc/include/mach/mx6q.h              |    2 +
 26 files changed, 664 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-sabresd.dts
