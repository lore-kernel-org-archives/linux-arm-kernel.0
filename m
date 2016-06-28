From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 20:46:18 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.8
In-Reply-To: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
References: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1467117980-20063-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.8

for you to fetch changes up to b326629f25b7c1a6d1c63a8c5483c8db11689d9c:

  ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support (2016-06-28 10:45:37 +0800)

----------------------------------------------------------------
The i.MX device tree update for 4.8:
 - Add two i.MX23/STMP3780 based MP3 player device support, Creative
   X-Fi3 and SanDisk Sansa Fuze+
 - Add the support of Auvidea H100 device which is a SolidRun MicroSOM
   baseboard
 - Restructure i.MX7Dual DTS files to support i.MX7Solo and add Toradex
   Colibri iMX7S/iMX7D boards
 - Device additions and enabling for various boards: mmc device for
   utilite-pro, IRQ controller and CAN support for TS-4800, display and
   touchscreen support for imx7d-sdb, SAI audio and LCD support for
   imx6ul-14x14-evk, gpio power off support for imx6q-bx50v3, etc.
 - Update the boards from Freescale/NXP to use WDOG_B pin for reset
 - PCI reset polarity correction for imx6qdl-sabresd and imx6q-tbs2910
 - Update i.MX board dts files to use generic uart-has-rtscts DT
   property instead of vendor specific one
 - DTC warning fixing for a few boards which are mostly mismatch between
   unit-address and reg property
 - Remove SION setting from all mux modes on i.MX25

----------------------------------------------------------------
Christopher Spinrath (5):
      ARM: dts: imx6q-cm-fx6: remove iomuxc container node
      ARM: dts: imx6q: extend support for the cm-fx6
      ARM: dts: imx6q: add support for the Utilite Pro
      ARM: dts: imx6q-cm-fx6: Relicense under GPLv2/X11
      ARM: dts: utilite-pro: add mmc card slot support

Damien Riegel (2):
      ARM: dts: TS-4800: add FPGA's IRQ controller support
      ARM: dts: TS-4800: add CAN support

Diego Dorta (4):
      ARM: dts: imx6ul-pico-hobbit: Fix Ethernet PHY reset GPIO
      ARM: dts: imx7d: Add SPI support
      ARM: dts: imx7d-sdb: Add display support
      ARM: dts: imx7d-sdb: Add support for touchscreen

Fabio Estevam (9):
      ARM: dts: imx: Remove unneeded unit-addresses
      ARM: dts: imx6ul: Add SAI alias
      ARM: dts: imx6ul-14x14-evk: Pass "fsl, sai-mclk-direction-output"
      ARM: dts: imx6ul-14x14-evk: Add LCD and backlight support
      ARM: dts: imx6qdl-sabresd: Pass the correct PCI reset polarity
      ARM: dts: imx6qdl-sabresd: Use WDOG_B pin reset
      ARM: dts: imx7d-sdb: Use WDOG_B pin reset
      ARM: dts: imx6ul-evk: Use WDOG_B pin reset
      ARM: dts: imx6sx-sdb: Use WDOG_B pin reset

Geert Uytterhoeven (2):
      ARM: dts: imx28: Use generic uart-has-rtscts DT property
      ARM: dts: imx: Use generic uart-has-rtscts DT property

Juergen Borleis (1):
      ARM: dts: imx6: fix IPU1 DI1 node name

Ken Lin (1):
      ARM: dts: imx6q-bx50v3: Add gpio power off support

Lucas Stach (2):
      ARM: dts: imx6: tag boards that have the HW workaround for ERR006687
      ARM: dts: imx6: add support for Auvidea H100 board

Marek Vasut (4):
      ARM: dts: mxs: Add SSP2 SD mux
      ARM: dts: mxs: Add AUART2 pinmux
      ARM: dts: mxs: Add Creative X-Fi3 support
      ARM: dts: mxs: Add SanDisk Sansa Fuze+ support

Peng Fan (2):
      ARM: dts: imx6qdl: add clocks property for ocotp node
      ARM: dts: imx6sl: add clocks property for ocotp node

