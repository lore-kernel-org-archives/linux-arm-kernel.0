From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 21 May 2018 11:48:39 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.18
Message-ID: <20180521094839.j7aq43ljqw4k4mvw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our usual bunch of arm32 DT changes for the next release.

Thanks!
Maxime

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.18

for you to fetch changes up to 5d9ef839f874f4e3923c8a9ae7b136c6c3912cd5:

  ARM: dts: sun7i: Add Olimex A20-SOM-EVB-eMMC board (2018-05-21 11:41:03 +0200)

----------------------------------------------------------------
Allwinner DT additions for 4.18

Here is our usual bunch of DT changes for our arm SoCs, with most
significantly:
  - MIPI-DSI support for the A33
  - NAND support for the A33
  - SMP support for the A83t
  - GMAC support for the R40
  - And some new boards: Olimex A20-SOM-EVB-eMMC, Nintendo NES and SuperNES
    Classic

----------------------------------------------------------------
Chen-Yu Tsai (3):
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Sort device node dereferences
      ARM: dts: sun8i: r40: Add device node and RGMII pinmux node for GMAC
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Enable GMAC ethernet controller

Icenowy Zheng (1):
      ARM: sun8i: v40: enable USB host ports for Banana Pi M2 Berry

Maxime Ripard (1):
      ARM: dts: sun8i: a33: Add the DSI-related nodes

Miquel Raynal (2):
      ARM: dts: sun8i: a23/a33: declare NAND pins
      ARM: dts: nes: add Nintendo NES/SuperNES Classic Edition support

Myl?ne Josserand (4):
      ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
      ARM: dts: sun8i: Add R_CPUCFG device node for the A83T dtsi
      ARM: dts: sun8i: a83t: Add CCI-400 node
      ARM: dts: sun8i: Add enable-method for SMP support for the A83T SoC

Stefan Mavrodiev (1):
      ARM: dts: sun7i: Add Olimex A20-SOM-EVB-eMMC board

Tuomas Tynkkynen (1):
      ARM: dts: sunxi: Change sun7i-a20-olimex-som204-evb to not use cd-inverted

kevans at FreeBSD.org (1):
      ARM: dts: sunxi: Add sid for a83t

 .../bindings/nvmem/allwinner,sunxi-sid.txt         |  1 +
 arch/arm/boot/dts/Makefile                         |  3 +
 .../arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts | 37 ++++++++
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts  |  3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 33 ++++++++
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 44 ++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 64 ++++++++++++++
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts    | 56 ++++++++++++
 .../dts/sun8i-r16-nintendo-super-nes-classic.dts   | 11 +++
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 99 ++++++++++++++--------
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 34 ++++++++
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  | 10 +++
 12 files changed, 359 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-nintendo-super-nes-classic.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180521/bde72701/attachment.sig>
