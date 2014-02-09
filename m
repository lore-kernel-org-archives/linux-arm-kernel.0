From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 9 Feb 2014 21:48:54 +0800
Subject: [GIT PULL v2] ARM: imx: device tree changes for 3.15, take 1
Message-ID: <20140209134849.GB22132@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.15

for you to fetch changes up to ee97d154f0a81f87f0f88c99a3963da2ab5ad787:

  ARM: dts: imx28-m28cu3: Remove 'reset-active-high' (2014-02-09 21:33:52 +0800)

----------------------------------------------------------------
i.MX device tree changes for 3.15:
 - New SoC device tree support for imx35 and imx50
 - A good number of new board support: imx25-eukrea, imx28-duckbill,
   imx28-eukrea, Eukrea cpuimx35, imx50-evk, imx51-eukrea, imx53-voipac,
   MCIMX53-START-R and Ka-Ro TX53.
 - Quite some updates and tweaking on imx27 phycore and apf27dev boards
 - Add pinfunc headers for imx25, imx27 and imx50
 - Make pinctrl nodes board specific to avoid floating board specific
   device tree blob with so many unused pinctrl data
 - Use generic node name for fixed regulator
 - Use clock defines in imx5 DTS files
 - Use macros for interrupt and gpio flags
 - A plenty of random updates on various SoC and board device tree
   sources, adding pinctrl settings, device nodes, properties, aliases.

----------------------------------------------------------------
Aida Mynzhasova (1):
      ARM: dts: mxs: add auart2 pinmux to imx28.dtsi

Alexander Shiyan (22):
      ARM: dts: i.MX51: Update CPU node
      ARM: dts: i.MX51: Add dummy clock to AUDMUX
      ARM: dts: i.MX51: Switch to use standard IRQ flags definitions
      ARM: dts: i.MX51: Move usbphy0 node from AIPS1
      ARM: dts: i.MX51 boards: Switch to use standard GPIO flags definitions
      ARM: dts: imx51-babbage: Fix chipselect level for dataflash on spi0.1
      ARM: dts: imx51-babbage: Define FEC reset pin
      ARM: dts: imx27-phytec-phycore-som: Add on-flash BBT support
      ARM: dts: imx27-phytec-phycore-rdk: Add DT node for camera module
      ARM: dts: imx27-phytec-phycore-som: Update FEC node
      ARM: dts: i.MX27 boards: Switch to use standard GPIO and IRQ flags definitions
      ARM: dts: i.MX27: Configure GPIOs as "input" by default
      ARM: dts: imx27-phytec-phycore-som: Add pinctrl for CSPI1 and GPIOs used on module
      ARM: dts: imx27-phytec-phycore-som: Rename file to .dtsi
      ARM: dts: imx27-phytec-phycore-som: Add NFC pin group
      ARM: dts: imx27-phytec-phycore-rdk: Enable 1-Wire module
      ARM: dts: imx27-phytec-phycore-som: Add spi-cs-high property to PMIC
      ARM: dts: imx27-phytec-phycore-rdk: Add pingrp for SDHC
      ARM: dts: imx27-phytec-phycore-rdk: Add pinctrl definitions for WEIM
      ARM: dts: i.MX27: Add SSI nodes
      ARM: dts: imx53-evk: Remove board support
      ARM: dts: i.MX51: Switch to use standard definitions for input subsystem

Alexandre Belloni (3):
      ARM: dts: mxs: add #io-channel-cells to mx28 lradc
      ARM: dts: mxs: Add iio-hwmon to mx28 soc
      ARM: dts: mxs: Add iio-hwmon to mx23 soc

Denis Carikli (12):
      of: add vendor prefix for Eukrea Electromatique.
      ARM: dts: i.MX25: Add ssi clocks and DMA events.
      ARM: dts: i.MX25: Add sdma script path.
      ARM: dts: imx25.dtsi: Add a label for the Audio Multiplexer.
      ARM: dts: Add support for the cpuimx51 board from Eukrea and its baseboard.
      ARM: dts: imx25: Add pinctrl functions.
      ARM: dts: imx25.dtsi: label the iomuxc.
      ARM: dts: mxs: Add 18bit pin config for lcdif.
      ARM: dts: mxs: Add a new pin config for the usb0 ID.
      ARM: dts: Add support for the cpuimx25 board from Eukrea and its baseboard.
      ARM: dts: imx53: Add gpio and input dt includes.
      ARM: dts: Add support for the cpuimx35 board from Eukrea and its baseboard.

