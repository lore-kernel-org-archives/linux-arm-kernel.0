From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 22:37:54 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.12
In-Reply-To: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1491835076-1995-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.12

for you to fetch changes up to e48d9e715411a70b6d7c589eb3284830f22f5bf7:

  ARM: dts: imx6q-utilite-pro: add hpd gpio (2017-04-10 16:16:24 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.12:
 - New board support: I2SE's i.MX28 Duckbill-2 boards, Gateworks Ventana
   i.MX6 GW5903/GW5904, Zodiac Inflight Innovations RDU2 board, Engicam
   i.CoreM6 Quad/Dual OpenFrame modules, Boundary Device i.MX6 Quad Plus
   SOM.
 - Improve compatible string for i.MX50 eSDHC, i.MX7S SRC devices and
   i.MX6SX UART device.
 - Add interrupts for switch and PHY devices on VF610 ZII Devel C board.
 - Add LVDS, LCD backlight, touchscreen and SAI2 support for i.MX6
   icore, geam, and isiot boards.
 - A series from Lucas Stach to improve i.MX6Q Plus device tree and add
   PRE/PRG devices.
 - A series from Stefan Agner to update imx7-colibri device tree
   regarding to display, PMIC/regulator support.
 - Fix PCI bus DTC warnings seen with the latest compiler.
 - Set default phy_type and dr_mode for i.MX25 USBOTG port.
 - A couple of small improvements on i.MX25 pin function DT header.
 - Add audio support for imx6q-cm-fx6 board using Wolfson wm8731 codec
   which is muxed to SSI2 device.
 - Other random updates, small fixes and trivial cleanups.

----------------------------------------------------------------
Alexander Kurz (1):
      ARM: dts: imx50: imx50-esdhc use imx53-esdhc

Andrew Lunn (2):
      ARM: dts: vf610-zii-dev: Wire up devel C switch interrupts
      ARM: dts: vf610-zii-dev-c: Wire up PHY interrupts

Andrey Smirnov (1):
      ARM: dts: imx7s: Do not claim i.MX51 compatibility for SRC

Christopher Spinrath (1):
      ARM: dts: imx6q-utilite-pro: add hpd gpio

Fabio Estevam (3):
      ARM: dts: imx6ul-14x14-evk: Remove unnecessary node
      ARM: dts: imx53-qsb: Constrain the TVE DAC voltage
      ARM: dts: imx6sx: Make UART compatible to 'imx6q-uart'

Gary Bisson (1):
      ARM: dts: imx6qp-nitrogen6_som2: add Quad Plus variant of the SOM

Jagan Teki (11):
      ARM: dts: imx6qdl-icore: Add backlight support for lvds
      ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 10.1 initial support
      ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 12.3 initial support
      ARM: dts: imx6q-icore: Add LVDS support
      ARM: dts: imx6ul-geam: Add backlight support for lcdif
      ARM: dts: imx6ul-isiot: Add backlight support for lcdif
      ARM: dts: imx6ul-isiot: Add imx6ul-isiot-common.dtsi
      ARM: dts: imx6ul-isiot: Add i2c nodes
      ARM: dts: imx6ul-isiot-common: Add touchscreen node
      ARM: dts: imx6ul-[geam|isiot]: Add sai2 node
      ARM: dts: imx6q-icore: Add touchscreen node

Ken Lin (2):
      ARM: dts: imx6q-bx50v3: change pca953x GPIO default settings
      ARM: dts: imx6q-bx50v3: fix at25 spi-clk frequency issue

Leonard Crestez (2):
      ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
      ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply

Lucas Stach (6):
      ARM: dts: imx6qp: reference PCIe node by handle
      ARM: dts: imx6qp: reference MMDC node by handle and remove duplication
      ARM: dts: imx6qp: correct IPU nodes
      ARM: dts: imx6qp: add PRE nodes
      ARM: dts: imx6qp: add PRG nodes and hook up to IPUs
      ARM: dts: imx6: add ZII RDU2 boards

Marco Franchi (1):
      ARM: dts: imx7d-sdb: Add sht11 Click Board support

Martin Kaiser (1):
      ARM: dts: i.MX25: add AIPS control registers

Michael Heimpold (9):
      ARM: dts: imx28: add alternative pinmuxing for mmc2
      ARM: dts: imx28: rename mmc2_sck_cfg
      ARM: dts: imx28: add alternative muxing for mmc2_sck_cfg
      ARM: dts: imx28-duckbill: update to match vendor distributed DT
      dt-bindings: arm: add entries for I2SE boards
      ARM: dts: add support for I2SE Duckbill 2 boards
      ARM: dts: add support for I2SE Duckbill 2 485
      ARM: dts: add support for I2SE Duckbill 2 EnOcean
      ARM: dts: add support for I2SE Duckbill 2 SPI

Peng Fan (1):
      ARM: dts: imx7s: enable ocotp

Peter Senna Tschudin (1):
      ARM: dts: imx6q-b850v3: Use megachips-stdpxxxx-ge-b850v3-fw bridges (LVDS-DP++)

Rob Herring (1):
      ARM: dts: imx: fix PCI bus dtc warnings

Stefan Agner (5):
      ARM: dts: imx7-colibri: use OF graph to describe the display
      ARM: dts: imx7-colibri: fix PMIC voltages
      ARM: dts: imx7-colibri: allow to disable Ethernet rail
      ARM: dts: imx7-colibri: remove 1.8V fixed regulator
      ARM: dts: imx7-colibri: add Carrier Board 3.3V/5V regulators

Tim Harvey (2):
      ARM: dts: imx: add Gateworks Ventana GW5904 support
      ARM: dts: imx: add Gateworks Ventana GW5903 support

Uwe Kleine-K?nig (3):
      ARM: imx25: set default phy_type and dr_mode for usbotg port
      ARM: dts: imx25-pinfunc: remove duplicate definition
      ARM: dts: imx25-pinfunc: Move MX25_PAD_TDO__TDO to a more sensible place

Valentin Raevsky (1):
      ARM: dts: imx6q-cm-fx6: add analog audio support

Vivien Didelot (1):
      ARM: dts: vf610-zii-dev-rev-b: change switch2 label

 Documentation/devicetree/bindings/arm/i2se.txt     |  22 +
 arch/arm/boot/dts/Makefile                         |  16 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |   2 -
 arch/arm/boot/dts/imx25-pdk.dts                    |   2 -
 arch/arm/boot/dts/imx25-pinfunc.h                  |   5 +-
 arch/arm/boot/dts/imx25.dtsi                       |  12 +
 arch/arm/boot/dts/imx28-duckbill-2-485.dts         | 189 +++++
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     | 220 +++++
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts         | 199 +++++
 arch/arm/boot/dts/imx28-duckbill-2.dts             | 183 ++++
 arch/arm/boot/dts/imx28-duckbill.dts               |  81 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |  28 +-
 arch/arm/boot/dts/imx50.dtsi                       |   8 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |   4 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |   4 +-
 arch/arm/boot/dts/imx6dl-gw5903.dts                |  55 ++
 arch/arm/boot/dts/imx6dl-gw5904.dts                |  55 ++
 arch/arm/boot/dts/imx6q-b450v3.dts                 |   7 +
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   7 +
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  70 ++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  16 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  83 ++
 arch/arm/boot/dts/imx6q-gw5903.dts                 |  55 ++
 arch/arm/boot/dts/imx6q-gw5904.dts                 |  59 ++
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts          |  76 ++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts          |  76 ++
 arch/arm/boot/dts/imx6q-icore.dts                  |  34 +
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |  10 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts               |  50 ++
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi              | 654 +++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              | 641 ++++++++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |  19 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  12 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            | 932 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   3 +-
 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts        |  55 ++
 arch/arm/boot/dts/imx6qp-sabresd.dts               |   4 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts              |  50 ++
 arch/arm/boot/dts/imx6qp.dtsi                      |  99 ++-
 arch/arm/boot/dts/imx6sx.dtsi                      |  21 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |   5 -
 arch/arm/boot/dts/imx6ul-geam.dtsi                 |  45 +
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi         | 141 ++++
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            |   1 +
 arch/arm/boot/dts/imx6ul-isiot-nand.dts            |   1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |  73 ++
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        |  55 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                |  45 +-
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts        |   1 +
 arch/arm/boot/dts/imx7d-sdb-sht11.dts              |  74 ++
 arch/arm/boot/dts/imx7s.dtsi                       |   7 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |  14 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |  77 ++
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |  12 +
 55 files changed, 4499 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-485.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-spi.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5903.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5904.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5903.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5904.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap10.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap12.dts
 create mode 100644 arch/arm/boot/dts/imx6q-zii-rdu2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5903.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5904.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-zii-rdu2.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-sdb-sht11.dts
