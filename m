From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 16 Sep 2014 12:49:41 +0800
Subject: [GIT PULL 3/3] ARM: imx: device tree changes for 3.18
Message-ID: <20140916044940.GC25583@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

This is the i.MX device tree updates for 3.18.  Per request from MFD
maintainer Lee Jones, the following tag was pull into my DT branch to
to avoid potential conflicts.

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-arm-v3.18

Besides of that, the pull request is also based on imx-soc-3.18 one for
sake of dependency.

Please pull, thanks.

Shawn

The following changes since commit 155b2fd3d6862509ccb356ff20fff8115d36eedb:

  Merge branch 'imx/soc' into imx/dt (2014-09-16 10:24:58 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.18

for you to fetch changes up to 2b2244a3e7c3d537f436a3580999b3032628d17d:

  ARM: dts: imx6: make gpt per clock can be from OSC (2014-09-16 10:27:32 +0800)

----------------------------------------------------------------
The i.MX device tree changes for 3.18:
 - Device tree support for i.MX ADS and Armadeus APF9328 boards
 - Enable thermal sensor support for i.MX6SL
 - Add LCD support for i.MX6SL EVK board
 - Fix display duplicate name for a bunch of board dts files
 - Configure imx6qdl-sabresd board pins locally to remove the dependency
   on bootloader
 - A set of imx28-tx28 board dts updates from Lothar
 - Add pci config space as platform resource
 - Enable devices RTC, I2C and HDMI for nitrogen6x board
 - Split HummingBoard DT to support s/dl and d/q
 - mSATA and IR input support for HummingBoard
 - Add SSI baud clock for i.MX6 device trees
 - Add USB support for vf610-colibri and vf610-twr boards
 - A set of cleanup and updates on Gateworks boards

----------------------------------------------------------------
Alexander Shiyan (4):
      ARM: dts: i.MX1: Add i.MX1 template
      ARM: i.MX: dts: Add support for the Freescale i.MX1 ADS board
      ARM: i.MX: dts: Add simple-card support
      ARM: dts: Add support for the i.MX1 Armadeus APF9328 board

Anson Huang (2):
      ARM: dts: add thermal sensor support for i.mx6sl
      ARM: dts: imx6: make gpt per clock can be from OSC

Bill Pringlemeir (1):
      ARM: dts: vf610-twr: Add ttyLP2 device.

Fabio Estevam (14):
      ARM: dts: imx6sl-evk.dts: Keep pinctrl nodes sorted
      ARM: dts: imx6sl-evk: Add LCD support
      ARM: dts: imx6sx: Add LCDIF compatible strings
      ARM: dts: imx6x-sdb: Add LCD support
      ARM: dts: imx28-evk: Fix display duplicate name warning
      ARM: dts: imx23-evk: Fix display duplicate name warning
      ARM: dts: imx6sl-evk: Fix display duplicate name warning
      ARM: dts: imx28-apx4devkit: Fix display duplicate name warning
      ARM: dts: imx28-apf28dev: Fix display duplicate name warning
      ARM: dts: imx28-cfa100: Fix display duplicate name warning
      ARM: dts: imx28-m28cu: Fix display duplicate name warning
      ARM: dts: imx28-tx28: Fix display duplicate name warning
      ARM: dts: imx28-m28evk: Fix display duplicate name warning
      ARM: dts: imx6qdl-sabresd: Configure the pins locally

Lothar Wa?mann (4):
      ARM: dts: imx28-tx28: remove spidev labels and add third instance of spidev
      ARM: dts: imx28-tx28: use GPIO flags
      ARM: dts: imx28-tx28: add spi-gpio as alternative for spi-mxs
      ARM: dts: imx28-tx28: add alias for CAN XCVR regulator

Lucas Stach (2):
      ARM: dts: imx6qdl-sabresd: add always on pcie regulator
      ARM: imx6: add pci config space as platform resource

Marc Kleine-Budde (1):
      ARM: dts: imx28: add pinmuxing for mmc1

Markus Pargmann (1):
      ARM: dts: imx25: remove imx35-sdma compatible

Michael Grzeschik (1):
      ARM: dts: imx25-pinfunc: Add several pin configurations

Michael Olbrich (2):
      ARM: dts: nitrogen6x: add i2c2
      ARM: dts: nitrogen6x: add hdmi

Philipp Zabel (2):
      ARM: dts: nitrogen6x: add i2c3
      ARM: dts: nitrogen6x: Add Intersil ISL1208 RTC

Philippe Reynes (1):
      ARM: dts: apf27dev: add max1027 in the dts

Rabeeh Khoury (3):
      ARM: dts: hummingboard: Split HummingBoard DT to support s/dl and d/q
      ARM: dts: hummingboard: add mSATA support for iMX6 quad/dual HummingBoard
      ARM: dts: hummingboard: gpio-ir on gpio 3,5

Russell King (1):
      ARM: dts: hummingboard: fix configuration of IR input

Shengjiu Wang (2):
      ARM: dts: imx6qdl: add baud clock and clock-names for ssi
      ARM: dts: imx6sl: add baud clock and clock-names for ssi

Stefan Agner (5):
      ARM: dts: vf610-colibri: split device tree for carrier boards
      ARM: dts: vf610: Add USB PHY and controller
      ARM: dts: vf610: Add usbmisc for non-core registers
      ARM: dts: vf610-colibri: Add USB support
      ARM: dts: vf610-twr: Add USB support

Steffen Trumtrar (1):
      ARM: dts: i.MX53: add pmu node

Tim Harvey (7):
      ARM: dts: Gateworks GW5520 support (i.MX6)
      ARM: dts: imx: ventana: remove unsupported dt nodes
      ARM: dts: imx: ventana: remove unused aliases
      ARM: dts: imx: ventana: use gpio constants
      ARM: dts: imx: ventana: configure padconf for all pins
      ARM: dts: imx: ventana: cleanup pinctrl groups
      ARM: dts: imx: ventana: add canbus support for GW52xx

Uwe Kleine-K?nig (1):
      ARM: dts: imx28: add alternative pinmuxing for i2c1

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   4 +-
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/imx1-ads.dts                     | 152 +++++++++
 arch/arm/boot/dts/imx1-apf9328.dts                 | 129 ++++++++
 arch/arm/boot/dts/imx1-pinfunc.h                   | 302 ++++++++++++++++++
 arch/arm/boot/dts/imx1.dtsi                        | 266 ++++++++++++++++
 arch/arm/boot/dts/imx23-evk.dts                    |   4 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  |  33 +-
 arch/arm/boot/dts/imx25.dtsi                       |   4 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |  17 ++
 arch/arm/boot/dts/imx28-apf28dev.dts               |   4 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   4 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |   4 +-
 arch/arm/boot/dts/imx28-cfa10055.dts               |   4 +-
 arch/arm/boot/dts/imx28-cfa10056.dts               |   4 +-
 arch/arm/boot/dts/imx28-cfa10057.dts               |   4 +-
 arch/arm/boot/dts/imx28-cfa10058.dts               |   4 +-
 arch/arm/boot/dts/imx28-evk.dts                    |   4 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   4 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   4 +-
 arch/arm/boot/dts/imx28-tx28.dts                   | 107 +++++--
 arch/arm/boot/dts/imx28.dtsi                       |  43 +++
 arch/arm/boot/dts/imx35.dtsi                       |   1 +
 arch/arm/boot/dts/imx50.dtsi                       |   2 +
 arch/arm/boot/dts/imx51.dtsi                       |   3 +
 arch/arm/boot/dts/imx53.dtsi                       |   8 +
 arch/arm/boot/dts/imx6dl-gw552x.dts                |  20 ++
 arch/arm/boot/dts/imx6dl-hummingboard.dts          | 203 +------------
 arch/arm/boot/dts/imx6q-gw5400-a.dts               | 203 ++++++-------
 arch/arm/boot/dts/imx6q-gw552x.dts                 |  24 ++
 arch/arm/boot/dts/imx6q-hummingboard.dts           |  21 ++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              | 192 +++++-------
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              | 314 ++++++++-----------
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              | 338 ++++++++-------------
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              | 278 ++++++++---------
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              | 267 ++++++++++++++++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        | 200 ++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  38 +++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  45 ++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  24 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   | 104 ++++++-
 arch/arm/boot/dts/imx6sl.dtsi                      |  31 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |  93 ++++++
 arch/arm/boot/dts/imx6sx.dtsi                      |   7 +-
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts        |  46 +++
 .../dts/{vf610-colibri.dts => vf610-colibri.dtsi}  |  22 +-
 arch/arm/boot/dts/vf610-twr.dts                    |  25 +-
 arch/arm/boot/dts/vf610.dtsi                       |  60 +++-
 48 files changed, 2600 insertions(+), 1077 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx1-ads.dts
 create mode 100644 arch/arm/boot/dts/imx1-apf9328.dts
 create mode 100644 arch/arm/boot/dts/imx1-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-gw552x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw552x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw552x.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-colibri-eval-v3.dts
 rename arch/arm/boot/dts/{vf610-colibri.dts => vf610-colibri.dtsi} (92%)