Eric B?nard (1):
      ARM: mxs: Add support for the eukrea-cpuimx28.

Fabio Estevam (2):
      ARM: dts: imx28-evk: Run I2C0 at 400kHz
      ARM: dts: imx28-m28cu3: Remove 'reset-active-high'

Greg Ungerer (3):
      ARM: dts: imx: add device tree pin definitions for the IMX50
      ARM: dts: imx: add IMX50 SoC device tree
      ARM: dts: imx: add device tree support for Freescale imx50evk board

Gwenhael Goavec-Merou (8):
      ARM: imx27-apf27dev: Add sdhci support
      ARM: dts: imx27-apf27dev: fix display size
      ARM: dts: imx27: imx27-apf27: add pinctrl for fec and uart1
      ARM: dts: imx27: imx27-apf27dev: add pinctrl for cspi, i2c, sdhc and framebuffer
      ARM: dts: apf28dev: set gpio polarity for usb regulator and pinctrl for regulator gpio
      ARM: imx28: add apf28 specific initialization (macaddr)
      ARM: dts: apf27dev: Add pwm support
      ARM: dts: imx27-apf27dev: Add pinctrl for cspi, sdhci, leds and keys

Huang Shijie (1):
      ARM: dts: vf610: use the interrupt macros

Lothar Wa?mann (1):
      ARM: dts: imx53: add support for Ka-Ro TX53 modules

Lucas Stach (3):
      ARM: imx53: use clock defines in DTS files
      ARM: imx51: use clock defines in DTS files
      ARM: imx50: use clock defines in DTS files

Marek Vasut (5):
      ARM: dts: imx53: Fix display pinmux for M53EVK
      ARM: dts: imx53: Fix backlight for M53EVK
      ARM: dts: imx53: Add USB support for M53EVK
      ARM: dts: imx53: Add AHCI SATA DT node
      ARM: dts: imx53: Enable AHCI SATA for M53EVK

Markus Pargmann (6):
      ARM: dts: imx27 pin functions
      ARM: dts: imx27 iomux device node
      ARM: dts: imx27 phyCARD-S pinctrl
      ARM: dts: imx27 phycore move uart1 to rdk
      ARM: dts: imx27 phycore pinctrl
      ARM: dts: imx5: use imx51-ssi

Maxime Ripard (2):
      ARM: mxs: cfa10049: Add NAU7802 ADCs to the device tree
      ARM: dts: cfa10036: Add dr_mode and phy_type properties to the DT

Michael Grzeschik (1):
      ARM: i.MX28: dts: rename usbphy pin names

Michael Heimpold (1):
      ARM: mxs: add support for I2SE's duckbill series

Peter Chen (1):
      ARM: dts: mxs: add mxs phy controller id

Robert Nelson (1):
      ARM: dts: imx53: Enable AHCI SATA for imx53-qsb

Rostislav Lisovy (4):
      ARM: dts: i.MX53: Internal keyboard controller
      ARM: dts: Add vendor prefix for Voipac Technologies s.r.o.
      ARM: dts: i.MX53: dts for Voipac x53-dmm-668 module
      ARM: dts: i.MX53: Devicetree for Voipac Baseboard using x53-dmm-668 module

Sascha Hauer (2):
      ARM: dts: imx53: Add mmc aliases
      ARM: dts: imx51: Add mmc aliases

Shawn Guo (5):
      ARM: dts: imx53: make pinctrl nodes board specific
      ARM: dts: imx51: make pinctrl nodes board specific
      ARM: dts: vf610: make pinctrl nodes board specific
      ARM: dts: imx53-mba53: create a container for fixed regulators
      ARM: dts: imx: use generic node name for fixed regulator

Steffen Trumtrar (3):
      ARM: dts: Add support for the i.MX35.
      ARM: dts: i.MX53: move common QSB nodes to new file
      ARM: dts: i.MX53: add support for MCIMX53-START-R

