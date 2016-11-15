From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 17:00:29 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.10
In-Reply-To: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
References: <1479200431-1765-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1479200431-1765-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.10

for you to fetch changes up to c201369d4aa5f05b8a37d6d1eeabf248c7086454:

  ARM: dts: imx6ull: add imx6ull support (2016-11-15 08:54:27 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.10:
 - New boards support: i.MX6SX UDOO Neo, Boundary Devices Nitrogen6_SOM2,
   Engicam i.CoreM6, Grinn i.MX6UL liteSOM/liteBoard, Toradex Colibri
   iMX6 module, i.MX6ULL and EVK board.
 - Remove skeleton.dtsi inclusion from all i.MX SoC dts files, as it's
   been deprecated, since commit 9c0da3cc61f1233c ("ARM: dts: explicitly
   mark skeleton.dtsi as deprecated").
 - Misc device addition and enabling: OCOTP for Vybrid, MMDC for i.MX6QP,
   TMU for LS1021A, FEC for imx6qdl-icore, DMA for Vybrid DSPI.
 - A few cleanups: use hyphens for node names, fix white spaces, move
   imx-weim parameters into SoC dtsi, replace gpio-key,wakeup with
   wakeup-source, remove pwm-leds from imx6q-apalis-ixora, remove I2C3
   from vf610-zii-dev-rev-b.
 - Other small random changes: calibrate USB PHY for b650v3 board,
   update TX D_CAL for USBPHY, use enable-gpios for backlight on
   imx6qdl-apalis, etc.

----------------------------------------------------------------
Andreas F?rber (1):
      ARM: dts: imx6sx: Add UDOO Neo support

Andrey Smirnov (2):
      ARM: dts: vf610-zii-dev-rev-b: Remove I2C3
      ARM: dts: vfxxx: Add node corresponding to OCOTP

Christopher Spinrath (1):
      ARM: dts: imx6q-utilite-pro: i2c1 is muxed

Fabio Estevam (2):
      ARM: dts: imx6sx-udoo: Add board specific compatible strings
      ARM: dts: imx: Remove skeleton.dtsi

Frank Li (1):
      ARM: dts: add new compatible string for i.MX6QP mmdc

Gary Bisson (5):
      ARM: dts: imx: add Boundary Devices Nitrogen6_SOM2 support
      ARM: dts: imx6qdl-sabrelite: use hyphens for nodes name
      ARM: dts: imx6qdl-nitrogen6x: use hyphens for nodes name
      ARM: dts: imx6qdl-nit6xlite: use hyphens for nodes name
      ARM: dts: imx6qdl-nitrogen6_max: use hyphens for nodes name

Hongtao Jia (1):
      ARM: dts: ls1021a: Add TMU device tree support for LS1021A

Jagan Teki (7):
      ARM: dts: imx6qdl: Fix "WARNING: please, no space before tabs"
      ARM: dts: imx6qdl: Fix "ERROR: code indent should use tabs where possible"
      ARM: dts: imx6qdl-wandboard-revb: Fix "ERROR: trailing whitespace"
      ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual initial support
      ARM: dts: imx6q: Add Engicam i.CoreM6 DualLite/Solo initial support
      ARM: dts: imx6qdl-icore: Add FEC support
      ARM: dts: imx: Fix "ERROR: code indent should use tabs where possible"

Jaret Cantu (1):
      ARM: dts: imx: b650v3: Calibrate USB PHY to pass eye diagram test

Joshua Clayton (1):
      ARM: dts: imx6: Add imx-weim parameters to dtsi's

Marcin Niestroj (2):
      ARM: dts: imx6ul: Add DTS for liteSOM module
      ARM: dts: imx6ul: Add DTS for liteBoard

Marek Vasut (4):
      ARM: dts: imx6sx: Fix LCDIF interrupt type
      ARM: dts: novena: Enable PWM1
      ARM: dts: mxs: Add new M28EVK manufacturer compat
      ARM: dts: mx5: Add new M53EVK manufacturer compat

Peter Chen (4):
      ARM: dts: imx6ul-14x14-evk: add USB dual-role support
      ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
      ARM: dts: imx6ul-14x14-evk: update TX D_CAL for USBPHY
      ARM: dts: imx6ull: add imx6ull support

Sanchayan Maity (5):
      ARM: dts: imx6: Add support for Toradex Colibri iMX6 module
      ARM: dts: imx6q-apalis-ixora: Remove use of pwm-leds
      ARM: dts: imx6qdl-apalis: Use enable-gpios property for backlight
      ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
      ARM: dts: vfxxx: Enable DMA for DSPI2 and DSPI3

Sudeep Holla (1):
      ARM: dts: imx6q: replace gpio-key,wakeup with wakeup-source for Utilite Pro

 arch/arm/boot/dts/Makefile                     |  13 +-
 arch/arm/boot/dts/imx1.dtsi                    |   4 +-
 arch/arm/boot/dts/imx23.dtsi                   |   6 +-
 arch/arm/boot/dts/imx25.dtsi                   |   4 +-
 arch/arm/boot/dts/imx27.dtsi                   |   4 +-
 arch/arm/boot/dts/imx28-m28.dtsi               |   4 +-
 arch/arm/boot/dts/imx28-m28evk.dts             |   4 +-
 arch/arm/boot/dts/imx28.dtsi                   |   4 +-
 arch/arm/boot/dts/imx31.dtsi                   |   5 +-
 arch/arm/boot/dts/imx35.dtsi                   |   4 +-
 arch/arm/boot/dts/imx50.dtsi                   |  48 +-
 arch/arm/boot/dts/imx51.dtsi                   |  48 +-
 arch/arm/boot/dts/imx53-m53.dtsi               |   4 +-
 arch/arm/boot/dts/imx53-m53evk.dts             |   4 +-
 arch/arm/boot/dts/imx53.dtsi                   |  72 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts   | 253 +++++++
 arch/arm/boot/dts/imx6dl-icore.dts             |  59 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts         |   2 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts      |   2 +-
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts         |   2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts       |  22 -
 arch/arm/boot/dts/imx6q-b650v3.dts             |   6 +
 arch/arm/boot/dts/imx6q-evi.dts                |   3 -
 arch/arm/boot/dts/imx6q-icore.dts              |  59 ++
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts     |  53 ++
 arch/arm/boot/dts/imx6q-novena.dts             |   4 +
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts      |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts   |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts          |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts   |   2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts          |   2 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts        |  53 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi          |   9 +
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi         |  14 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi         | 890 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi          |   4 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi          |   4 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi          |   4 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi          |   2 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi           | 265 ++++++++
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi       |  32 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi   |  18 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi  | 770 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi      |  12 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi   |   6 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi       |   4 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi       |  10 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi         |   4 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi             |  32 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi |   2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       |   4 +-
 arch/arm/boot/dts/imx6qdl.dtsi                 |  14 +-
 arch/arm/boot/dts/imx6qp.dtsi                  |   7 +
 arch/arm/boot/dts/imx6sl.dtsi                  |   7 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi              |  16 +-
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts    |  69 ++
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts |  54 ++
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts     |  69 ++
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi         | 293 ++++++++
 arch/arm/boot/dts/imx6sx.dtsi                  |  17 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts         |  10 +-
 arch/arm/boot/dts/imx6ul-liteboard.dts         | 147 ++++
 arch/arm/boot/dts/imx6ul-litesom.dtsi          |  82 +++
 arch/arm/boot/dts/imx6ul.dtsi                  |   4 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts        |  52 ++
 arch/arm/boot/dts/imx6ull-pinfunc.h            |  56 ++
 arch/arm/boot/dts/imx6ull.dtsi                 |  43 ++
 arch/arm/boot/dts/imx7s.dtsi                   |   4 +-
 arch/arm/boot/dts/ls1021a.dtsi                 |  84 ++-
 arch/arm/boot/dts/vf-colibri.dtsi              |   4 +
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts      |  14 -
 arch/arm/boot/dts/vfxxx.dtsi                   |  18 +
 72 files changed, 3638 insertions(+), 268 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore.dts
 create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-colibri.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts
 create mode 100644 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-liteboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-litesom.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imx6ull.dtsi
