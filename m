From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Wed,  7 Feb 2018 22:48:03 +0200
Subject: [PATCH v2 0/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 and mmc1
 to dtsi
Message-ID: <20180207204805.16884-1-joonas.kylmala@iki.fi>
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
don't have any of the other devices to test this with.

These patches are prepared against the branch sunxi/dt-for-4.17.

Changes since v1:
 - Remove pinctrl from CD pin as noted by Maxime Ripard.
 - Move pinctrl to dtsi also from those new dts files that were
   introduced after v1 patch.

Best regards,
Joonas Kylm?l?

Joonas Kylm?l? (2):
  ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 from dts to dtsi
  ARM: dts: sun8i: h3-h5: Move pinctrl of mmc1 from dts to dtsi

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  4 ----
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  4 ----
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |  4 ----
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |  2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |  2 --
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts      |  4 ----
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |  2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  4 ----
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |  4 ----
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |  2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 10 ++++------
 13 files changed, 4 insertions(+), 42 deletions(-)

-- 
2.11.0
