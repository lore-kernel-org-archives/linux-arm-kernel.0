From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 21 May 2018 11:55:17 +0200
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.18
Message-ID: <20180521095517.liyqgj32d3xd7ejq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our usual PR with the changes that apply to the H3 and H5,
shared between arm and arm64.

Maxime

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-h3-h5-for-4.18

for you to fetch changes up to 06139c822c5011ff79341000f44eca96151aac92:

  ARM: dts: sun8i: h3: Add SY8106A regulator to Orange Pi PC (2018-05-11 10:00:28 +0200)

----------------------------------------------------------------
Allwinner H3/H5 support for 4.18

Here is our usual bunch of changes for the H3 and H5 SoCs that share the
same SoC design but with different CPUs.

This time, most of the changes are about supporting CPUFreq on these SoCs,
with voltage scaling being enabled for a number of boards.

----------------------------------------------------------------
Chen-Yu Tsai (5):
      ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VCC-1V2 regulator voltage
      ARM: dts: sun8i: h2-plus: Sort dtb entries in Makefile
      ARM: dts: sun8i: h2+: Add Libre Computer Board ALL-H3-CC H2+ ver.
      arm64: dts: allwinner: h5: Add cpu0 label for first cpu
      arm64: dts: allwinner: Sort dtb entries in Makefile

Icenowy Zheng (5):
      ARM: dts: sun8i: h3: add operating-points-v2 table for CPU
      ARM: dts: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board
      ARM: dts: sun8i: h3: add SY8113B regulator used by Orange Pi One board
      ARM: dts: sun8i: h3: fix ALL-H3-CC H3 ver VDD-CPUX voltage
      ARM: dts: sun8i: h3: set the cpu-supply to VDD-CPUX on ALL-H3-CC H3 ver

Neil Armstrong (2):
      arm: dts: sun8i: h3: libretech-all-h3-cc: Move board definition to common dtsi
      arm64: dts: allwinner: Add dts file for Libre Computer Board ALL-H3-CC H5 ver.

Ondrej Jirman (3):
      ARM: dts: sunxi: h3/h5: Add r_i2c pinmux node
      ARM: dts: sunxi: h3/h5: Add r_i2c I2C controller
      ARM: dts: sun8i: h3: Add SY8106A regulator to Orange Pi PC

 arch/arm/boot/dts/Makefile                         |   3 +-
 .../boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts |  13 ++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  21 ++
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 206 +-------------------
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  21 ++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  28 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  32 ++-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  18 ++
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 215 +++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +-
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts    |  14 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |   2 +-
 12 files changed, 368 insertions(+), 210 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-libretech-all-h3-cc.dts
 create mode 100644 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/74f9de15/attachment.sig>