Peter Chen (1):
      ARM: dts: imx6qdl.dtsi: add "arm,shared-override" for pl310

Rajesh Bhagat (1):
      ARM: dts: ls1021a: Add dis_rxdet_inp3_quirk property to USB3 node

Soeren Moch (1):
      ARM: dts: imx6q-tbs2910: fix pcie reset polarity

Stefan Agner (5):
      ARM: dts: imx7d-pinfunc: add input mux for UART2 RX DTE mode
      ARM: dts: imx7d: use imx7s.dtsi as base device tree
      ARM: dts: imx7d: recreate imx7d.dtsi with i.MX 7Dual specifics
      ARM: dts: imx7d: move input header into base device tree
      ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support

Stefan Wahren (4):
      ARM: dts: mxs: add missing reg properties for GPIO banks
      ARM: dts: imx28-eukrea-mbmx28lc: add missing reg properties
      ARM: dts: imx28-cfa10049: fix dtc warning
      ARM: dts: imx28-tx28: fix dtc warning

Uwe Kleine-K?nig (2):
      ARM: imx25-pinfunc: document SION being important for MX25_PAD_SD1_CMD__SD1_CMD
      ARM: imx25-pinfunc: remove SION from all modes

Valentin Raevsky (1):
      ARM: dts: imx6q-cm-fx6: fix the operation points

 arch/arm/boot/dts/Makefile                         |   8 +-
 arch/arm/boot/dts/imx1-ads.dts                     |   4 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |   4 +-
 arch/arm/boot/dts/imx23-sansa.dts                  | 207 +++++
 arch/arm/boot/dts/imx23-xfi3.dts                   | 179 ++++
 arch/arm/boot/dts/imx23.dtsi                       |  48 ++
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |   4 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  | 627 +++++++-------
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   2 +-
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   6 +-
 arch/arm/boot/dts/imx27-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   6 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   4 +-
 arch/arm/boot/dts/imx28-apf28dev.dts               |   2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |   2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |   4 +
 arch/arm/boot/dts/imx28-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   5 +
 arch/arm/boot/dts/imx31-bug.dts                    |   2 +-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |   4 +-
 arch/arm/boot/dts/imx35-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   4 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   4 +-
 arch/arm/boot/dts/imx51-ts4800.dts                 |  27 +
 arch/arm/boot/dts/imx53-smd.dts                    |   2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   6 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   1 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |   4 +-
 arch/arm/boot/dts/imx6q-arm2.dts                   |   3 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |   6 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 | 281 +++++--
 arch/arm/boot/dts/imx6q-h100.dts                   | 395 +++++++++
 arch/arm/boot/dts/imx6q-tbs2910.dts                |   2 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts            | 197 +++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   4 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   4 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   4 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |   2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |   3 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   1 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   1 +
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  19 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   6 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   3 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   4 +-
 arch/arm/boot/dts/imx6sl-warp.dts                  |   2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  13 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |   2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  14 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  12 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  63 +-
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |   6 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       |   4 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   6 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   9 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        | 148 ++++
 arch/arm/boot/dts/imx7-colibri.dtsi                | 571 +++++++++++++
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |   1 -
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts        |  66 ++
 arch/arm/boot/dts/imx7d-colibri.dtsi               |  54 ++
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   3 +-
 arch/arm/boot/dts/imx7d-pinfunc.h                  |   2 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    | 131 ++-
 arch/arm/boot/dts/imx7d.dtsi                       | 923 ++------------------
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts        |  51 ++
 arch/arm/boot/dts/imx7s-colibri.dtsi               |  50 ++
 arch/arm/boot/dts/imx7s.dtsi                       | 933 +++++++++++++++++++++
 arch/arm/boot/dts/ls1021a.dtsi                     |   1 +
 75 files changed, 3860 insertions(+), 1324 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx23-sansa.dts
 create mode 100644 arch/arm/boot/dts/imx23-xfi3.dts
 create mode 100644 arch/arm/boot/dts/imx6q-h100.dts
 create mode 100644 arch/arm/boot/dts/imx6q-utilite-pro.dts
 create mode 100644 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
 create mode 100644 arch/arm/boot/dts/imx7-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s.dtsi
