From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 16 May 2014 23:12:59 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.16
Message-ID: <20140516151258.GD10685@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:

  Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.16

for you to fetch changes up to c6f0b878f9b56a755431c74e217830f6550f62b4:

  ARM: dts: imx35-pdk: Fix memory region description (2014-05-16 23:02:13 +0800)

----------------------------------------------------------------
i.MX device tree changes for 3.16:
 - New board support: imx35-pdk, imx51-digi-connectcore, imx6dl-phytec,
   imx6dl-riotboard, and vf610-colibri.
 - Improve device tree support for imx51-babbage and eukrea-cpuimx51 to
   get the same level support as board files, so that we can kill the
   board files.
 - Quite some updates on imx27-phytec-phycore board support from
   Alexander Shiyan
 - Enable USB, sound and touchscreen on the eukrea imx25/35/51 boards,
   from Denis Carikli
 - Quite a lot of patches from Fabio Estevam, updating Freescale
   imx25-pdk and imx27-pdk board support
 - Correct USB device configuration for imx25/35
 - Fixes i2c4 device node in imx6dl.dtsi regarding to compatible string
   and clock data
 - Enable HDMI, TVE, LVDS display support on a bunch of imx5/6 boards
 - Update PCIe to the new binding and enable PCIe support on
   imx6qdl-sabresd board
 - A couple of imx6q-dmo-edmqmx6 updates from Lucas Stach, adding pfuze
   irq gpio and SPI flash
 - Enable CODA7541 VPU for i.MX53
 - A series of updates on imx6qdl-phytec boards from Philipp Zabel
 - Small cleanups and fixes on board imx28-duckbill - Michael Heimpold
 - Add stdout-path property to i.MX boards
 - Karo TX25 board updates from Sascha Hauer
 - Enable pwm and sdhc devices for board vf610-twr

----------------------------------------------------------------
Alexander Shiyan (20):
      ARM: dts: imx27-phytec-phycore-rdk: Add missing pinctrl definition for SPI CS1
      ARM: dts: imx27-phytec-phycore-som: Enable SSI1
      ARM: dts: imx27-phytec-phycore-rdk: Add display support
      ARM: dts: imx27-phytec-phycore-rdk: Add display control signal definitions
      ARM: dts: i.MX: Use single naming style for i.MX WEIM device
      ARM i.MX51: Add Digi ConnectCore devicetree
      ARM: dts: i.MX51: Allow to define partitions onto NFC
      ARM: dts: imx51-babbage: Move "hog" pins into corresponded pin groups
      ARM: dts: imx51-babbage: Add missing pingroup for PMIC
      ARM: dts: imx51-babbage: Use predefined constants for keys definition
      ARM: dts: imx51-babbage: Add USB OTG regulator node
      ARM: dts: imx51-babbage: Sort nodes by name
      ARM: dts: imx51-babbage: Add devicetree node for I2C1
      ARM: dts: imx51-babbage: Use predefined constants for clock definition
      ARM: dts: imx27-phytec-phycore-rdk: Remove duplicate entries for USB PHY
      ARM: dts: imx27-phytec-phycore-som: Fix active level for FEC reset
      ARM: dts: imx27-phytec-phycore-som: Disable PM pins for USB OTG
      ARM: dts: imx: Remove excess entries for PMIC
      ARM: dts: imx27-phytec-phycore-rdk: Add CSI enable switch
      ARM: dts: imx27-phytec-phycore-rdk: Fix "reg" property for USBH2 PHY

Cosmin Stoica (1):
      ARM: dts: vf610-twr: Add support for sdhc1

Denis Carikli (7):
      ARM: dts: mbimxsd35: Add sound support.
      ARM: dts: mbimxsd25 baseboard: Add USB support
      ARM: dts: i.MX35: Add USB support.
      ARM: dts: mbimxsd35 baseboard: Add USB support.
      ARM: dts: mbimxsd51 baseboard: Add USB support.
      ARM: dts: cpuimx35 Add touchscreen support.
      ARM: dts: cpuimx51 Add touchscreen support.

