From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 11:09:52 +0800
Subject: [GIT PULL 2/2] ARM: imx: device tree changes for 3.13
In-Reply-To: <20131021023533.GE17165@S2101-09.ap.freescale.net>
Message-ID: <20131021030950.GG17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:

  Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.13

for you to fetch changes up to 5f7adc9762a33c4aa534f575532f55804ff50609:

  ARM: imx: imx6sl iomuxc syscon is compatible to imx6q (2013-10-18 23:27:37 +0800)

----------------------------------------------------------------
The imx/mxs device tree changes for 3.13:

* Use macros for mxs pinctrl settings
* New board support: VF610 Cosmic/Cosmic+, imx6q-udoo, MSR M28CU3
* Support DSPI device for vf610
* Add PCIe device for imx6qdl
* Add UHS pinctrl states for imx6sl and imx6qdl
* Display support for APF and imx51-babbage boards
* Enable SPI NOR and USB for imx6sl-evk board
* Enable LVDS for imx6q-sabrelite and SPDIF for imx6qdl-wandboard
* Misc updates on boards: TX28, imx6qdl-wandboard, imx53-qsb etc.
* Some random updates on imx51 device tree

----------------------------------------------------------------
Alexander Shiyan (3):
      ARM: dts: i.MX51: Separate TXD/RXD and RTS/CTS pinmux entries for UARTs
      ARM: dts: i.MX51: Add IRAM devicetree node
      ARM: dts: i.MX51: Add W1 devicetree node

Chao Fu (2):
      ARM: dts: vf610: Add DSPI nodes
      ARM: dts: vf610-twr: Enable DSPI0 devices and Flash at26df081a

Dong Aisheng (2):
      ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3
      ARM: dts: imx6sl: add pinctrl uhs states for usdhc

Fabio Estevam (17):
      ARM: dts: imx6qdl-wandboard: Add usbotg support
      ARM: dts: imx28-evk: Allow usb peripheral mode to work
      ARM: dts: imx53-qsb: Allow usb peripheral mode to work
      ARM: dts: imx6q-sabrelite: Put the nodes in alphabetical order
      ARM: dts: imx6q-sabrelite: Add LVDS support
      ARM: imx6qdl-wandboard: Add spdif support
      ARM: dts: imx6sl: Add spi aliases
      ARM: dts: imx6qdl-sabresd: SDHC ports are 8 bit-wide
      ARM: dts: imx28-evk: Enable touchscreen support
      ARM: dts: imx6q-udoo: Add initial board support
      ARM: dts: imx6q-sabrelite: Add ethernet phy reset pin into hog
      ARM: dts: imx6qdl-sabresd: Provide phy-reset-gpios
      ARM: dts: imx6qdl-wandboard: Provide phy-reset-gpios
      ARM: dts: imx53-qsb: SDHC3 is connected in 8-bit mode
      ARM: dts: imx53-qsb: SDHC1 does not have cd-gpios
      ARM: dts: imx53-qsb: Do not use GPIO1_8 as wakeup source
      ARM: dts: imx51-babbage: Make DVI and WVGA panel functional

Fugang Duan (1):
      ARM: dts: add iomuxc-gpr device node for imx6sl

Gwenhael Goavec-Merou (2):
      ARM: imx51-apf51dev: Add parallel display support
      ARM: imx27-apf27dev: Add framebuffer support

Huang Shijie (2):
      ARM: dts: imx6sl: add a pinctrl for ECSPI1
      ARM: dts: imx6sl-evk: enable the SPI NOR

Lothar Wa?mann (5):
      ARM: dts: mxs: add pinctrl header files
      ARM: dts: mxs: modify mx23/mx28 dts files to use pinctrl headers
      ARM: dts: mxs: modify mx23/mx28 dts files to use padconfig defines
      ARM: dts: tx28: restructure and update DTS file
      ARM: dts: mxs: convert usb0_id_pins_a to use symbolic pin defs

