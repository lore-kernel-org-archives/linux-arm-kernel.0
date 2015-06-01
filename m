From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  1 Jun 2015 15:53:25 +0800
Subject: [GIT PULL 3/4] ARM: imx: device tree changes for 4.2
In-Reply-To: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
References: <1433145206-2508-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1433145206-2508-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please be noted that imx/soc branch was merged into imx/dt to resolve
a dependency between i.MX7D device tree source and clock driver on those
clock ID macros.

Shawn

The following changes since commit a75d9fd40d1ae4ddc7c7bc129a2ee75a9f81bb83:

  ARM: imx: add imx7d clk tree support (2015-05-19 14:41:09 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.2

for you to fetch changes up to 38b16dee035307c6491675ae84b40d1bd60e0058:

  ARM: dts: imx6: add DT for aristainetos2 board (2015-05-27 20:03:21 +0800)

----------------------------------------------------------------
The i.MX device tree changes for 4.2:
 - Add device tree for i.MX7D SoC and imx7d-sdb board
 - New i.MX6 board support: Armadeus Systems APF6, Gateworks GW5510,
   and aristainetos2 boards
 - Change LVDS to use simple-panel for nitrogen6x and sabrelite boards
 - Add Wifi/Bluetooth devices support for cubox-i board
 - Remove unused regulators and correct OTG roles setting for
   imx6sl-warp board
 - Add I2C support for imx23-olinuxino board
 - Move imx6qdl HDMI device to a better place
 - Add power-domain for imx6qdl CODA device

----------------------------------------------------------------
Cory Tusar (1):
      ARM: dts: vf610: Nomenclature fixup for PTC12 pin used in RMII mode.

Eric Nelson (2):
      ARM: dts: nitrogen6x: use simple-panel instead of display-timings for LVDS0
      ARM: dts: sabrelite: use simple-panel instead of display-timings for LVDS0

Fabio Estevam (7):
      ARM: dts: hummingboard: Remove unneeded 'fsl,mode' property
      ARM: dts: imx6qdl-hummingboard: Add PCIe support
      ARM: dts: imx6sl-warp: Remove unused regulator
      ARM: dts: imx6sl-warp: Remove USB regulators
      ARM: dts: imx6sl-warp: Fix OTG roles
      ARM: dts: cubox-i: add support for Broadcom Wifi/Bluetooth devices
      ARM: dts: cubox-i/hummingboard: Fix the license text

Frank Li (4):
      ARM: dts: add pinfunc include file to support imx7d
      Document: dt: binding: imx: update document for imx7d support
      ARM: dts: add imx7d soc dtsi file
      ARM: dts: add imx7d-sdb support

Harald Geyer (2):
      ARM: dts: imx23: Add i2c support
      ARM: dts: imx23-olinuxino: Add i2c support

Heiko Schocher (1):
      ARM: dts: imx6: add DT for aristainetos2 board

Lucas Stach (1):
      ARM: dts: imx6qdl: move HDMI controller to right location in DT

Philipp Zabel (1):
      ARM: dts: imx6qdl: Add power-domain phandle to CODA device node

Shawn Guo (1):
      Merge branch 'imx/soc' into imx/dt

S??bastien Szymanski (1):
      ARM: dts: Armadeus Systems APF6 family support (i.MX6)

Thomas Niederpr??m (1):
      ARM: mxs: fix in tree users of ssd1306

Tim Harvey (1):
      ARM: dts: Gateworks GW5510 support (i.MX6)

 .../devicetree/bindings/clock/imx7d-clock.txt      |   13 +
 .../bindings/pinctrl/fsl,imx7d-pinctrl.txt         |   27 +
 arch/arm/boot/dts/Makefile                         |    8 +
 arch/arm/boot/dts/imx23-olinuxino.dts              |    6 +
 arch/arm/boot/dts/imx23.dtsi                       |   40 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |    3 +
 arch/arm/boot/dts/imx6dl-apf6dev.dts               |   60 ++
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |  159 +++
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts       |   97 ++
 arch/arm/boot/dts/imx6dl-cubox-i.dts               |    5 +-
 arch/arm/boot/dts/imx6dl-gw551x.dts                |   55 ++
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |    5 +-
 arch/arm/boot/dts/imx6q-apf6dev.dts                |   64 ++
 arch/arm/boot/dts/imx6q-cubox-i.dts                |    5 +-
 arch/arm/boot/dts/imx6q-gw551x.dts                 |   55 ++
 arch/arm/boot/dts/imx6q-hummingboard.dts           |    5 +-
 arch/arm/boot/dts/imx6qdl-apf6.dtsi                |  158 +++
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |  479 +++++++++
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |  633 ++++++++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |    5 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  314 ++++++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |   19 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |    5 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |  108 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   30 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   30 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   57 +-
 arch/arm/boot/dts/imx6sl-warp.dts                  |   39 +-
 arch/arm/boot/dts/imx7d-pinfunc.h                  | 1038 ++++++++++++++++++++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  408 ++++++++
 arch/arm/boot/dts/imx7d.dtsi                       |  486 +++++++++
 arch/arm/boot/dts/vf-colibri.dtsi                  |    2 +-
 arch/arm/boot/dts/vf610-cosmic.dts                 |    2 +-
 arch/arm/boot/dts/vf610-pinfunc.h                  |    2 +-
 arch/arm/boot/dts/vf610-twr.dts                    |    2 +-
 35 files changed, 4303 insertions(+), 121 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
 create mode 100644 arch/arm/boot/dts/imx6dl-apf6dev.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw551x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apf6dev.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw551x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apf6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw551x.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx7d-sdb.dts
 create mode 100644 arch/arm/boot/dts/imx7d.dtsi
