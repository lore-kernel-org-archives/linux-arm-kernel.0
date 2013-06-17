From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 20:52:01 +0800
Subject: [GIT PULL] ARM: mxs: device tree changes for 3.11
Message-ID: <20130617125159.GG31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the device tree changes for 3.11.  There are a couple of
patches which should be soc changes.  I collected them on mxs/dt branch
and sent them together with device tree pull request here, considering
the volume for soc changes in this cycle is not high.  Hope it's fine.

Shawn

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-dt-3.11

for you to fetch changes up to d75f3d92e86e65b3cb9725e65f7278cc303511db:

  ARM: mxs: dt: Add Crystalfontz CFA-10057 device tree (2013-06-17 15:43:31 +0800)

----------------------------------------------------------------
mxs device tree changes for 3.11:

* A couple of new board support, cfa10055 and cfa10057
* A few updates on cfa10036 device tree source
* Some auart pinctrl data addition
* Adopt soc bus infrastructure for mach-mxs

----------------------------------------------------------------
Brian Lilly (3):
      ARM: cfa10049: Switch the chip select pin of the LCD controller
      ARM: mxs: dt: Add the Crystalfontz CFA-10055 device tree
      ARM: mxs: dt: Add Crystalfontz CFA-10057 device tree

Eric B?nard (3):
      ARM: mx28: add auart2 2 pins pinmux to imx28.dtsi
      ARM: mx28: add auart3 2 pins pinmux to imx28.dtsi
      ARM: mx28: add auart4 2 pins pinmux to imx28.dtsi

Fabio Estevam (2):
      ARM: dts: mx28: Adjust the digctl compatible string
      ARM: mxs: Use soc bus infrastructure

Gwenhael Goavec-Merou (1):
      ARM: dts: apf28dev: Add touchscreen support for APF28dev

Marek Vasut (1):
      ARM: mxs: Fix UARTs on M28EVK

Maxime Ripard (4):
      ARM: mxs: Remove init_irq declaration in machine description
      ARM: dts: cfa10036: Change the OLED display to SSD1306
      ARM: cfa10036: dt: Change i2c0 clock frequency
      ARM: cfa10036: Add USB0 OTG port

 arch/arm/boot/dts/Makefile           |    2 +
 arch/arm/boot/dts/imx28-apf28dev.dts |    1 +
 arch/arm/boot/dts/imx28-cfa10036.dts |   38 +++++--
 arch/arm/boot/dts/imx28-cfa10049.dts |    8 +-
 arch/arm/boot/dts/imx28-cfa10055.dts |  179 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-cfa10057.dts |  191 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx28-m28evk.dts   |   14 ++-
 arch/arm/boot/dts/imx28.dtsi         |   35 ++++++-
 arch/arm/mach-mxs/Kconfig            |    1 +
 arch/arm/mach-mxs/mach-mxs.c         |  129 +++++++++++++++++++++--
 10 files changed, 573 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx28-cfa10055.dts
 create mode 100644 arch/arm/boot/dts/imx28-cfa10057.dts
