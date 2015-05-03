From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 May 2015 12:13:37 +0200
Subject: [PATCH 0/3] ARM: sunxi: DT: Fix checkpatch warnings
Message-ID: <1430648020-8328-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Our device trees generate a number of checkpatch warnings.

The serie fixes all of them but the undocumented bindings warning, for
the boards compatible.

Maxime

Maxime Ripard (3):
  ARM: sunxi: dt: Remove the FSF address
  ARM: sunxi: DT: Fix lines over 80 characters
  ARM: sunxi: dt: Fix whitespace errors

 arch/arm/boot/dts/axp209.dtsi                    |  5 --
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |  5 --
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  5 --
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  |  5 --
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  5 --
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts         |  5 --
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  5 --
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts     |  5 --
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  5 --
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts       |  5 --
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        |  5 --
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  5 --
 arch/arm/boot/dts/sun4i-a10-mk802.dts            |  5 --
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts          |  5 --
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  5 --
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  5 --
 arch/arm/boot/dts/sun4i-a10.dtsi                 | 27 +++++-----
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts     |  5 --
 arch/arm/boot/dts/sun5i-a10s-mk802.dts           |  5 --
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  5 --
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    |  5 --
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 34 +++++++------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  5 --
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  5 --
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  5 --
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts         |  5 --
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 36 ++++++-------
 arch/arm/boot/dts/sun5i.dtsi                     | 10 ++--
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  5 --
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  5 --
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  5 --
 arch/arm/boot/dts/sun6i-a31-i7.dts               |  5 --
 arch/arm/boot/dts/sun6i-a31-m9.dts               |  5 --
 arch/arm/boot/dts/sun6i-a31.dtsi                 | 45 +++++++++--------
 arch/arm/boot/dts/sun6i-a31s-cs908.dts           |  5 --
 arch/arm/boot/dts/sun6i-a31s.dtsi                |  5 --
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  5 --
 arch/arm/boot/dts/sun7i-a20-bananapro.dts        |  5 --
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |  5 --
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |  5 --
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  5 --
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        |  5 --
 arch/arm/boot/dts/sun7i-a20-m3.dts               |  5 --
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   |  5 --
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  5 --
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  5 --
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts    |  5 --
 arch/arm/boot/dts/sun7i-a20-orangepi.dts         |  5 --
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts    |  5 --
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         |  5 --
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts   |  5 --
 arch/arm/boot/dts/sun7i-a20.dtsi                 | 64 +++++++++++++-----------
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts    |  5 --
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  5 --
 arch/arm/boot/dts/sun8i-a23.dtsi                 | 11 ++--
 arch/arm/boot/dts/sun9i-a80-optimus.dts          |  5 --
 arch/arm/boot/dts/sun9i-a80.dtsi                 |  7 +--
 arch/arm/boot/dts/sunxi-common-regulators.dtsi   |  5 --
 58 files changed, 117 insertions(+), 367 deletions(-)

-- 
2.3.6
