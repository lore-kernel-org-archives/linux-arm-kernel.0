From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Thu,  8 Feb 2018 14:01:37 +0200
Subject: [PATCH v3 0/4] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 and mmc1
 to dtsi
Message-ID: <20180208120141.15780-1-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This short patch series moves mmc0 and mmc1 pinctrl in H3 and H2+
boards' dts files to the dtsi file in order to make it easier to do
changes in the future to pinctrl attributes if required. This sort of
cleaning up of the dts files was discussed earlier in the email thread
with the subject "[linux-sunxi] [PATCH v2 6/8] ARM: dts: sun8i: a83t:
Move mmc1 pinctrl setting to dtsi file".

As this is my first patch submission I urge you to look through the
patches carefully. I have tested that after applying the patches the
Orange Pi Zero still boots and MMC0 works and also its detect pin. I
don't have any of the other devices to test this with. I also build
the kernel using ARCH=arm64 and ARCH=arm.

These patches are prepared against the branch sunxi/dt-for-4.17.

Changes since v1:
 - Remove pinctrl from CD pin as noted by Maxime Ripard.
 - Move pinctrl to dtsi also from those new dts files that were
   introduced after v1 patch.

Changes since v2:
 - Make the changes also to H5 boards.
 - Split card detection pin removal to its own patch.
 - Add patch for removing the _a suffix from mmc{0,1}_pins_a.

Best regards,
Joonas Kylm?l?

Joonas Kylm?l? (4):
  ARM: dts: sunxi: h3-h5: remove mmc0 card detection pin from pinctrl
  ARM: dts: sunxi: h3-h5: Move pinctrl of mmc0 from dts to dtsi
  ARM: dts: sunxi: h3-h5: Move pinctrl of mmc1 from dts to dtsi
  ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts          |  6 +-----
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts            |  4 ----
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts                  |  4 ----
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts         |  2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts              |  2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts              |  4 ----
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi                     |  2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts                  |  4 ----
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts               |  4 ----
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts                |  2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts            |  2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts                 |  2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                         | 14 ++++++--------
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts      |  4 ----
 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts    |  2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts   |  2 --
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts |  4 ----
 .../boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts   |  2 --
 18 files changed, 7 insertions(+), 59 deletions(-)

-- 
2.11.0