S?bastien Szymanski (1):
      ARM: dts: imx28-apf28dev: add user button

 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 arch/arm/boot/dts/Makefile                         |   13 +-
 arch/arm/boot/dts/imx23-evk.dts                    |    8 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |    5 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |    5 +-
 arch/arm/boot/dts/imx23.dtsi                       |    8 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   73 ++
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  174 ++++
 arch/arm/boot/dts/imx25-pinfunc.h                  |  494 +++++++++++
 arch/arm/boot/dts/imx25.dtsi                       |   18 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   38 +
 arch/arm/boot/dts/imx27-apf27dev.dts               |  149 +++-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   61 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts   |   42 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   97 +-
 ...ycore-som.dts => imx27-phytec-phycore-som.dtsi} |   95 +-
 arch/arm/boot/dts/imx27-pinfunc.h                  |  526 +++++++++++
 arch/arm/boot/dts/imx27.dtsi                       |  151 ++--
 arch/arm/boot/dts/imx28-apf28dev.dts               |   29 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |    5 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |    2 +
 arch/arm/boot/dts/imx28-cfa10037.dts               |    7 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |   31 +-
 arch/arm/boot/dts/imx28-cfa10057.dts               |    7 +-
 arch/arm/boot/dts/imx28-cfa10058.dts               |    7 +-
 arch/arm/boot/dts/imx28-duckbill.dts               |  121 +++
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts       |   71 ++
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts       |   50 ++
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |  326 +++++++
 arch/arm/boot/dts/imx28-evk.dts                    |   24 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   17 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   18 +-
 arch/arm/boot/dts/imx28-sps1.dts                   |    7 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |   23 +-
 arch/arm/boot/dts/imx28.dtsi                       |   65 +-
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |   81 ++
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  143 +++
 arch/arm/boot/dts/imx35.dtsi                       |  359 ++++++++
 arch/arm/boot/dts/imx50-evk.dts                    |  119 +++
 arch/arm/boot/dts/imx50-pinfunc.h                  |  923 ++++++++++++++++++++
 arch/arm/boot/dts/imx50.dtsi                       |  478 ++++++++++
 arch/arm/boot/dts/imx51-apf51.dts                  |   40 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |  102 ++-
 arch/arm/boot/dts/imx51-babbage.dts                |  238 ++++-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   93 ++
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  175 ++++
 arch/arm/boot/dts/imx51.dtsi                       |  459 ++--------
 arch/arm/boot/dts/imx53-ard.dts                    |   33 +-
 arch/arm/boot/dts/imx53-evk.dts                    |  126 ---
 arch/arm/boot/dts/imx53-m53evk.dts                 |  233 ++++-
 arch/arm/boot/dts/imx53-mba53.dts                  |   40 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  336 +++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  210 +----
 arch/arm/boot/dts/imx53-qsrb.dts                   |  158 ++++
 arch/arm/boot/dts/imx53-smd.dts                    |  119 ++-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |  175 +++-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |  315 +++++++
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |  243 ++++++
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  511 ++++++++++-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |  159 ++++
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |  277 ++++++
 arch/arm/boot/dts/imx53.dtsi                       |  663 +++-----------
 arch/arm/boot/dts/vf610-cosmic.dts                 |   29 +-
 arch/arm/boot/dts/vf610-twr.dts                    |   66 +-
 arch/arm/boot/dts/vf610.dtsi                       |  207 +----
 arch/arm/mach-mxs/mach-mxs.c                       |   33 +
 66 files changed, 8145 insertions(+), 1767 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
 create mode 100644 arch/arm/boot/dts/imx25-pinfunc.h
 rename arch/arm/boot/dts/{imx27-phytec-phycore-som.dts => imx27-phytec-phycore-som.dtsi} (61%)
 create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx28-duckbill.dts
 create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
 create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
 create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi
 create mode 100644 arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
 create mode 100644 arch/arm/boot/dts/imx35.dtsi
 create mode 100644 arch/arm/boot/dts/imx50-evk.dts
 create mode 100644 arch/arm/boot/dts/imx50-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx50.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
 delete mode 100644 arch/arm/boot/dts/imx53-evk.dts
 create mode 100644 arch/arm/boot/dts/imx53-qsb-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx53-qsrb.dts
 create mode 100644 arch/arm/boot/dts/imx53-tx53-x03x.dts
 create mode 100644 arch/arm/boot/dts/imx53-tx53-x13x.dts
 create mode 100644 arch/arm/boot/dts/imx53-voipac-bsb.dts
 create mode 100644 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