Fabio Estevam (34):
      ARM: dts: imx25-pdk: Sort the dt nodes
      ARM: dts: imx25-pdk: Add UART1 pins
      ARM: dts: imx25-pdk: Add FEC pins
      ARM: dts: imx25-pdk: Provide a regulator for Ethernet PHY
      ARM: dts: imx25-pdk: Provide an Ethernet PHY reset
      ARM: dts: imx25-pdk: Add esdhc1 support
      ARM: dts: mx25: USB block requires only one clock
      ARM: dts: mx35: USB block requires only one clock
      ARM: dts: imx25.dtsi: Fix USB support.
      ARM: dts: imx25-pdk: Add audio support
      ARM: dts: imx25-pdk: Add keypad support
      ARM: dts: imx25-pdk: Add CAN support
      ARM: dts: imx25-pdk: Add USB Host1 support
      ARM: dts: imx35-pdk: Add initial device tree support
      ARM: dts: imx51-babbage: Add USB Host1 support
      ARM: dts: imx51-babbage: Add USB OTG support
      ARM: dts: imx27-pdk: Pass the memory range
      ARM: dts: imx27-pdk: Keep the dt nodes sorted
      ARM: dts: imx27-pdk: Pass the UART1 pin configuration
      ARM: dts: imx27-pdk: Pass the FEC pin configuration
      ARM: dts: imx27-pdk: Add PMIC support
      ARM: dts: imx27-phytec-phycore-som: Move PMIC IRQ GPIO into a separate pin group
      ARM: dts: imx27: Use the correct usb clock gate
      ARM: dts: imx27: Place the usb phy nodes in the board dts files
      ARM: dts: imx27-pdk: Add USB OTG support
      ARM: dts: imx27-pdk: Add NAND support
      ARM: dts: imx27-pdk: Add keypad support
      ARM: dts: imx6qdl-sabresd: Add HDMI support
      ARM: dts: imx6qdl-wandboard: Add HDMI support
      ARM: dts: imx53-qsb-common: Add TVE support
      ARM: dts: imx6q-udoo: Add HDMI support
      ARM: dts: imx6qdl-sabresd: Add USDHC4 support
      ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Add CAN support
      ARM: dts: imx35-pdk: Fix memory region description

Iain Paton (2):
      ARM: dts: imx6: i2c4 cleanup
      ARM: dts: imx6: add new board RIoTboard

Lucas Stach (4):
      ARM: dts: imx6: update pcie to bring in line with new binding
      ARM: dts: imx6qdl-sabresd: remove power-on gpio from pcie
      ARM: dts: imx6: edmqmx6: add pinctrl for pfuze irq gpio
      ARM: dts: imx6: edmqmx6: add SPI bus and flash

Marek Vasut (2):
      ARM: dts: imx: Add alias for ethernet controller
      ARM: dts: imx6qdl-sabresd: Add PCIe support

Michael Heimpold (4):
      ARM: dts: imx28-duckbill: fix mmc settings
      ARM: dts: imx28: include gpio.h to allow use of symbolic names
      ARM: dts: imx28-duckbill: fix phy reset gpio
      ARM: dts: imx28-duckbill: use symbolic names from gpio.h

Philipp Zabel (13):
      ARM: dts: i.MX53: Enable CODA7541 VPU
      ARM: dts: i.MX53: Add reset line to VPU device node
      ARM: dts: Add Phytec pfla02 with i.MX6 DualLite/Solo
      ARM: dts: Add Phytec pbab01 with i.MX6 DualLite/Solo
      ARM: dts: pfla02: Add GPIO LEDs
      ARM: dts: pfla02: PHY reset is active-low
      ARM: dts: pbab01: Set linux,stdout-path to UART4
      ARM: dts: pbab01: Add I2C2 and I2C3
      ARM: dts: pbab01: Add I2C devices
      ARM: dts: pfla02: Add UART1 (uart3)
      ARM: dts: pbab01: Enable UART1
      ARM: dts: pbab01: Enable DVI
      ARM: dts: imx6q-gk802: Enable HDMI