Marek Vasut (2):
      ARM: dts: mxs: Add muxing options for the SSP2 MMC
      ARM: dts: mxs: Add MSR M28CU3 board

Matt Porter (1):
      ARM: dts: add initial VF610 Cosmic/Cosmic+ board support

Peter Chen (1):
      ARM: imx: mx6sl-evk: Enable USB function

Rogerio Pimentel (1):
      ARM: dts: imx6qdl-sabresd: Add backlight support for lvds

Sean Cross (1):
      ARM: dts: imx6qdl: add pcie device node

Shawn Guo (3):
      ARM: dts: imx6sl reuses imx6q sdma firmware
      ARM: dts: imx6q: add quirky select input for USB_OTG_ID
      ARM: imx: imx6sl iomuxc syscon is compatible to imx6q

Steffen Trumtrar (1):
      ARM: imx27: add missing #pwm-cells property

 .../bindings/pinctrl/fsl,mxs-pinctrl.txt           |  859 +-------------------
 arch/arm/boot/dts/Makefile                         |    3 +
 arch/arm/boot/dts/imx23-evk.dts                    |   16 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |   18 +-
 arch/arm/boot/dts/imx23-pinfunc.h                  |  333 ++++++++
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |   12 +-
 arch/arm/boot/dts/imx23.dtsi                       |  221 ++---
 arch/arm/boot/dts/imx27-apf27dev.dts               |   26 +
 arch/arm/boot/dts/imx27.dtsi                       |    1 +
 arch/arm/boot/dts/imx28-apf28.dts                  |    2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts               |   36 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   60 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   26 +-
 arch/arm/boot/dts/imx28-cfa10037.dts               |   18 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |  156 ++--
 arch/arm/boot/dts/imx28-cfa10055.dts               |   80 +-
 arch/arm/boot/dts/imx28-cfa10056.dts               |   38 +-
 arch/arm/boot/dts/imx28-cfa10057.dts               |   66 +-
 arch/arm/boot/dts/imx28-cfa10058.dts               |   24 +-
 arch/arm/boot/dts/imx28-evk.dts                    |   59 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |  266 ++++++
 arch/arm/boot/dts/imx28-m28evk.dts                 |   28 +-
 arch/arm/boot/dts/imx28-pinfunc.h                  |  506 ++++++++++++
 arch/arm/boot/dts/imx28-sps1.dts                   |   14 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |  703 ++++++++++++++--
 arch/arm/boot/dts/imx28.dtsi                       |  620 +++++++-------
 arch/arm/boot/dts/imx51-apf51dev.dts               |   27 +
 arch/arm/boot/dts/imx51-babbage.dts                |   37 +-
 arch/arm/boot/dts/imx51.dtsi                       |   23 +
 arch/arm/boot/dts/imx53-qsb.dts                    |    9 +-
 arch/arm/boot/dts/imx6q-pinfunc.h                  |    4 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  104 ++-
 arch/arm/boot/dts/imx6q-udoo.dts                   |   39 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |    5 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   18 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   23 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   67 ++
 arch/arm/boot/dts/imx6sl-evk.dts                   |   67 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  172 +++-
 arch/arm/boot/dts/mxs-pinfunc.h                    |   31 +
 arch/arm/boot/dts/vf610-cosmic.dts                 |   47 ++
 arch/arm/boot/dts/vf610-twr.dts                    |   17 +
 arch/arm/boot/dts/vf610.dtsi                       |   12 +
 arch/arm/mach-mxs/mach-mxs.c                       |    7 +
 44 files changed, 3207 insertions(+), 1693 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx23-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx28-m28cu3.dts
 create mode 100644 arch/arm/boot/dts/imx28-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6q-udoo.dts
 create mode 100644 arch/arm/boot/dts/mxs-pinfunc.h
 create mode 100644 arch/arm/boot/dts/vf610-cosmic.dts
