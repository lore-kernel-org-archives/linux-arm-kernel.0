From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 18 Jul 2014 17:27:14 +0800
Subject: [GIT PULL] ARM: imx: device tree updates for 3.17
Message-ID: <20140718092713.GC5485@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

For sake of dependency, this pull request is based on imx-soc-3.17
I just sent.  Please pull and take care of the dependency, thanks.

Shawn

The following changes since commit 4349c4298f676815bf7ad146cf37e76843054783:

  ARM: imx: clk-vf610: fix FlexCAN clock gating (2014-07-18 16:11:40 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.17

for you to fetch changes up to 69603fbbc4798e8d02cb822edf5dce3f8a625427:

  ARM: dts: vf610: add FlexCAN node (2014-07-18 16:49:47 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 3.17:
 - Add device tree sources and pin function header for i.MX6SX SoC
 - Initial imx6sx-sdb board support with FEC, MMC, USB, PMIC, Audio
   and GPIO key enabled
 - New board support: mbimxsd25 and mbimxsd27 from Eukrea, aristainetos
   imx6dl boards, Rex Pro and Basic, Ka-Ro TX6
 - Restructure imx6qdl-wandboard.dtsi for new rev C1 board
 - Split M28EVK and M53EVK into SoM and EVK parts
 - A few correction around SDMA, SSI and SATA device nodes
 - Add eSATA support for Cubox-i board
 - Updates on edmqmx6 to enable PCIe, I2C and CAN
 - Use DT macro for clock ID for imx27 and imx6qdl
 - Add FlexCAN support for VF610 SoC

----------------------------------------------------------------
Alexander Shiyan (3):
      ARM: dts: Add support for the cpuimx27 board from Eukrea and its baseboard
      ARM: dts: i.MX35: Add GPT node
      ARM: i.MX27 clk: dts: Use clock defines in DTS files

Alexandre Belloni (1):
      ARM: dt: imx28-cfa10036: introduce a regulator for mmc0

Anson Huang (2):
      ARM: dts: imx6sx-sdb: add gpio key support
      ARM: dts: imx6sx: iomux-gpr syscon is compatible to imx6q

Anssi Hannula (2):
      ARM: dts: imx6: remove wrong spdif rxtx2 clock
      ARM: dts: imx6: remove non-working spdif rxtx4 and rxtx6 clocks

Denis Carikli (3):
      ARM: dts: imx25: mbimxsd25: Add displays support.
      ARM: dts: mbimxsd25: cmo-qvga: Fix lcd regulator
      ARM: dts: i.MX25: Fix gpt timers clocks.

Fabio Estevam (13):
      ARM: dts: imx6qdl-sabresd: Configure the ECSPI1 chip select pin
      ARM: dts: imx51-babbage: Add PMIC RTC support
      ARM: dts: imx6q-udoo: Add USB Host support
      ARM: dts: imx6sx: Use "vddarm" as the regulator name
      ARM: dts: imx6sx: Fix usbmisc compatible string
      ARM: dts: imx6sx-sdb: Add USB support
      ARM: dts: imx6sx-sdb: Add PMIC support
      ARM: dts: mx6: Disable the keypad in the dtsi files
      ARM: dts: imx25-pdk: Add USB OTG support
      ARM: dts: imx6sx: Fix sdma node
      ARM: dts: imx6sx: Pass the fsl,fifo-depth property
      ARM: dts: imx6sx-sdb: Add audio support
      ARM: imx6: Align ssi nodes between mx6 variants

Fugang Duan (1):
      ARM: dts: imx6sl: add fec sleep pinctrl for pin PM state

George Joseph (1):
      ARM: dts: Restructure imx6qdl-wandboard.dtsi for new rev C1 board.

Heiko Schocher (1):
      ARM: dts: imx6: add aristainetos board support

Iain Paton (1):
      ARM: dts: imx6: RIoTboard explicitly define pad settings

Lothar Wa?mann (2):
      ARM: dts: imx6: add missing compatible and clock properties for kpp
      ARM: dts: imx6: add support for Ka-Ro TX6 modules

Marek Vasut (2):
      ARM: dts: mxs: Split M28EVK into SoM and EVK parts
      ARM: dts: mx5: Split M53EVK into SoM and EVK parts

Markus Pargmann (4):
      ARM: dts: imx50: add ssi dma properties
      ARM: dts: imx5: remove fsl,ssi-dma-events
      ARM: dts: imx6qdl: remove fsl,ssi-dma-events
      ARM: dts: imx: remove ssi fsl,mode for audio cards

Philipp Zabel (2):
      ARM: dts: pfla02: Add ethernet phy supply regulator
      ARM: dts: imx6qdl: Add CSI device tree port nodes for IPU1 and IPU2

Robert Nelson (2):
      ARM: dts: add initial Rex Pro board support
      ARM: dts: add initial Rex Basic board support

Russell King (2):
      ARM: dts: cubox-i: add eSATA DT configuration
      ARM: dts: cubox-i: disable spread-spectrum for Cubox-i eSATA

Shawn Guo (7):
      Merge tag 'imx-soc-3.17' into imx/dt
      ARM: dts: imx: add pin function header for imx6sx
      ARM: dts: imx: add initial imx6sx device tree source
      ARM: dts: imx: add initial imx6sx-sdb board support
      ARM: dts: imx6qdl: use DT macro for clock ID
      ARM: dts: imx: correct sdma compatbile for imx6sl and imx6sx
      ARM: dts: imx53: correct clock-names of SATA node

Silvio Fricke (3):
      ARM: dts: imx6: edmqmx6: Add PCIe support
      ARM: dts: imx6: edmqmx6: Add two other i2c buses
      ARM: dts: imx6: edmqmx6: Add can bus

Stefan Agner (2):
      ARM: dts: vf610: fix length of eshdc1 register property
      ARM: dts: vf610: add FlexCAN node

Steffen Trumtrar (1):
      ARM: dts: i.MX53: add aipstz nodes

Tim Harvey (2):
      ARM: dts: imx6: ventana: change sound device name
      ARM: dts: imx6: ventana: update model to reflect Dual/Solo CPU types

 arch/arm/boot/dts/Makefile                         |   19 +
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   73 +
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   45 +
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   45 +
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |    1 -
 arch/arm/boot/dts/imx25-pdk.dts                    |    8 +-
 arch/arm/boot/dts/imx25.dtsi                       |    8 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |  296 ++++
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |  273 ++++
 arch/arm/boot/dts/imx27-pdk.dts                    |    2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |    2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |    3 +-
 arch/arm/boot/dts/imx27.dtsi                       |  115 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |   22 +
 arch/arm/boot/dts/imx28-m28.dtsi                   |   87 ++
 arch/arm/boot/dts/imx28-m28evk.dts                 |   62 +-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |    1 -
 arch/arm/boot/dts/imx35.dtsi                       |    8 +
 arch/arm/boot/dts/imx50.dtsi                       |    8 +-
 arch/arm/boot/dts/imx51-babbage.dts                |    2 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |    1 -
 arch/arm/boot/dts/imx51.dtsi                       |    3 -
 arch/arm/boot/dts/imx53-m53.dtsi                   |  140 ++
 arch/arm/boot/dts/imx53-m53evk.dts                 |  113 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |    1 -
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |    1 -
 arch/arm/boot/dts/imx53-tx53.dtsi                  |    1 -
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |    1 -
 arch/arm/boot/dts/imx53.dtsi                       |   15 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |   85 ++
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts        |   74 +
 arch/arm/boot/dts/imx6dl-gw51xx.dts                |    2 +-
 arch/arm/boot/dts/imx6dl-gw52xx.dts                |    2 +-
 arch/arm/boot/dts/imx6dl-gw53xx.dts                |    2 +-
 arch/arm/boot/dts/imx6dl-gw54xx.dts                |    2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts             |   30 +
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   33 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts          |  103 ++
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts             |  177 +++
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |  150 ++
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts       |   22 +
 arch/arm/boot/dts/imx6dl-wandboard.dts             |    2 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |   17 +-
 arch/arm/boot/dts/imx6q-cubox-i.dts                |    4 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   54 +
 arch/arm/boot/dts/imx6q-gw51xx.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-gw52xx.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-gw53xx.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |    5 +-
 arch/arm/boot/dts/imx6q-gw54xx.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts                |   34 +
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts       |  103 ++
 arch/arm/boot/dts/imx6q-tx6q-1010.dts              |  177 +++
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts       |  136 ++
 arch/arm/boot/dts/imx6q-tx6q-1020.dts              |  210 +++
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |  154 ++
 arch/arm/boot/dts/imx6q-udoo.dts                   |   32 +
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts        |   26 +
 arch/arm/boot/dts/imx6q-wandboard.dts              |    2 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   35 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |  418 ++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |    5 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |    5 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |    6 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |    1 -
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |    1 +
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |  357 +++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |    1 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |    2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |  696 +++++++++
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |   42 +
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi     |   41 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   22 -
 arch/arm/boot/dts/imx6qdl.dtsi                     |  161 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |   17 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   12 +-
 arch/arm/boot/dts/imx6sx-pinfunc.h                 | 1544 ++++++++++++++++++++
 arch/arm/boot/dts/imx6sx-sdb.dts                   |  479 ++++++
 arch/arm/boot/dts/imx6sx.dtsi                      | 1208 +++++++++++++++
 arch/arm/boot/dts/vf610.dtsi                       |   25 +-
 80 files changed, 7692 insertions(+), 388 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts
 create mode 100644 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts
 create mode 100644 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi
 create mode 100644 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts
 create mode 100644 arch/arm/boot/dts/imx28-m28.dtsi
 create mode 100644 arch/arm/boot/dts/imx53-m53.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos_4.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-aristainetos_7.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-rex-basic.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-801x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-tx6u-811x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts
 create mode 100644 arch/arm/boot/dts/imx6q-rex-pro.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1010.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1020.dts
 create mode 100644 arch/arm/boot/dts/imx6q-tx6q-1110.dts
 create mode 100644 arch/arm/boot/dts/imx6q-wandboard-revb1.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-rex.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-tx6.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sx-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6sx-sdb.dts
 create mode 100644 arch/arm/boot/dts/imx6sx.dtsi
