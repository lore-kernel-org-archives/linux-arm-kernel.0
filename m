From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:53 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.16
Message-ID: <cover.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC DT updates for v3.16.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.16

for you to fetch changes up to dd485ab9a88267f4db0d58ace23b19e876ebf8ac:

  ARM: shmobile: armadillo-reference dts: Seiko Instruments, Inc is "sii" (2014-04-16 10:03:42 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v3.16

r8a7791 (R-Car M2) and r8a7790 (R-Car H2) SoCs
* Add MSIOF nodes and aliases
* Correct I2C clock parents

r8a7791 (R-Car M2) SoC
* Add EHCI MSTP clock

r8a7791 (R-Car M2) based Koelsch and r8a7790 (R-Car H2) based Lager boards
* Add MSIOF nodes
* Add gpio-keys support for SW2
* Enable I2C
* Enable Quad SPI transfers for the SPI FLASH
* Rename and lable spi to qspi, add spi0 alias
* Set ethernet PHY LED mode

r8a7779 (R-Car H1) and r8a7778 (R-Car M2) SoCs
* Improve and correct HSPI nodes

r8a7778 (R-Car M2) based Bock-W board
* Add SPI FLASH

r8a7740 (R-Mobile A1) SoC
* Use r8a7740 suffix for i2c, mmcif, fsi2 compat strings

r8a7740 (R-Mobile A1) based Armadillo800 EVA board
* Enable RTC
* Use KEY_* macros for gpio-keys

EMEV2 (Emma Mobile EV2) based kzm9g board
* Use KEY_* macros for gpio-keys

----------------------------------------------------------------
Geert Uytterhoeven (14):
      ARM: shmobile: r8a7790/lager dts: Rename label spi to qspi, add spi0 alias
      ARM: shmobile: r8a7791/koelsch dts: Rename label spi to qspi, add spi0 alias
      ARM: shmobile: r8a7790 dtsi: Add MSIOF nodes and aliases
      ARM: shmobile: r8a7791 dtsi: Add MSIOF nodes and aliases
      ARM: shmobile: lager dts: Add MSIOF nodes
      ARM: shmobile: koelsch dts: Add MSIOF nodes
      ARM: shmobile: r8a7778 dtsi: Improve and correct HSPI nodes
      ARM: shmobile: r8a7779 dtsi: Improve and correct HSPI nodes
      ARM: shmobile: bockw reference dts: Add SPI FLASH
      ARM: shmobile: armadillo-reference dts: Use KEY_* macros for gpio-keys
      ARM: shmobile: kzm9g-reference dts: Use KEY_* macros for gpio-keys
      ARM: shmobile: koelsch dts: Enable Quad SPI transfers for the SPI FLASH
      ARM: shmobile: lager dts: Enable Quad SPI transfers for the SPI FLASH
      ARM: shmobile: armadillo-reference dts: Seiko Instruments, Inc is "sii"

Laurent Pinchart (4):
      ARM: shmobile: lager: Set ethernet PHY LED mode
      ARM: shmobile: koelsch: Set ethernet PHY LED mode
      ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
      ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT

Magnus Damm (4):
      ARM: shmobile: Update r8a7791 CPU freq to 1500MHz in DTS
      ARM: shmobile: Add DTS gpio-keys support for SW2 on Lager
      ARM: shmobile: Add DTS gpio-keys support for SW2 on Koelsch
      ARM: shmobile: r8a7791: Add EHCI MSTP clock

Simon Horman (1):
      ARM: shmobile: lager: Correct setting of ethernet PHY LED mode

Ulrich Hecht (2):
      ARM: shmobile: Use r8a7740 suffix for i2c, mmcif, fsi2 compat strings
      ARM: shmobile: armadillo-reference dts: enable RTC

Wolfram Sang (8):
      ARM: shmobile: r8a7791: add IIC0/1 clock macros
      ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
      ARM: shmobile: r8a7791: add IIC(B) cores to dtsi
      ARM: shmobile: koelsch: make i2c2-pfc node unique
      ARM: shmobile: koelsch: activate i2c6 bus
      ARM: shmobile: r8a7790: add IIC0-2 clock macros
      ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
      ARM: shmobile: r8a7790: add IIC(B) cores to dtsi

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  27 ++++-
 arch/arm/boot/dts/r8a7740.dtsi                     |   8 +-
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      |  14 +++
 arch/arm/boot/dts/r8a7778.dtsi                     |  18 ++--
 arch/arm/boot/dts/r8a7779.dtsi                     |  18 ++--
 arch/arm/boot/dts/r8a7790-lager.dts                |  63 ++++++++++-
 arch/arm/boot/dts/r8a7790.dtsi                     | 120 ++++++++++++++++++---
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  78 ++++++++++++--
 arch/arm/boot/dts/r8a7791.dtsi                     | 107 ++++++++++++++----
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |  15 +--
 include/dt-bindings/clock/r8a7790-clock.h          |   3 +
 include/dt-bindings/clock/r8a7791-clock.h          |   3 +
 12 files changed, 402 insertions(+), 72 deletions(-)
