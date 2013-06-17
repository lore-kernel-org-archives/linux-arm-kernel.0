From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 21:53:33 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.11
Message-ID: <20130617135331.GI31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is the imx device tree change set I collected for 3.11.  It's based
on imx-soc-3.11 change set for sake of dependency.  I'm including
drivers/bus/imx-weim.c change in the pull request, as it's been agreed
that we can do this before we find a maintainer for drivers/bus.

Shawn

The following changes since commit 3bfbc6cd9b41f937a134ba65a4a1eefba062b9a8:

  ARM: imx_v6_v7_defconfig: Enable Vybrid VF610 (2013-06-17 15:45:17 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.11

for you to fetch changes up to 93b331cec9e15210af1da9782bf699e5d3a61f0f:

  ARM: dts: imx27: Add VPU devicetree node (2013-06-17 16:04:34 +0800)

----------------------------------------------------------------
imx device tree changes for 3.11:

* A bunch of new board additions, imx6sl-evk, vf610-twr, imx53-tx53,
  imx53-m53evk and imx27-phytec-phycore
* Various pinctrl setting updates and additions
* Enable various on board peripherals, usb, audio, nor, display etc.
* Configure L2 cache data and tag latency from device tree
* Add imx-weim bus driver

----------------------------------------------------------------
Alexander Shiyan (11):
      ARM: dts: Add aliases for i.MX27 SPI controller
      ARM: dts: Add SPI support for i.MX27 Phytec PCM038 module
      ARM: dts: imx27-phytec-phycore: Add reset GPIO for FEC
      ARM: dts: imx27-phytec-phycore: Rename file to match functionality
      ARM: dts: imx27-phytec-phycore-som: Remove UART definitions
      ARM: dts: imx27-phytec-phycore-som: Add initial support for PCM970 RDK
      ARM: dts: i.MX27: Add DMA devicetree node
      ARM: dts: i.MX27: Add SDHC devicetree nodes
      ARM: dts: imx27-phytec-phycore-rdk: Add SDHC support
      ARM: dts: imx27-phytec-phycore-rdk: Add MTD name for NOR flash
      ARM: dts: imx27: Add VPU devicetree node

Christian Hemp (2):
      ARM: dts: imx6q: Add pinctrl for usdhc2 and enet
      ARM: dts: Phytec imx6q pfla02 and pbab01 support

Dirk Behme (2):
      ARM: dts: i.MX6: configure L2 cache data and tag latency
      i.MX6: Documentation: update from fsl,card-wired to non-removable

Gwenhael Goavec-Merou (2):
      ARM: imx27: Add PWM0 to device tree
      ARM: imx: apf51: add nfc support

Huang Shijie (13):
      ARM: dts: imx6q: remove the unused pins for gpmi-nand
      ARM: dts: imx6dl: add pinctrl for gpmi-nand
      ARM: dts: enable the gpmi-nand for imx6q{dl}-sabreauto boards
      ARM: dts: imx6dl: add a pinctrl for eCSPI1
      ARM: dts: imx6dl: add a gpio for hog
      ARM: dts: imx6q: add a gpio for hog
      ARM: dts: add SPI/NOR for mx6q{dl}-sabreauto boards
      drivers: bus: add a new driver for WEIM
      ARM: dts: imx6q{dl}: fix the pin conflict between SPI and WEIM
      ARM: dts: imx6qdl: add more information for WEIM
      ARM: dts: imx6q: add pinctrls for WEIM NOR
      ARM: dts: imx6dl: add pinctrls for WEIM NOR
      ARM: dts: imx6qdl-sabreauto: enable the WEIM NOR

Jingchang Lu (2):
      ARM: dts: add SoC level device tree source for VF610
      ARM: dts: add initial VF610 Tower board dts support

Jonas Andersson (3):
      ARM: dts: imx53: add cspi pinctrl
      ARM: dts: imx53: add ecspi2 pinctrl
      ARM: dts: imx53: add fec pinctrl

Marek Vasut (8):
      ARM: mx5: Add AUDMUX4 pinctrl data
      ARM: mx5: Add CAN1 pinctrl data
      ARM: mx5: Add I2C1 pinctrl data
      ARM: mx5: Add I2C2 pinctrl data
      ARM: mx5: Add NAND pinctrl data
      ARM: mx5: Add LCD IPU pinctrl data
      ARM: mx5: Add PWM1 pinctrl data
      ARM: mx5: Add support for DENX M53EVK

Markus Niebel (4):
      ARM i.MX53: mba53: add sound support
      ARM i.MX53: mba53: add missing gpio stuff for pca9554
      ARM i.MX53: mba53: use reset gpio for FEC
      ARM i.MX53: mba53: add DI1_CLK to pinctrl for disp1

Michael Grzeschik (4):
      ARM: dts: imx: add imx5x usbmisc entries
      ARM: dts: imx: add imx5x usb clock DT lookups
      ARM: dts: imx: use usb-nop-xceiv usbphy entries for imx5x
      ARM: dts: imx: imx53-qsb.dts: enable usbotg and usbh1

Michael Olbrich (1):
      ARM i.MX53: mba53: enable usbotg & usbh1

Nicolin Chen (7):
      ARM: dts: imx6qdl-sabresd: add clko1 iomux configuration
      ARM: dtsi: imx6q/imx6dl: Add a pinctrl for I2C1
      ARM: dtsi: imx6dl: Add a pinctrl for AUDMUX
      ARM: dtsi: imx6qdl-sabresd: add a fixed regulator for WM8962
      ARM: dtsi: imx6qdl-sabresd: Add WM8962 CODEC support
      ARM: dtsi: imx6qdl-sabresd: Enable SSI2 and AUDMUX
      ARM: dtsi: imx6qdl-sabresd: Enable WM8962 audio support

Philipp Zabel (5):
      ARM i.MX53: dts: add i2c aliases
      ARM i.MX53: tqma53: fix pinctrl settings
      ARM i.MX53: tqma53: rev 300 specific pin configuration
      ARM i.MX53: Add TVE entry to i.MX53 dtsi
      ARM i.MX53: mba53: add Tevision Encoder

Rogerio Pimentel (1):
      ARM: dts: mx53qsb: Add support for parallel display

Sascha Hauer (2):
      ARM i.MX53: tqma53: Fix interrupt polarity for the mc34708
      ARM i.MX53: mba53: Add display support

Shawn Guo (6):
      Merge tag 'imx-soc-3.11' into imx/dt
      ARM: imx: move imx53-qsb audio codec clk lookup into DT
      ARM: dts: add device tree source for imx6sl SoC
      ARM: dts: imx6sl: add initial imx6sl-evk support
      ARM: dts: imx6qdl: remove redundant usbmisc label
      ARM: dts: imx6qdl: remove redundant ocotp node

Steffen Trumtrar (9):
      ARM: i.MX53: add audmux pinctrl
      ARM: i.MX53: add csi pinctrl
      ARM: i.MX53: add ecspi pinctrl
      ARM: i.MX53: add pwm2 pinctrl
      ARM: i.MX53: add uart1 pinctrl
      ARM: i.MX53: add uart2 pinctrl
      ARM: dts: add Ka-Ro tx53 devicetree
      ARM i.MX53: tqma53: add WP/CD pinctrl and vmmc to esdhc2
      ARM i.MX53: mba53: fix lvds/disp pinctrl

Stephen Warren (1):
      ARM: mxc: fix gpio-ranges for VF610

 Documentation/devicetree/bindings/bus/imx-weim.txt |   49 ++
 .../bindings/pinctrl/fsl,imx-pinctrl.txt           |    2 +-
 arch/arm/boot/dts/Makefile                         |    9 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   37 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts     |  179 +++++
 arch/arm/boot/dts/imx27-phytec-phycore.dts         |   79 --
 arch/arm/boot/dts/imx27.dtsi                       |   80 +-
 arch/arm/boot/dts/imx51-apf51.dts                  |    7 +
 arch/arm/boot/dts/imx51.dtsi                       |   23 +
 arch/arm/boot/dts/imx53-m53evk.dts                 |  259 +++++++
 arch/arm/boot/dts/imx53-mba53.dts                  |  175 ++++-
 arch/arm/boot/dts/imx53-qsb.dts                    |   36 +
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   45 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  122 +++
 arch/arm/boot/dts/imx53.dtsi                       |  297 ++++++-
 arch/arm/boot/dts/imx6dl-sabreauto.dts             |    8 +
 arch/arm/boot/dts/imx6dl-sabresd.dts               |    1 +
 arch/arm/boot/dts/imx6dl.dtsi                      |  112 +++
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts          |   34 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   74 ++
 arch/arm/boot/dts/imx6q-sabreauto.dts              |    8 +
 arch/arm/boot/dts/imx6q-sabresd.dts                |    1 +
 arch/arm/boot/dts/imx6q.dtsi                       |  100 ++-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   41 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   66 ++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   13 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |   74 ++
 arch/arm/boot/dts/imx6sl.dtsi                      |  779 +++++++++++++++++++
 arch/arm/boot/dts/vf610-pinfunc.h                  |  810 ++++++++++++++++++++
 arch/arm/boot/dts/vf610-twr.dts                    |   57 ++
 arch/arm/boot/dts/vf610.dtsi                       |  464 +++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |    2 -
 arch/arm/mach-imx/mach-imx53.c                     |   16 -
 drivers/bus/Kconfig                                |    9 +
 drivers/bus/Makefile                               |    1 +
 drivers/bus/imx-weim.c                             |  138 ++++
 36 files changed, 4036 insertions(+), 171 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycore-som.dts
 delete mode 100644 arch/arm/boot/dts/imx27-phytec-phycore.dts
 create mode 100644 arch/arm/boot/dts/imx53-m53evk.dts
 create mode 100644 arch/arm/boot/dts/imx53-tx53.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-pbab01.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sl-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6sl.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-pinfunc.h
 create mode 100644 arch/arm/boot/dts/vf610-twr.dts
 create mode 100644 arch/arm/boot/dts/vf610.dtsi
 create mode 100644 drivers/bus/imx-weim.c
