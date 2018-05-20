From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 22:57:59 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.18
In-Reply-To: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
References: <1526828281-14664-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1526828281-14664-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.18

for you to fetch changes up to 204d9e32b7971ecd187068c3a40c48bac4656cb0:

  ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source (2018-05-20 21:04:59 +0800)

----------------------------------------------------------------
i.MX device tree update for 4.18:
 - New boards support: BTicino i.MX6DL Mamoj board, DHCOM iMX6 SoM and
   PDK2 board, Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit,
   Kieback & Peter GmbH iMX6Q TPC board.
 - A series from Anson Huang to add a bunch of devices for i.MX6SX
   SabreAuto board, PMIC, IO expanders, FEC, Watchdog, LED and Touch.
 - Update i.MX7D for cpufreq support, using operating-points-v2
   bindings, correcting cpu supply name for voltage scaling.
 - Clean up unneeded 'codec-handle' property from imx25-pdk and
   imx53-tx53 device tree.
 - Switch SoC dtsi and NXP board dts files to use SPDX identifier.
 - Remove unnecessary '#address-cells/#size-cells' to fix DTC warning
   avoid_unnecessary_addr_size seen with W=1 switch.
 - A series from Rob Herring to fix DTC warning graph_endpoint seen with
   IPU OF graph when W=1 switch is on.
 - Update a few boards to use symbol name instead of hard-coding the
   input codes.
 - Update a number of boards to use IRQ_TYPE specifier instead of the
   raw value.
 - A few updates for i.MX6 RDU2 board: bumping SoC/PU operating points,
   adding assigned clocks for GPU, and enabling eGalax touchscreen.
 - A couple of i.MX51 RDU1 updates: limiting usbh1 to full-speed, and
   cleaning up eMMC device node.
 - Convert Hummingboard audio bindings from imx-audio-sgtl5000 to
   simple-audio-card, so that auxiliary audio devices such as external
   amplifiers can be supported.
 - Replace underscore with hyphen in aliases name to fix DTC warning
   alias_paths with W=1 switch.
 - A couple of updates on i.MX7D SAI and i.MX6ULL UART5 pin defines.
 - Other random and small changes.

----------------------------------------------------------------
Anson Huang (13):
      ARM: dts: imx7d-sdb: add gpio key support
      ARM: dts: imx7s: add anatop vdd1p2 regulator
      ARM: dts: imx6sx-sabreauto: add external 24MHz clock source
      ARM: dts: imx6sx-sabreauto: add PMIC support
      ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
      ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
      ARM: dts: imx6sx-sabreauto: add fec support
      ARM: dts: imx6sx-sabreauto: add wdog external reset
      ARM: dts: imx6sx-sabreauto: add debug LED support
      ARM: dts: imx6sx-sabreauto: add egalax touch screen support
      ARM: dts: imx7d: correct cpu supply name for voltage scaling
      ARM: dts: imx7s-warp: remove unnecessary cpu regulator supply
      ARM: dts: imx7d: use operating-points-v2 for cpu

Daniel Mack (1):
      ARM: dts: imx28/imx53: enable edt-ft5x06 wakeup source

Fabio Estevam (26):
      ARM: dts: imx25-pdk: Remove unneeded 'codec-handle' property
      ARM: dts: imx53-tx53: Remove unneeded 'codec-handle' property
      ARM: dts: imx6qdl-wandboard: Let the codec control MCLK pinctrl
      ARM: dts: imx7: Move tempmon node out of bus
      ARM: dts: imx6qdl-tx6: Remove 'bus-format-override' property
      ARM: dts: imx6ul: Add CAAM support
      ARM: dts: imx6qdl: Remove #address/#size-cells from mipi_dsi
      ARM: dts: imx: Remove #address/#size-cells from switch nodes
      ARM: dts: imx: Remove #address/#size-cells from stmpe nodes
      ARM: dts: imx6qdl-sabre: Remove #address/#size-cells from camera port nodes
      ARM: dts: imx53-ppd: Remove unnecessary #address/#size-cells
      ARM: dts: imx6dl-aristainetos2_4: Remove #address/#size-cells from display0
      ARM: dts: imx6q-b850v3: Remove #address/#size-cells from stdp2690
      ARM: dts: imx6q-utilite-pro: Remove #address/#size-cells from encoder
      ARM: dts: imx6q-var-dt6customboard: Remove #address/#size-cells from gpio-keys
      ARM: dts: imx6q-pistachio: Use 'uart-has-rtscts' property
      ARM: dts: imx6qdl-wandboard: Switch to SPDX identifier
      ARM: dts: imx6qdl-udoo: Switch to SPDX identifier
      ARM: dts: imx28-cfa10049: Remove unnecessary #address/#size-cells
      ARM: dts: imx28-duckbill-2-enocean: Remove unnecessary #address/#size-cells
      ARM: dts: imx: Switch to SPDX identifier
      ARM: dts: imx53-ard: Do not hardcode input codes
      ARM: dts: imx53-smd: Do not hardcode input codes
      ARM: dts: imx6q-gk802: Do not hardcode input codes
      ARM: dts: imx: Switch NXP boards to SPDX identifier
      ARM: dts: imx6/7: Remove unit-address from anatop regulators

