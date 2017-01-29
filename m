From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 29 Jan 2017 12:06:41 +0800
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.11
In-Reply-To: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
References: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1485662803-31235-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.11

for you to fetch changes up to 18ba386826f143dc4177830cc7c24c7abf4de4be:

  ARM: dts: udoo_neo: Add Bluetooth support (2017-01-29 10:04:06 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.11:
 - New board support: vf610-zii-dev-rev-c, imx6ul-opos6uldev,
   imx6ul-isiot, imx6qdl-savageboard, imx6q-mccmon6.
 - A patch from Alexandre to correct the mangled license text which
   has been copied & pasted all over the i.MX device tree files.
 - Update cpu nodes of some i.MX SoCs to make them consistent and match
   ePAPR spec.
 - Add OCOTP device for i.MX6UL SoC.
 - Add security violation interrupt for i.MX25 DryIce.
 - Enable USB OTG, WIFI and Bluetooth support for i.MX6SX Udoo Neo
   board.
 - Enable S/PDIF and 2nd display pipeline support for CompuLab board..
 - Add SPI and LTC3676 PMIC support for Gateworks Ventana boards.
 - A few random device addition for various boards: TVE DAC regulators
   for imx53-qsb, EEPROM for vf610-zii-dev, eMMC and NAND support for
   i.MX6UL Engicam boards.
 - Cleanups on obsoleted or unused properties.

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: imx/vf: Correct license text

Andrey Smirnov (2):
      ARM: dts: vf610-zii-dev-rev-b: Remove leftover PWM pingroup
      ARM: dts: vf610-zii-dev: Add .dts file for rev. C

Bai Ping (1):
      ARM: dts: imx: Add ocotp node for imx6ul

Breno Lima (3):
      ARM: dts: udoo_neo: Add UDOO Neo USB OTG1 and OTG2 support
      ARM: dts: udoo_neo: Add Wifi support
      ARM: dts: udoo_neo: Add Bluetooth support

Christopher Spinrath (2):
      ARM: dts: imx6q-cm-fx6: enable S/PDIF support
      ARM: dts: imx6q-utilite-pro: enable 2nd display pipeline

Fabio Estevam (4):
      ARM: dts: imx: Adjust CPU nodes
      ARM: dts: imx6sx-udoo-neo: Pass the 'phy-reset-duration' property
      ARM: dts: imx: Remove unexistant property
      ARM: dts: imx53-qsb: Provide the TVE DAC regulators

Gary Bisson (1):
      ARM: dts: boundary: remove hardcoded LVDS bus format

Jagan Teki (6):
      ARM: dts: imx6dl: Add Engicam i.CoreM6 DualLite/Solo RQS initial support
      ARM: dts: imx6q-icore-rqs: Update model to support Dual SOM
      ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL initial support
      ARM: dts: imx6qdl: Fix "ERROR: code indent should use tabs where possible"
      ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL eMMC initial support
      ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL NAND initial support

J?rg Krause (1):
      ARM: dts: imx28: Add simple-card support

Lukasz Majewski (2):
      Doc: devicetree: bindings: Add vendor prefix entry - lwn
      ARM: dts: imx6q: Add mccmon6 board support

Martin Kaiser (1):
      ARM: dts: imx25.dtsi: DryIce security violation interrupt

Milo Kim (3):
      ARM: dts: imx6: Add Savageboard common file
      ARM: dts: imx6: Support Savageboard dual
      ARM: dts: imx6: Support Savageboard quad

S?bastien Szymanski (1):
      ARM: dts: add Armadeus Systems OPOS6UL and OPOS6ULDEV support

Tim Harvey (2):
      ARM: dts: imx: add SPI to GW54xx
      ARM: dts: imx: ventana: add LTC3676 PMIC support

Vivien Didelot (1):
      ARM: dts: vf610-zii-dev: add EEPROM entry to Rev C

Vladimir Zapolskiy (1):
      ARM: dts: imx: remove obsoleted property fsl,spi-num-chipselects

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |  10 +-
 arch/arm/boot/dts/imx1-ads.dts                     |   1 -
 arch/arm/boot/dts/imx1.dtsi                        |   3 +-
 arch/arm/boot/dts/imx23.dtsi                       |   5 +-
 arch/arm/boot/dts/imx25.dtsi                       |   7 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   2 -
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   1 -
 arch/arm/boot/dts/imx27-pdk.dts                    |   1 -
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |   1 -
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   1 -
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   1 -
 arch/arm/boot/dts/imx27.dtsi                       |   1 +
 arch/arm/boot/dts/imx28.dtsi                       |   7 +-
 arch/arm/boot/dts/imx31.dtsi                       |   5 +-
 arch/arm/boot/dts/imx35.dtsi                       |   5 +-
 arch/arm/boot/dts/imx50-evk.dts                    |   1 -
 arch/arm/boot/dts/imx51-apf51dev.dts               |   2 -
 arch/arm/boot/dts/imx51-babbage.dts                |   1 -
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |   1 -
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   1 -
 arch/arm/boot/dts/imx53-qsb.dts                    |   5 +-
 arch/arm/boot/dts/imx53-qsrb.dts                   |   6 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   1 -
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   2 -
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   1 -
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   1 -
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts       |  10 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts       |  10 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts        |   1 -
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |  10 +-
 arch/arm/boot/dts/imx6dl-cubox-i.dts               |  10 +-
 arch/arm/boot/dts/imx6dl-hummingboard.dts          |  10 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts             |  51 +++
 arch/arm/boot/dts/imx6dl-icore.dts                 |  10 +-
 arch/arm/boot/dts/imx6dl-nit6xlite.dts             |  10 +-
 arch/arm/boot/dts/imx6dl-nitrogen6x.dts            |  10 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |  10 +-
 arch/arm/boot/dts/imx6dl-savageboard.dts           |  51 +++
 arch/arm/boot/dts/imx6dl-ts4900.dts                |  10 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |  10 +-
 arch/arm/boot/dts/imx6q-b450v3.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-b650v3.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-b850v3.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |  11 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  11 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  32 +-
 arch/arm/boot/dts/imx6q-cubox-i.dts                |  10 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   1 -
 arch/arm/boot/dts/imx6q-evi.dts                    |   3 -
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   1 -
 arch/arm/boot/dts/imx6q-h100.dts                   |  10 +-
 arch/arm/boot/dts/imx6q-hummingboard.dts           |  10 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |  12 +-
 arch/arm/boot/dts/imx6q-icore.dts                  |  10 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              |  11 +-
 arch/arm/boot/dts/imx6q-mccmon6.dts                | 473 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-nitrogen6_max.dts          |  10 +-
 arch/arm/boot/dts/imx6q-nitrogen6_som2.dts         |  10 +-
 arch/arm/boot/dts/imx6q-nitrogen6x.dts             |  10 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |   1 -
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  10 +-
 arch/arm/boot/dts/imx6q-savageboard.dts            |  55 +++
 arch/arm/boot/dts/imx6q-ts4900.dts                 |  10 +-
 arch/arm/boot/dts/imx6q-utilite-pro.dts            | 115 +++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  12 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |   1 -
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   1 -
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |  13 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |  11 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |  10 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |   1 -
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              | 132 ++++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              | 166 +++++---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              | 163 ++++---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  16 +
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              | 132 ++++--
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              | 130 ++++--
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |  98 ++++-
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |  10 +-
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |  14 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |  10 +-
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |  10 +-
 arch/arm/boot/dts/imx6qdl-microsom.dtsi            |  10 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi           |  13 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |  15 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |  13 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  13 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   1 -
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   2 -
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  13 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   1 -
 arch/arm/boot/dts/imx6qdl-savageboard.dtsi         | 255 +++++++++++
 arch/arm/boot/dts/imx6qdl-ts4900.dtsi              |  12 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   1 -
 arch/arm/boot/dts/imx6sl-evk.dts                   |   1 -
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |  11 +-
 arch/arm/boot/dts/imx6sx-sdb-sai.dts               |  10 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             | 137 ++++++
 arch/arm/boot/dts/imx6ul-geam-kit.dts              |  10 +-
 arch/arm/boot/dts/imx6ul-geam.dtsi                 |  10 +-
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            |  77 ++++
 arch/arm/boot/dts/imx6ul-isiot-nand.dts            |  79 ++++
 arch/arm/boot/dts/imx6ul-isiot.dtsi                | 114 +++++
 arch/arm/boot/dts/imx6ul-liteboard.dts             |  10 +-
 arch/arm/boot/dts/imx6ul-litesom.dtsi              |  10 +-
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi              | 192 +++++++++
 arch/arm/boot/dts/imx6ul-opos6uldev.dts            | 412 ++++++++++++++++++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts           |  10 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   1 -
 arch/arm/boot/dts/imx6ul.dtsi                      |   7 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |  10 +-
 arch/arm/boot/dts/imx6ull.dtsi                     |  10 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |   1 -
 arch/arm/boot/dts/imx7s.dtsi                       |   1 -
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  10 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  |  10 +-
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |  10 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |  10 +-
 arch/arm/boot/dts/vf500.dtsi                       |  10 +-
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts        |  10 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               |  10 +-
 arch/arm/boot/dts/vf610-twr.dts                    |  10 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          | 334 +--------------
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          | 416 ++++++++++++++++++
 arch/arm/boot/dts/vf610-zii-dev.dtsi               | 383 +++++++++++++++++
 arch/arm/boot/dts/vf610.dtsi                       |  10 +-
 arch/arm/boot/dts/vf610m4-colibri.dts              |  10 +-
 arch/arm/boot/dts/vf610m4-cosmic.dts               |  10 +-
 arch/arm/boot/dts/vf610m4.dtsi                     |  10 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |  10 +-
 132 files changed, 3870 insertions(+), 920 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-rqs.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-savageboard.dts
 create mode 100644 arch/arm/boot/dts/imx6q-mccmon6.dts
 create mode 100644 arch/arm/boot/dts/imx6q-savageboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-savageboard.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-emmc.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-nand.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-opos6ul.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-opos6uldev.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev.dtsi
