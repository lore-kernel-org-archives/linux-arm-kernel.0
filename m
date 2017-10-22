From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Sun, 22 Oct 2017 12:19:55 +0300
Subject: [PATCH 0/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 and mmc1 to
 dtsi
Message-ID: <20171022091957.24614-1-joonas.kylmala@iki.fi>
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

These patches are prepared against the branch sunxi/dt-for-4.15.

Best regards,
Joonas Kylm?l?

Joonas Kylm?l? (2):
  ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0 from dts to dtsi
  ARM: dts: sun8i: h3-h5: Move pinctrl of mmc1 from dts to dtsi

 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ----
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts   | 4 ----
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts         | 4 ----
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts     | 2 --
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi            | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts         | 4 ----
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts      | 4 ----
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts       | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts   | 2 --
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts        | 2 --
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                | 4 ++++
 11 files changed, 4 insertions(+), 30 deletions(-)

-- 
2.11.0