Greg Ungerer (1):
      ARM: dts: imx6ull: add UART5 input select register definitions

Hern?n Gonzalez (4):
      ARM: dts: vf-colibri-eval-v3: Use IRQ_TYPE specifier
      ARM: dts: imx53-qsb: Use IRQ_TYPE specifier
      ARM: dts: imx53-voipac-dmm-668: Use IRQ_TYPE specifier
      ARM: dts: imx6qdl-phytec-pfla02: Use IRQ_TYPE specifier

Jagan Teki (4):
      dt-bindings: Add vendor prefix for Bticino
      ARM: dts: i.MX6: Add BTicino i.MX6DL Mamoj initial support
      ARM: dts: imx6q-icore-ofcap12: Switch LVDS timings from panel-simple
      ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support

Ken Lin (1):
      ARM: dts: imx: ba16: add "mfg" Q7 SPI-NOR partition

Lucas Stach (3):
      ARM: dts: imx6: RDU2: bump SoC/PU operating points by 25mV
      ARM: dts: imx6: RDU2+: add assigned clocks for GPU 3D
      ARM: dts: imx6: RDU2: add eGalax touchscreen

Lukasz Majewski (1):
      ARM: dts: tpc: Device tree description of the iMX6Q TPC board

Marek Vasut (1):
      ARM: dts: imx6q: Add support for the DHCOM iMX6 SoM and PDK2

Matt Porter (1):
      ARM: dts: hummingboard: convert onboard audio to simple-audio-card

Nikita Yushchenko (3):
      ARM: dts: imx51-zii-rdu1: limit usbh1 to full-speed
      ARM: dts: vf610-zii-dev: enable vf610 builtin temp sensor
      ARM: dts: imx51-zii-rdu1: cleanup eMMC node

Rob Herring (3):
      ARM: dts: imx: fix IPU OF graph endpoint node names
      ARM: dts: imx53: Fix LDB OF graph warning
      ARM: dts: imx7: Fix error in coresight TPIU graph connection

Sebastian Reichel (1):
      ARM: dts: imx53-ppd: Use IRQ_TYPE_* constants

Shawn Guo (7):
      ARM: dts: imx6sx-sabreauto: drop 'regulators' container node
      ARM: dts: imx6sx-sabreauto: drop board specific pinctrl container node
      ARM: dts: imx: drop unnecessary #address-cells/#size-cells
      ARM: dts: imx1: move clk32 clock into soc dtsi
      ARM: dts: imx27: use label to override osc26m clock setting
      ARM: dts: imx: drop 'clocks' container for board level clocks
      ARM: dts: imx: replace underscore with hyphen in aliases name

Shengjiu Wang (1):
      ARM: dts: imx7d-pinfunc: update sai select input value

