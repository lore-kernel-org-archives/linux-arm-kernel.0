From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 17:02:26 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.9
In-Reply-To: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
References: <1473670948-4265-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1473670948-4265-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.9

for you to fetch changes up to bb728d662bed0fe91b152550e640cb3f6caa972c:

  ARM: dts: add gpio-ranges property to iMX GPIO controllers (2016-09-09 14:21:55 +0800)

----------------------------------------------------------------
i.MX device tree changes for 4.9:
 - Add SoC support for i.MX7 Solo which is a reduced version of i.MX7
   Dual.
 - New board support: Gateworks Ventana i.MX6Q/DL GW553x, Inverse Path
   i.MX53 USB armory, i.MX6Q/DL TS-4900 from Technologic Systems,
   i.MX6UL GEA M6UL modules from Engicam, i.MX7 Solo Warp7 board.
 - Add DMA and IPU CSI devices for i.MX53 SoC support.
 - Refine i.MX7 Dual SoC DTS as a preparation of i.MX7 Solo support.
 - Use of_graph dt nodes to describe the panel for vf610-colibri and
   ls1021a-twr boards.
 - Add gpio-ranges property to i.MX6 GPIO controllers, which will be
   useful when GPIO driver is changed to request pad configuration as
   GPIO function.
 - Random device additions or small changes for various board support.

----------------------------------------------------------------
Andrej Rosano (2):
      devicetree: Add vendor prefix for Inverse Path
      ARM: dts: imx53: add support for USB armory board

Anson Huang (1):
      ARM: dts: imx6ul iomuxc syscon is compatible to imx6q

Breno Lima (1):
      ARM: dts: imx7s-warp: Add MPL3115 sensor support

Christoph Fritz (1):
      ARM: dts: imx6sx: document SION necessity of ENET1_REF_CLK1

Fabien Lahoudere (2):
      ARM: dts: imx53: Add DMA configuration for UART
      ARM: dts: imx53: Add IPU nodes for csi

Fabio Estevam (8):
      ARM: dts: imx7s-warp: Add initial support
      ARM: dts: imx7s: Add SDMA node
      ARM: dts: imx7s: Add SAI nodes
      ARM: dts: imx7s-warp: Add audio support
      ARM: dts: imx7s-warp: Add Wifi support
      ARM: dts: imx7s-warp: Use WDOG_B pin reset
      ARM: dts: imx6ul-pico-hobbit: Use WDOG_B pin reset
      ARM: dts: imx7s-warp: Let the codec control MCLK pinctrl

Joshua Clayton (1):
      ARM: dts: imx6q-evi: Use GPIO_6 for fec irq

Ken Lin (1):
      ARM: dts: imx6q-bx50v3: configure unused pca953x pins

Lucile Quirion (2):
      of: documentation: add bindings documentation for TS-4900
      ARM: dts: TS-4900: add basic device tree

Marek Vasut (1):
      ARM: dts: imx6sx: Add GPU bindings

Meng Yi (1):
      ARM: dts: ls1021a: Add of_graph dt nodes to describe the panel

Michael Trimarchi (1):
      ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL initial support

Sascha Hauer (1):
      ARM: i.MX6 Phytec PFLA02: Add supplies for the SoC internal regulators

Stefan Agner (8):
      ARM: dts: imx7d: move ARM platform peripherals inside soc node
      ARM: dts: imx7d: fix GIC nodes interrupt and register specification
      ARM: dts: imx7d: move CPU operating points to imx7d.dtsi
      ARM: dts: imx7d: add clock-frequency to CPU nodes
      ARM: dts: imx7-colibri: move SD-card to module level
      ARM: dts: imx7-colibri: add basic supply regulators
      ARM: dts: imx7-colibri: add Audio support
      ARM: dts: vf610-colibri: use of_graph dt nodes to describe the panel

Tim Harvey (3):
      ARM: dts: imx: ventana: Add ext watchdog reset
      ARM: dts: imx: add Gateworks Ventana GW553x support
      ARM: dts: imx: ventana: add RS485 txen gpio support

Uwe Kleine-K?nig (2):
      ARM: dts: imx6qdl: don't configure reserved pad settings
      ARM: dts: imx35: add iim module to imx35.dtsi

Vanessa Maegima (4):
      ARM: dts: imx6ul-pico-hobbit: Add Wifi support
      ARM: dts: imx7s-warp: Enable I2C2 device support
      ARM: dts: imx7s-warp: Add User Button support
      ARM: dts: imx7s-warp: Add Bluetooth support

Vladimir Zapolskiy (1):
      ARM: dts: add gpio-ranges property to iMX GPIO controllers

 .../devicetree/bindings/arm/technologic.txt        |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   9 +-
 arch/arm/boot/dts/imx35.dtsi                       |   7 +
 arch/arm/boot/dts/imx50.dtsi                       |  10 +
 arch/arm/boot/dts/imx53-usbarmory.dts              | 224 ++++++++++
 arch/arm/boot/dts/imx53.dtsi                       |  18 +
 arch/arm/boot/dts/imx6dl-gw553x.dts                |  55 +++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  22 +-
 arch/arm/boot/dts/imx6dl-ts4900.dts                |  49 +++
 arch/arm/boot/dts/imx6dl.dtsi                      |  53 +++
 arch/arm/boot/dts/imx6q-arm2.dts                   |  24 +-
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  16 +
 arch/arm/boot/dts/imx6q-b650v3.dts                 |   9 +
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |  24 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  70 +++
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  24 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |  24 +-
 arch/arm/boot/dts/imx6q-evi.dts                    |  28 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |  24 +-
 arch/arm/boot/dts/imx6q-gw553x.dts                 |  55 +++
 arch/arm/boot/dts/imx6q-marsboard.dts              |  24 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |  12 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |  24 +-
 arch/arm/boot/dts/imx6q-tbs2910.dts                |  24 +-
 arch/arm/boot/dts/imx6q-ts4900.dts                 |  53 +++
 arch/arm/boot/dts/imx6q.dtsi                       |  37 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  24 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |  24 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  36 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  39 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  39 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  44 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  12 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |  12 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              | 433 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  12 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  24 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  24 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  36 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |  24 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  24 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  24 +-
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi              | 481 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-udoo.dtsi                |  24 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  24 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  47 ++
 arch/arm/boot/dts/imx6sx-pinfunc.h                 |  14 +
 arch/arm/boot/dts/imx6sx.dtsi                      |  22 +
 arch/arm/boot/dts/imx6ul-geam-kit.dts              | 101 +++++
 arch/arm/boot/dts/imx6ul-geam.dtsi                 | 361 ++++++++++++++++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |  33 ++
 arch/arm/boot/dts/imx6ul.dtsi                      |   9 +-
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        |   4 -
 arch/arm/boot/dts/imx7-colibri.dtsi                |  61 ++-
 arch/arm/boot/dts/imx7d.dtsi                       |  42 +-
 arch/arm/boot/dts/imx7s-warp.dts                   | 446 +++++++++++++++++++
 arch/arm/boot/dts/imx7s.dtsi                       | 371 +++++++++-------
 arch/arm/boot/dts/ls1021a-twr.dts                  |  13 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  13 +-
 62 files changed, 3365 insertions(+), 506 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx53-usbarmory.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw553x.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-ts4900.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw553x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-ts4900.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw553x.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-ts4900.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-geam-kit.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-geam.dtsi
 create mode 100644 arch/arm/boot/dts/imx7s-warp.dts