Russell King (1):
      ARM: imx: add HDMI support for SolidRun HummingBoard and Cubox-i

Sascha Hauer (7):
      ARM: dts: Add stdout-path property to i.MX boards
      ARM: dts: i.MX51 babbage: Fix FEC pad ctrl settings
      ARM: dts: i.MX25: Add mmc aliases
      ARM: dts: i.MX25: Add IRAM node
      ARM: dts: Karo TX25: Add pinctrl nodes
      ARM: dts: Karo TX25: Add phy reset gpio and supply for FEC
      ARM: dts: Karo TX25: use hardware ecc

Silvio Fricke (1):
      ARM: dts: imx6: edmqmx6: add vcc and vio power supplies to stmpe

Stefan Agner (2):
      of: add vendor prefix for Toradex AG
      ARM: dts: add initial Colibri VF61 board support

Tim Harvey (3):
      ARM: dts: ventana: Add HDMI support
      ARM: dts: imx: add LVDS backlight for Ventana
      ARM: dts: imx: Fix LVDS mapping for Ventana GW52xx

Vincent Stehl? (1):
      ARM: dts: imx6qdl-sabresd.dtsi: Add red led

Xiubo Li (3):
      ARM: dts: vf610: Add Freescale FTM PWM node.
      ARM: dts: vf610-twr: Add PWM0's pinctrl node
      ARM: dts: vf610-twr: Enables FTM PWM device.

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   5 +
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  13 +
 arch/arm/boot/dts/imx25-karo-tx25.dts              |  77 +++
 arch/arm/boot/dts/imx25-pdk.dts                    | 217 ++++++++-
 arch/arm/boot/dts/imx25.dtsi                       |  46 +-
 arch/arm/boot/dts/imx27-pdk.dts                    | 170 ++++++-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   4 +
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     | 116 ++++-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |  53 +-
 arch/arm/boot/dts/imx27.dtsi                       |  30 +-
 arch/arm/boot/dts/imx28-duckbill.dts               |  12 +-
 arch/arm/boot/dts/imx28.dtsi                       |   1 +
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi       |  15 +
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  22 +
 arch/arm/boot/dts/imx35-pdk.dts                    |  68 +++
 arch/arm/boot/dts/imx35.dtsi                       |  25 +-
 arch/arm/boot/dts/imx50.dtsi                       |   1 +
 arch/arm/boot/dts/imx51-babbage.dts                | 374 +++++++++-----
 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts   | 108 +++++
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  | 377 ++++++++++++++
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |  11 +
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 120 +++++
 arch/arm/boot/dts/imx51.dtsi                       |   3 +
 arch/arm/boot/dts/imx53-mba53.dts                  |   4 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  21 +
 arch/arm/boot/dts/imx53.dtsi                       |   3 +-
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |  31 ++
 arch/arm/boot/dts/imx6dl-phytec-pbab01.dts         |  19 +
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi        |  22 +
 arch/arm/boot/dts/imx6dl-riotboard.dts             | 539 +++++++++++++++++++++
 arch/arm/boot/dts/imx6dl.dtsi                      |   3 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |  40 +-
 arch/arm/boot/dts/imx6q-gk802.dts                  |   7 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   5 +
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts          |  33 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         | 307 +-----------
 arch/arm/boot/dts/imx6q-udoo.dts                   |  23 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  27 ++
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   5 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  45 ++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  24 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  24 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   4 +
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi       | 102 ++++
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       | 356 ++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   4 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  65 +++
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  19 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   1 +
 arch/arm/boot/dts/vf610-colibri.dts                | 123 +++++
 arch/arm/boot/dts/vf610-twr.dts                    |  36 ++
 arch/arm/boot/dts/vf610.dtsi                       |  24 +
 55 files changed, 3257 insertions(+), 538 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx35-pdk.dts
 create mode 100644 arch/arm/boot/dts/imx51-digi-connectcore-jsk.dts
 create mode 100644 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-phytec-pbab01.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-riotboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-colibri.dts