Stefan Wahren (1):
      ARM: dts: imx6ull: add UART5 RTS input select register

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/imx1-ads.dts                     |  11 -
 arch/arm/boot/dts/imx1.dtsi                        |  21 +-
 arch/arm/boot/dts/imx23-evk.dts                    |  13 +-
 arch/arm/boot/dts/imx23.dtsi                       |  13 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |  14 +-
 arch/arm/boot/dts/imx25.dtsi                       |  16 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |  13 +-
 arch/arm/boot/dts/imx27-pdk.dts                    |  13 +-
 arch/arm/boot/dts/imx27.dtsi                       |  18 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |   2 -
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     |   2 -
 arch/arm/boot/dts/imx28-evk.dts                    |  13 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |  14 +-
 arch/arm/boot/dts/imx28.dtsi                       |  13 +-
 arch/arm/boot/dts/imx31.dtsi                       |  13 +-
 arch/arm/boot/dts/imx35-pdk.dts                    |  15 +-
 arch/arm/boot/dts/imx35.dtsi                       |  14 +-
 arch/arm/boot/dts/imx50-evk.dts                    |  17 +-
 arch/arm/boot/dts/imx50.dtsi                       |   3 -
 arch/arm/boot/dts/imx51-babbage.dts                |  15 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |   6 +-
 arch/arm/boot/dts/imx51.dtsi                       |  18 +-
 arch/arm/boot/dts/imx53-ard.dts                    |  11 +-
 arch/arm/boot/dts/imx53-m53.dtsi                   |   2 -
 arch/arm/boot/dts/imx53-ppd.dts                    |  12 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  15 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |  17 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |  15 +-
 arch/arm/boot/dts/imx53-smd.dts                    |  20 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |   1 +
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  14 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   2 +-
 arch/arm/boot/dts/imx53.dtsi                       |  11 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |   2 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |  15 +-
 arch/arm/boot/dts/imx6dl-mamoj.dts                 | 224 ++++++++++
 arch/arm/boot/dts/imx6dl-sabreauto.dts             |  10 +-
 arch/arm/boot/dts/imx6dl-sabresd.dts               |  10 +-
 arch/arm/boot/dts/imx6dl-udoo.dts                  |   6 +-
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts       |   6 +-
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts       |   6 +-
 arch/arm/boot/dts/imx6dl-wandboard.dts             |   6 +-
 arch/arm/boot/dts/imx6dl.dtsi                      |  12 +-
 arch/arm/boot/dts/imx6q-b850v3.dts                 |   4 -
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   7 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  13 +-
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts             | 151 +++++++
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi             | 476 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-gk802.dts                  |   3 +-
 arch/arm/boot/dts/imx6q-icore-mipi.dts             |  25 ++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts          |  31 +-
 arch/arm/boot/dts/imx6q-kp-tpc.dts                 |  22 +
 arch/arm/boot/dts/imx6q-kp.dtsi                    | 432 +++++++++++++++++++
 arch/arm/boot/dts/imx6q-novena.dts                 |   2 -
 arch/arm/boot/dts/imx6q-pistachio.dts              |   2 +-
 arch/arm/boot/dts/imx6q-sabreauto.dts              |  15 +-
 arch/arm/boot/dts/imx6q-sabresd.dts                |  15 +-
 arch/arm/boot/dts/imx6q-udoo.dts                   |   6 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |   2 -
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts     |   2 -
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts        |   6 +-
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts        |   6 +-
 arch/arm/boot/dts/imx6q-wandboard.dts              |   6 +-
 arch/arm/boot/dts/imx6q.dtsi                       |  39 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   2 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |   2 -
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi              |   2 -
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  52 ++-
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       |  47 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |  25 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  15 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   3 -
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  18 +-
 arch/arm/boot/dts/imx6qdl-tx6-lcd.dtsi             |   1 -
 arch/arm/boot/dts/imx6qdl-tx6-mb7.dtsi             |   3 -
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   6 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |   6 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi     |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi     |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi     |   1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  14 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |  24 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  70 ++-
 arch/arm/boot/dts/imx6qp-sabreauto.dts             |  44 +-
 arch/arm/boot/dts/imx6qp-sabresd.dts               |  44 +-
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts       |   6 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts              |   5 +
 arch/arm/boot/dts/imx6qp.dtsi                      |  44 +-
 arch/arm/boot/dts/imx6sl-evk.dts                   |  10 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  34 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |   4 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             | 427 ++++++++++++++----
 arch/arm/boot/dts/imx6sx.dtsi                      | 101 ++---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  10 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |   2 -
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       |   2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   6 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  51 ++-
 arch/arm/boot/dts/imx6ull-pinfunc.h                |   9 +
 arch/arm/boot/dts/imx6ull.dtsi                     |   2 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   6 +-
 arch/arm/boot/dts/imx7d-pinfunc.h                  |   6 +-
 arch/arm/boot/dts/imx7d-sdb-sht11.dts              |  44 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |  70 ++-
 arch/arm/boot/dts/imx7d.dtsi                       |  71 ++-
 arch/arm/boot/dts/imx7s-warp.dts                   |   4 -
 arch/arm/boot/dts/imx7s.dtsi                       |  88 ++--
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |   2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |   6 -
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |   4 -
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |   4 +
 arch/arm/boot/dts/vfxxx.dtsi                       |   2 +-
 116 files changed, 2285 insertions(+), 1084 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-mamoj.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts
 create mode 100644 arch/arm/boot/dts/imx6q-dhcom-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6q-icore-mipi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-kp-tpc.dts
 create mode 100644 arch/arm/boot/dts/imx6q-kp.dtsi
