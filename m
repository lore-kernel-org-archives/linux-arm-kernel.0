From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 15:53:38 +0800
Subject: [GIT PULL 1/3] i.MX device tree updates for 4.14
Message-ID: <1503042820-13043-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.14

for you to fetch changes up to b3766c518172188b220282fa412ff6f6f65be856:

  ARM: dts: imx6q-bx50v3: Enable i2c recovery mechanism (2017-08-14 09:45:13 +0800)

----------------------------------------------------------------
i.MX device tree updates for 4.14:
 - A series from Andrew Lunn updating imx6-rdu2 board to enable
   on-board Marvell switch support.
 - A series from Jagan Teki updating imx6ul-isiot and imx6ul-geam to
   enable audio card and FEC support.
 - Add support for Toradex Ixora V1.1 and Apalis Evaluation Board
   along with some cleanups.
 - Enable DRM display support for imx6ul-evk and imx7d-sdb board.
 - Add i.MX53 based Beckhoff CX9020 board support.
 - Add GPMI NAND and APBH DMA devices for i.MX7 and enables NAND support
   for imx7-colibri board.
 - Enables the ADV7180 analog video decoder sensor connected to the
   IMX6 IPU on various Gateworks Ventana boards.
 - Minor updates on misc boards and some random cleanups.

----------------------------------------------------------------
Andrew Lunn (5):
      ARM: dts: imx6: RDU2: Add Micrel PHY to FEC
      ARM: dts: imx6: RDU2: Add DSA support for the Marvell 88E6352
      ARM: dts: imx6: RDU2: Add Switch EEPROM
      ARM: dts: imx6: RDU2: Add Switch interrupts
      ARM: dts: imx6: RDU2: Add Micrel PHY interrupt

Fabio Estevam (5):
      ARM: dts: imx7d-sdb: Pass phy-reset-gpios
      ARM: dts: imx6qdl-icore-rqs: Remove unneeded 'fsl,mode' property
      ARM: dts: imx6qdl-gw5xxx: Remove the 'uart-has-rtscts' property
      ARM: dts: imx7d-sdb: Add flexcan support
      ARM: dts: imx6ul-14x14-evk: Remove unrelated pin from ENET group

Gary Bisson (2):
      ARM: dts: imx6qdl-sabrelite: fix USB PHY reset
      ARM: dts: imx6qdl-nitrogen6x: fix USB PHY reset

Gautam Bhat (1):
      ARM: dts: imx7d-sdb: Set VLDO4 outpt to 2.8V for MIPI CSI/DSI

Guy Shapiro (1):
      ARM: dts: imx: update snvs-poweroff mask

Jagan Teki (7):
      ARM: dts: imx6ul-isiot: Move common nodes in imx6ul-isiot.dtsi
      ARM: dts: imx6ul-isiot: Add Sound card with codec node
      ARM: dts: imx6ul-isiot: Add FEC node support
      ARM: dts: imx6ul-geam-kit: Remove re-enabled usdhc1
      ARM: dts: imx6ul-geam: Drop imx6ul-geam.dtsi
      ARM: dts: imx6ul-geam: Skip suffix -kit from dts name
      ARM: dts: imx6ul-geam: Add Sound card with codec node

Jose Alarcon (1):
      ARM: dts: imx6q-bx50v3: Enable i2c recovery mechanism

Marcel Ziswiler (6):
      ARM: dts: imx6q-apalis-ixora: combine aliases
      ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: get rid of tegra legacy gen1_i2c comment
      ARM: dts: imx6qdl-apalis: reword cam i2c comment
      ARM: dts: imx6q-apalis-ixora: get rid of obsolete fusion comment
      ARM: dts: imx6q-apalis-ixora: add camera i2c bus definition
      ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: use i2c from dwc hdmi

Marcin Niestroj (1):
      ARM: dts: imx6ul-liteboard: Support poweroff

