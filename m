From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 18 Apr 2016 13:59:43 +0800
Subject: [GIT PULL] ARM: imx: device tree updates for 4.7, take 1
Message-ID: <20160418055943.GY28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

My device tree branch contains the majority of the patches I send you
for each merge window.  Per request from Arnd, I'm sending the branch in
two rounds.  This is the first take.  The second one will come to you
around -rc6 time, and it should have less patches than the first one.

Please pull, thanks.

Shawn


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.7

for you to fetch changes up to 880e1509db9732d5696d2a092e9bd61d80ad00be:

  ARM: dts: imx6qdl-udoo: add 7 inch LCD touchscreen panel support (2016-04-18 12:54:21 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.7:
 - More i.MX6 System-on-Module board support from Ka-Ro electronics:
   tx6s-8xxx, tx6u-8xxx, tx6q-1xxx, tx6ul-00xx.
 - Nitrogen6_MAX QP and Nitrogen6_SoloX board support from Boundary
   Devices.
 - VF610 based ZII development board support.
 - Add SAI interface audio support for i.MX6SX SDB board.
 - A number of random updates on LS1021A and VF610 dts files.
 - A couple of pinumx updates on i.MX25 and i.MX28.

----------------------------------------------------------------
Akshay Bhat (1):
      ARM: dts: imx6q-ba16: Remove unused vqmmc-supply

Alexander Kurz (1):
      ARM: dts: i.MX3x: add keypad port devicetree nodes

Alexander Stein (1):
      ARM: dts: ls1021a: DSPI has 6 chip-selects

Cory Tusar (1):
      ARM: dts: vf610-zii-dev: Add ZII development board.

Fabio Estevam (5):
      ARM: dts: imx6qdl-sabresd: Pass the hannstar panel compatible string
      ARM: dts: imx6sx: Fix SAI DMA index
      ARM: dts: imx6sx: Remove unused property
      bindings: fsl-imx-sdma: Document 'fsl,sdma-event-remap' property
      ARM: dts: imx6sx-sdb: Add SAI support

Gary Bisson (2):
      ARM: dts: imx: add Boundary Devices Nitrogen6_MAX QP board
      ARM: dts: imx: add Boundary Devices Nitrogen6_SoloX board

Justin Waters (2):
      ARM: dts: imx: ba16: Add correct PCIe Tx Values
      ARM: dts: imx6q-ba16: Disable pwm2 by default

Liu Gang (1):
      ARM: dts: ls1021a: Add gpio support for ls1021a platform

Lothar Wa?mann (12):
      ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL modules
      ARM: dts: imx6ul: add support for Ka-Ro electronics TXUL mainboard
      ARM: dts: imx6-tx6: Relicense the Ka-Ro DT files under GPLv2/X11
      ARM: dts: imx6-tx6: cleanup; no functional change
      ARM: dts: imx6-tx6: disable the spi node by default
      ARM: dts: imx6-tx6: remove container node around pinctrl nodes
      ARM: dts: imx6qdl-tx6: add mdio node for ethernet phy
      ARM: dts: imx6-tx6: remove regulator bus
      ARM: dts: imx6-tx6: remove LED pinctrl setting from hoggrp
      ARM: dts: imx6-tx6: enable support for rtscts on UARTs
      ARM: dts: imx6: add support for more Ka-Ro electronics modules
      ARM: dts: imx6: add support for the Ka-Ro electronics 'MB7' baseboard

Maciej S. Szmigiero (1):
      ARM: dts: imx6qdl-udoo: add 7 inch LCD touchscreen panel support

Minghuan Lian (1):
      ARM: dts: ls1021a: add SCFG MSI dts node

Soeren Moch (1):
      ARM: dts: imx6q-tbs2910: fix fec reset polarity

Stefan Agner (4):
      ARM: dts: vf-colibri: alias the primary FEC as ethernet0
      ARM: dts: vf-colibri: increase NAND clock speed
      ARM: dts: vfxxx: add missing reg properties
      ARM: dts: ls1021a: add pix clock to DCU dts node

Uwe Kleine-K?nig (3):
      ARM: dts: imx25-pinfunc: add all UART mux modes
      ARM: dts: imx25-pinfunc: remove SION for pins with an UART handshaking input mode
      ARM: dts: imx28: add alternative pinmuxing for mac0

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  27 +
 arch/arm/boot/dts/Makefile                         |  17 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  | 124 +--
 arch/arm/boot/dts/imx28.dtsi                       |  26 +
 arch/arm/boot/dts/imx31.dtsi                       |   8 +
 arch/arm/boot/dts/imx35.dtsi                       |   8 +
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          |  42 +-
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts             | 237 +++++
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts             | 253 ++++++
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts             |  42 +-
 arch/arm/boot/dts/imx6dl-tx6u-8033.dts             | 248 ++++++
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |  60 +-
 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts         | 255 ++++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   5 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       |  42 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts              |  42 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       |  72 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts              |  72 +-
 arch/arm/boot/dts/imx6q-tx6q-1036.dts              | 252 ++++++
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |  60 +-
 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts          | 264 ++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  30 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 | 788 +++++++++--------
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  96 ++
 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts         |  59 ++
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           | 709 +++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb-sai.dts               |  67 ++
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  16 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   6 +-
 arch/arm/boot/dts/imx6ul-tx6ul-0010.dts            |  53 ++
 arch/arm/boot/dts/imx6ul-tx6ul-0011.dts            |  68 ++
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       | 271 ++++++
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                | 973 +++++++++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi                     |  65 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  |   7 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |   5 +
 arch/arm/boot/dts/vf500.dtsi                       |   1 +
 arch/arm/boot/dts/vf610-colibri.dtsi               |   5 +
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          | 734 ++++++++++++++++
 arch/arm/boot/dts/vfxxx.dtsi                       |   2 +
 41 files changed, 5558 insertions(+), 555 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8034.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6s-8035.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-8033.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1036.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-nitrogen6_max.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb-sai.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-0010.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-0011.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-tx6ul.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
