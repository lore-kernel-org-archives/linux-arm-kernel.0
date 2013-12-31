From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 31 Dec 2013 13:44:29 +0800
Subject: [GIT PULL 2/2] ARM: imx: device tree changes for 3.14
Message-ID: <20131231054427.GA22383@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pull-request has the following two dependencies:

 - The first pull-request, i.e. [GIT PULL 1/2] ARM: imx: soc changes for 3.14

 - The pinctrl 'devel' branch below.

     git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel

   Linus Walleij promised that the branch will be stable at least from
   the point I pulled into my tree, that is commit 31d610f (pinctrl:
   imx1-core populate subdevices).

Please pull, thanks.

Shawn

The following changes since commit 43cb02365bc4aacdef642ec0d3e913ab76fbee02:

  Merge commit '31d610f' into imx/dt (2013-12-31 11:02:39 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.14

for you to fetch changes up to 52bfd188eccf69ee90d8279bccfbb041c9165080:

  ARM: dts: imx6qdl-sabresd: Add PFUZE100 support (2013-12-31 11:10:02 +0800)

----------------------------------------------------------------
i.MX device tree changes for 3.14:
 - New SoC device tree support for imx35 and imx50.
 - A good number of new i.MX6 boards support: SolidRun HummingBoard,
   cm-fx6, dmo-edmqmx6, nitrogen6x, and Gateworks Ventana gw5xxx family.
 - A few other new i.MX boards support: imx25-eukrea, imx28-duckbill,
   imx28-eukrea, imx50-evk, imx51-eukrea, and imx53-voipac.
 - Add pinfunc headers for imx25, imx27 and imx50.
 - Make pinctrl nodes board specific to avoid floating board specific
   device tree blob with so many unused pinctrl data.
 - Use clock defines in imx5 DTS files.
 - Update imx6q-sabrelite device tree and add Dual Lite/Solo support.
 - Use GPIO_6 for FEC interrupt to workaround a hardware bug (ERR006687
   ENET: Only the ENET wake-up interrupt request can wake the system
   from Wait mode.)
 - A plenty of random updates on various SoC and board device tree
   sources, adding pinctrl settings, device nodes, properties, etc.

----------------------------------------------------------------
Aida Mynzhasova (1):
      ARM: dts: mxs: add auart2 pinmux to imx28.dtsi

Alexander Shiyan (23):
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
      ARM: dts: i.MX: Move include "imxXX-pinfunc.h" into "imxXX-pingrp.h"
      ARM: dts: imx27-phytec-phycore-rdk: Change pinctrl settings for I2C1
      ARM: dts: imx27-phytec-phycore-som: trivial: Typo fix
      ARM: dts: imx27-phytec-phycore-som: Add pinctrl for CSPI1 and GPIOs used on module
      ARM: dts: imx27-phytec-phycore-som: Rename file to .dtsi
      ARM: dts: imx27-phytec-phycore-som: Add NFC pin group
      ARM: dts: imx27-phytec-phycore-rdk: Enable 1-Wire module
      ARM: dts: imx27-phytec-phycore-som: Add spi-cs-high property to PMIC
      ARM: dts: i.MX27: Add missing pullup settings for SDHC pin groups
      ARM: dts: imx27-phytec-phycore-rdk: Add pingrp for SDHC
      ARM: dts: imx27-phytec-phycore-rdk: Add pinctrl definitions for WEIM

Alexandre Belloni (3):
      ARM: dts: mxs: add #io-channel-cells to mx28 lradc
      ARM: dts: mxs: Add iio-hwmon to mx28 soc
      ARM: dts: mxs: Add iio-hwmon to mx23 soc

Anson Huang (5):
      ARM: dts: imx6q: update setting of VDDARM_CAP voltage
      ARM: dts: imx6q: add vddsoc/pu setpoint info
      ARM: dts: imx6dl: enable cpufreq support
      ARM: dts: imx6qdl: add necessary thermal clk
      ARM: dts: imx6qdl-sabresd: Add power key support

Denis Carikli (13):
      of: add vendor prefix for Eukrea Electromatique.
      ARM: dts: i.MX25: Add ssi clocks and DMA events.
      ARM: dts: i.MX25: Add sdma script path.
      ARM: dts: imx25.dtsi: Add a label for the Audio Multiplexer.
      ARM: dts: imx51.dtsi: Add some pinmux pins.
      ARM: dts: Add support for the cpuimx51 board from Eukrea and its baseboard.
      ARM: dts: imx25: Add pinctrl functions and groups.
      ARM: dts: imx25.dtsi: label the iomuxc.
      ARM: dts: mxs: Add 18bit pin config for lcdif.
      ARM: dts: mxs: Add a new pin config for the usb0 ID.
      ARM: dts: Add support for the cpuimx25 board from Eukrea and its baseboard.
      ARM: dts: mbimxsd25: Add sound support.
      ARM: dts: mbimxsd51: Add sound support.

Eric B?nard (1):
      ARM: mxs: Add support for the eukrea-cpuimx28.

Fabio Estevam (6):
      ARM: dts: imx6q-udoo: Add Ethernet support
      ARM: dts: imx6q-sabrelite: Remove duplicate GPIO entry
      ARM: dts: imx6q-sabrelite: Place 'status' as the last node
      ARM: dts: imx28-evk: Run I2C0 at 400kHz
      ARM: dts: imx6: Use 'vddarm' as the regulator name
      ARM: dts: imx6qdl-sabresd: Add PFUZE100 support

Greg Ungerer (3):
      ARM: dts: imx: add device tree pin definitions for the IMX50
      ARM: dts: imx: add IMX50 SoC device tree
      ARM: dts: imx: add device tree support for Freescale imx50evk board

Gwenhael Goavec-Merou (10):
      ARM: imx27-apf27dev: Add sdhci support
      ARM: dts: imx27-apf27dev: fix display size
      ARM: imx27: add pingroups for cspi, sdhc and framebuffer
      ARM: dts: imx27: imx27-apf27: add pinctrl for fec and uart1
      ARM: dts: imx27: imx27-apf27dev: add pinctrl for cspi, i2c, sdhc and framebuffer
      ARM: dts: apf28dev: set gpio polarity for usb regulator and pinctrl for regulator gpio
      ARM: imx28: add apf28 specific initialization (macaddr)
      ARM: imx27: add pwm pingrp
      ARM: dts: apf27dev: Add pwm support
      ARM: dts: imx27-apf27dev: Add pinctrl for cspi, sdhci, leds and keys

John Tobias (1):
      ARM: dts: imx6sl: Adding cpu frequency and VDDSOC/PU table.

Lothar Wa?mann (3):
      ARM: dts: imx6qdl: add aliases for can interfaces
      ARM: dts: imx6qdl: add pingroup for enet interface in RMII mode
      ARM: dts: imx6qdl: add new pingroup for audmux

Lucas Stach (3):
      ARM: imx53: use clock defines in DTS files
      ARM: imx51: use clock defines in DTS files
      ARM: imx50: use clock defines in DTS files

Marek Vasut (6):
      ARM: dts: imx53: Fix display pinmux for M53EVK
      ARM: dts: imx53: Fix backlight for M53EVK
      ARM: dts: imx53: Add USB support for M53EVK
      ARM: dts: imx53: Add AHCI SATA DT node
      ARM: dts: imx53: Enable AHCI SATA for M53EVK
      ARM: dts: imx6q-sabrelite: Enable PCI express

Markus Pargmann (6):
      ARM: dts: imx27 pin functions
      ARM: dts: imx27 pingroups
      ARM: dts: imx27 iomux device node
      ARM: dts: imx27 phyCARD-S pinctrl
      ARM: dts: imx27 phycore move uart1 to rdk
      ARM: dts: imx27 phycore pinctrl

Maxime Ripard (2):
      ARM: mxs: cfa10049: Add NAU7802 ADCs to the device tree
      ARM: dts: cfa10036: Add dr_mode and phy_type properties to the DT

Michael Grzeschik (1):
      ARM: i.MX28: dts: rename usbphy pin names

Michael Heimpold (1):
      ARM: mxs: add support for I2SE's duckbill series

Nicolin Chen (2):
      ARM: dts: imx: specify the value of audmux pinctrl instead of 0x80000000
      ARM: dts: imx6qdl: add spdif support for sabreauto

Peter Chen (3):
      ARM: dts: imx6q-arm2: enable USB OTG
      ARM: dts: imx6: add anatop phandle for usbphy
      ARM: dts: imx: add mxs phy controller id

Philipp Zabel (1):
      ARM: dts: imx6q-sabrelite: PHY reset is active-low

Robert Nelson (1):
      ARM: dts: imx53: Enable AHCI SATA for imx53-qsb

Rostislav Lisovy (8):
      ARM: dts: i.MX53: Add alternate pinmux option for i2c_3
      ARM: dts: i.MX53: Internal keyboard controller
      ARM: dts: Add vendor prefix for Voipac Technologies s.r.o.
      ARM: dts: i.MX53: dts for Voipac x53-dmm-668 module
      ARM: dts: i.MX53: Devicetree for Voipac Baseboard using x53-dmm-668 module
      ARM: dts: voipac: Improve fixed voltage regulator definition
      ARM: i.MX53: dts: NAND flash controller
      ARM: i.MX53: dts: USB host controller

Russell King (1):
      ARM: imx: initial SolidRun HummingBoard support

Shawn Guo (8):
      ARM: dts: imx6qdl: make pinctrl nodes board specific
      ARM: dts: imx6sl: make pinctrl nodes board specific
      ARM: dts: imx53: make pinctrl nodes board specific
      ARM: dts: imx51: make pinctrl nodes board specific
      ARM: dts: imx50: make pinctrl nodes board specific
      ARM: dts: imx53-mba53: create a container for fixed regulators
      ARM: dts: imx: use generic node name for fixed regulator
      ARM: dts: vf610: make pinctrl nodes board specific

Silvio F (2):
      DT: Add Data Modul vendor prefix
      ARM: dts: imx6: Add support for imx6q dmo edmqmx6

Steffen Trumtrar (1):
      ARM: dts: Add support for the i.MX35.

Tim Harvey (3):
      ARM: dts: disable flexcan by default
      ARM: dts: added several new imx-pinmux groups
      ARM: dts: add Gateworks Ventana support

Troy Kisky (30):
      ARM: dts: imx: pinfunc: add MX6QDL_PAD_SD1_CLK__OSC32K_32K_OUT
      ARM: dts: imx: imx6qdl.dtsi: add mipi_csi tag
      ARM: dts: imx: imx6q.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6dl.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6sl.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6qdl.dtsi: use IRQ_TYPE_LEVEL_HIGH
      ARM: dts: imx: imx6sl/qdl-pingrp: reorganize USDHCx pad groups
      ARM: dts: imx: sabrelite: add Dual Lite/Solo support
      ARM: dts: imx6qdl-sabrelite: Add uart1 support
      ARM: dts: imx6qdl-sabrelite: remove usdhc4 wp-gpio
      ARM: dts: imx6qdl-sabrelite: move pcie to imx6qdl-sabrelite.dtsi
      ARM: dts: imx6qdl-sabrelite: move USDHC4 CD to pinctrl_usdhc4
      ARM: dts: imx6qdl-sabrelite: move USDHC3 CD/WP to pinctrl_usdhc3
      ARM: dts: imx6qdl-sabrelite: move spi-nor CS to pinctrl_ecspi1
      ARM: dts: imx6qdl-sabrelite: move usbotg power enable to pinctrl_usbotg
      ARM: dts: imx6qdl-sabrelite: move phy reset to pinctrl_enet
      ARM: dts: imx6qdl-sabrelite: explicitly set pad for SGTL5000 sys_mclk
      ARM: dts: imx6qdl-sabrelite: add pwms for backlights
      ARM: dts: imx6qdl-sabrelite: add skews for Micrel phy
      ARM: dts: imx6qdl-sabrelite: fix ENET group
      ARM: dts: imx6qdl-sabrelite: Add over-current pin to usbotg
      ARM: dts: imx: add nitrogen6x board
      ARM: dts: imx6qdl-sabrelite: add gpio-keys
      ARM: dts: imx: pinfunc: add MX6QDL_PAD_GPIO_6__ENET_IRQ
      ARM: dts: imx6qdl: add pingroups for enet with GPIO6 interrupt
      ARM: dts: imx6qdl-sabrelite: use MX6QDL_ENET_PINGRP_RGMII_MD
      ARM: dts: imx6qdl: use interrupts-extended for fec
      ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC interrupt.
      ARM: dts: imx6qdl-sabreauto: use GPIO_6 for FEC interrupt.
      ARM: dts: imx6q-arm2: use GPIO_6 for FEC interrupt.

Valentin Raevsky (1):
      ARM: dts: Add initial support for cm-fx6.

 .../devicetree/bindings/vendor-prefixes.txt        |    3 +
 arch/arm/boot/dts/Makefile                         |   23 +-
 arch/arm/boot/dts/imx23-evk.dts                    |    8 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |    5 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |    5 +-
 arch/arm/boot/dts/imx23.dtsi                       |    8 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   60 ++
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  128 +++
 arch/arm/boot/dts/imx25-pinfunc.h                  |  494 +++++++++++
 arch/arm/boot/dts/imx25-pingrp.h                   |   81 ++
 arch/arm/boot/dts/imx25.dtsi                       |   18 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   16 +
 arch/arm/boot/dts/imx27-apf27dev.dts               |   98 ++-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   50 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts   |   20 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   86 +-
 ...ycore-som.dts => imx27-phytec-phycore-som.dtsi} |   65 +-
 arch/arm/boot/dts/imx27-pinfunc.h                  |  526 +++++++++++
 arch/arm/boot/dts/imx27-pingrp.h                   |  151 ++++
 arch/arm/boot/dts/imx27.dtsi                       |  127 +--
 arch/arm/boot/dts/imx28-apf28dev.dts               |   18 +-
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
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   16 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |   18 +-
 arch/arm/boot/dts/imx28-sps1.dts                   |    7 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |   23 +-
 arch/arm/boot/dts/imx28.dtsi                       |   65 +-
 arch/arm/boot/dts/imx35-pingrp.h                   |  104 +++
 arch/arm/boot/dts/imx35.dtsi                       |  360 ++++++++
 arch/arm/boot/dts/imx50-evk.dts                    |   97 ++
 arch/arm/boot/dts/imx50-pinfunc.h                  |  923 ++++++++++++++++++++
 arch/arm/boot/dts/imx50-pingrp.h                   |  146 ++++
 arch/arm/boot/dts/imx50.dtsi                       |  475 ++++++++++
 arch/arm/boot/dts/imx51-apf51.dts                  |   18 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |   50 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  100 ++-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   71 ++
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  153 ++++
 arch/arm/boot/dts/imx51-pingrp.h                   |  249 ++++++
 arch/arm/boot/dts/imx51.dtsi                       |  456 ++--------
 arch/arm/boot/dts/imx53-ard.dts                    |   19 +-
 arch/arm/boot/dts/imx53-evk.dts                    |   38 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |  133 ++-
 arch/arm/boot/dts/imx53-mba53.dts                  |   40 +-
 arch/arm/boot/dts/imx53-pingrp.h                   |  352 ++++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |   65 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   62 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |  112 ++-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |    5 +-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |  144 +++
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |  240 +++++
 arch/arm/boot/dts/imx53.dtsi                       |  649 ++------------
 arch/arm/boot/dts/imx6dl-gw51xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-gw52xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-gw53xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-gw54xx.dts                |   19 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |   94 ++
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |   21 +
 arch/arm/boot/dts/imx6dl-pinfunc.h                 |    2 +
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |   20 +
 arch/arm/boot/dts/imx6dl.dtsi                      |   30 +-
 arch/arm/boot/dts/imx6q-arm2.dts                   |   73 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |   69 ++
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |  178 ++++
 arch/arm/boot/dts/imx6q-gw51xx.dts                 |   19 +
 arch/arm/boot/dts/imx6q-gw52xx.dts                 |   23 +
 arch/arm/boot/dts/imx6q-gw53xx.dts                 |   23 +
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  493 +++++++++++
 arch/arm/boot/dts/imx6q-gw54xx.dts                 |   23 +
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |   25 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   44 +-
 arch/arm/boot/dts/imx6q-pinfunc.h                  |    2 +
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  178 +---
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |   29 +-
 arch/arm/boot/dts/imx6q-udoo.dts                   |   27 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   18 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  317 +++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  424 +++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  484 ++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  511 +++++++++++
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |   58 ++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |   89 ++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  382 ++++++++
 arch/arm/boot/dts/imx6qdl-pingrp.h                 |  532 +++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   80 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  383 ++++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  208 ++++-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   70 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  914 +++----------------
 arch/arm/boot/dts/imx6sl-evk.dts                   |   88 +-
 arch/arm/boot/dts/imx6sl-pingrp.h                  |  148 ++++
 arch/arm/boot/dts/imx6sl.dtsi                      |  366 ++------
 arch/arm/boot/dts/vf610-cosmic.dts                 |   16 +-
 arch/arm/boot/dts/vf610-pingrp.h                   |  127 +++
 arch/arm/boot/dts/vf610-twr.dts                    |   34 +-
 arch/arm/boot/dts/vf610.dtsi                       |  172 +---
 arch/arm/mach-imx/mach-imx6q.c                     |   35 +
 arch/arm/mach-mxs/mach-mxs.c                       |   33 +
 108 files changed, 12039 insertions(+), 2730 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts
 create mode 100644 arch/arm/boot/dts/imx25-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx25-pingrp.h
 rename arch/arm/boot/dts/{imx27-phytec-phycore-som.dts => imx27-phytec-phycore-som.dtsi} (74%)
 create mode 100644 arch/arm/boot/dts/imx27-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx27-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx28-duckbill.dts
 create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts
 create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts
 create mode 100644 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi
 create mode 100644 arch/arm/boot/dts/imx35-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx35.dtsi
 create mode 100644 arch/arm/boot/dts/imx50-evk.dts
 create mode 100644 arch/arm/boot/dts/imx50-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx50-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx50.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
 create mode 100644 arch/arm/boot/dts/imx51-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx53-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx53-voipac-bsb.dts
 create mode 100644 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-gw51xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw52xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw53xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw54xx.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-hummingboard.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-sabrelite.dts
 create mode 100644 arch/arm/boot/dts/imx6q-cm-fx6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw51xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw52xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw53xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5400-a.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw54xx.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-microsom.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sl-pingrp.h
 create mode 100644 arch/arm/boot/dts/vf610-pingrp.h
