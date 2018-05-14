From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 14 May 2018 13:26:17 +0200
Subject: [GIT PULL] ARM: mediatek: updates of dts32 for v4.18
Message-ID: <7205c939-b8f6-7da7-bca3-0b7951ebbdf4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Hi Olof,

please have a look on the following updates for 32-bit DTS files.

Thanks,
Matthias

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/
tags/v4.17-next-dts32

for you to fetch changes up to dd0dcf003dd86caba7726cc1e2ef268f1cf11aae:

  arm: dts: mt7623: add MT7623N reference board with eMMC (2018-05-11 17:52:28
+0200)

----------------------------------------------------------------
convert to SPDX IDs

mt7623:
- add audio, bluetooth, highspees DMA and SPI-NOR nodes
- fix invalid memory nodes by not using skeleton64.dtsi
- fix memory size for bananapi-r2
- fix dtc warnings
- refactor dts and dtsi to aviod code duplication
- add mt7623n and mt7623a reference boards

----------------------------------------------------------------
Ryder Lee (1):
      arm: dts: mediatek: modify audio related nodes for both MT2701 and MT7623

Sean Wang (10):
      arm: dts: mediatek: converted to using SPDX identifiers
      arm: dts: mt7623: fix invalid memory node being generated
      arm: dts: mt7623: fix available memory size on bananapi-r2
      arm: dts: mt7623: fix all Warnings (unit_address_vs_reg)
      arm: dts: mt7623: add BTIF, HSDMA and SPI-NOR device nodes
      arm: dts: mt6323: move node mt6323 leds to mt6323.dtsi
      arm: dts: mt7623: extend common file reused by all boards with MT7623 SoCs
      arm: dts: mt7623: add MT7623A SoC level DTS
      arm: dts: mt7623: add MT7623A reference boards
      arm: dts: mt7623: add MT7623N reference board with eMMC

 arch/arm/boot/dts/Makefile                    |   3 +
 arch/arm/boot/dts/mt2701-evb.dts              |   9 +-
 arch/arm/boot/dts/mt2701.dtsi                 | 197 +++++-----
 arch/arm/boot/dts/mt6323.dtsi                 |  17 +-
 arch/arm/boot/dts/mt6580-evbp1.dts            |   9 +-
 arch/arm/boot/dts/mt6580.dtsi                 |   9 +-
 arch/arm/boot/dts/mt6589-aquaris5.dts         |  10 +-
 arch/arm/boot/dts/mt6589.dtsi                 |  12 +-
 arch/arm/boot/dts/mt6592-evb.dts              |   9 +-
 arch/arm/boot/dts/mt6592.dtsi                 |   9 +-
 arch/arm/boot/dts/mt7623.dtsi                 | 537 ++++++++++++++++++++------
 arch/arm/boot/dts/mt7623a-rfb-emmc.dts        | 291 ++++++++++++++
 arch/arm/boot/dts/mt7623a-rfb-nand.dts        | 337 ++++++++++++++++
 arch/arm/boot/dts/mt7623a.dtsi                |  44 +++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 279 ++-----------
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 326 ++++++++++++++++
 arch/arm/boot/dts/mt7623n-rfb-nand.dts        |  40 +-
 arch/arm/boot/dts/mt7623n-rfb.dtsi            |  12 +-
 arch/arm/boot/dts/mt8127-moose.dts            |   9 +-
 arch/arm/boot/dts/mt8127.dtsi                 |   9 +-
 arch/arm/boot/dts/mt8135-evbp1.dts            |   9 +-
 arch/arm/boot/dts/mt8135.dtsi                 |   9 +-
 22 files changed, 1573 insertions(+), 613 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-emmc.dts
 create mode 100644 arch/arm/boot/dts/mt7623a-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623a.dtsi
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-emmc.dts