Marco Franchi (4):
      ARM: dts: imx6ul-evk: Add DRM panel support
      ARM: dts: imx6ul-evk: Pass the 'backlight' property
      ARM: dts: imx7d-sdb: Add DRM panel support
      ARM: dts: imx7d-sdb: Pass 'enable-gpios' and 'power-supply' properties

Martyn Welch (1):
      ARM: dts: imx: Correct B850v3 clock assignment

Oleksij Rempel (1):
      ARM: dts: imx6: RIoTboard provide gpio-line-names

Patrick Bruenn (4):
      dt-bindings: arm: Add entry for Beckhoff CX9020
      ARM: dts: imx53: add srtc node
      ARM: dts: imx53: add alternative UART2 configuration
      ARM: dts: imx: add CX9020 Embedded PC device tree

Sanchayan Maity (4):
      ARM: dts: imx6q-apalis-ixora: fix usdhc2 pinctrl property
      ARM: dts: imx6qdl-apalis: split usdhc1 pinctrl to support 4- and 8-bit
      ARM: dts: imx6: add support for Toradex Ixora V1.1 carrier board
      ARM: dts: imx6q-apalis-eval: add support for Apalis Evaluation Board

Stefan Agner (2):
      ARM: dts: imx7: add GPMI NAND and APBH DMA
      ARM: dts: imx7-colibri: add NAND support

Steffen Trumtrar (1):
      ARM: dts: i.MX25: add RNGB node to dtsi

Tim Harvey (1):
      ARM: dts: imx: ventana: add ADV1780 analog video decoder

 Documentation/devicetree/bindings/arm/bhf.txt      |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/imx25.dtsi                       |   7 +
 arch/arm/boot/dts/imx53-cx9020.dts                 | 297 +++++++++++++++++++++
 arch/arm/boot/dts/imx53-pinfunc.h                  |   4 +
 arch/arm/boot/dts/imx53.dtsi                       |   9 +
 arch/arm/boot/dts/imx6dl-gw52xx.dts                |  58 ++++
 arch/arm/boot/dts/imx6dl-gw53xx.dts                |  58 ++++
 arch/arm/boot/dts/imx6dl-gw54xx.dts                |  58 ++++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |  45 ++++
 arch/arm/boot/dts/imx6q-apalis-eval.dts            | 278 +++++++++++++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      | 291 ++++++++++++++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |  32 +--
 arch/arm/boot/dts/imx6q-b850v3.dts                 |   2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                |  42 +++
 arch/arm/boot/dts/imx6q-gw52xx.dts                 |  58 ++++
 arch/arm/boot/dts/imx6q-gw53xx.dts                 |  58 ++++
 arch/arm/boot/dts/imx6q-gw54xx.dts                 |  58 ++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |  44 ++-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  54 ++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   1 -
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |  54 ++++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  19 ++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  19 ++
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            | 112 +++++++-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   1 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   1 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   1 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  40 ++-
 arch/arm/boot/dts/imx6ul-geam-kit.dts              | 101 -------
 .../boot/dts/{imx6ul-geam.dtsi => imx6ul-geam.dts} |  74 +++++
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi         | 141 ----------
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            |   1 -
 arch/arm/boot/dts/imx6ul-isiot-nand.dts            |   1 -
 arch/arm/boot/dts/imx6ul-isiot.dtsi                | 183 +++++++++++++
 arch/arm/boot/dts/imx6ul-liteboard.dts             |   4 +
 arch/arm/boot/dts/imx6ul.dtsi                      |   1 +
 arch/arm/boot/dts/imx7-colibri.dtsi                |   9 +
 arch/arm/boot/dts/imx7d-sdb.dts                    |  93 ++++---
 arch/arm/boot/dts/imx7s.dtsi                       |  32 +++
 44 files changed, 2003 insertions(+), 353 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-eval.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
 delete mode 100644 arch/arm/boot/dts/imx6ul-geam-kit.dts
 rename arch/arm/boot/dts/{imx6ul-geam.dtsi => imx6ul-geam.dts} (87%)
 delete mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi
