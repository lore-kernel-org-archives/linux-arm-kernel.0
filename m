From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:00:34 +0100
Subject: [GIT PULL] Allwinner late DT changes for 4.10
Message-ID: <20161115210034.mwqnsggmmbzoav77@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a pull request that should be merged after the pinctrl PR,
hence probably in your late PR.

This is just a mechanic conversion to the generic pinconf bindings and
removal of the useless pinmux properties we had.

This is based on the previous DT PR I just sent.

Thanks!
Maxime

The following changes since commit e39a30cf736144814b0bddb3fff28fbbc2a8be0f:

  ARM: sunxi: Add the missing clocks to the pinctrl nodes (2016-11-15 18:49:47 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-late-for-4.10

for you to fetch changes up to 1d20ba07ea57ae227a925302b42221df5b830f2b:

  ARM: sunxi: Convert pinctrl nodes to generic bindings (2016-11-15 21:56:30 +0100)

----------------------------------------------------------------
Allwinner late DT additions for 4.10

Conversion to the generic pin conf bindings for our device trees

----------------------------------------------------------------
Maxime Ripard (3):
      ARM: sunxi: Remove useless allwinner,drive property
      ARM: sunxi: Remove useless allwinner,pull property
      ARM: sunxi: Convert pinctrl nodes to generic bindings

 arch/arm/boot/dts/ntc-gr8-chip-pro.dts             |  12 +-
 arch/arm/boot/dts/ntc-gr8-evb.dts                  |  24 +-
 arch/arm/boot/dts/ntc-gr8.dtsi                     | 122 ++++-----
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  12 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  14 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  14 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |  38 ++-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   6 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |  12 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |  16 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |  26 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |  14 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |  29 +--
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |  12 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |  13 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |  18 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  27 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |  19 +-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts           |   6 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |  32 +--
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 169 +++++--------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |  18 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  29 +--
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |  19 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  36 ++-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |  20 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |  21 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  43 ++--
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  23 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |  22 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |  40 ++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  36 ++-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  17 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  24 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  27 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |  33 +--
 arch/arm/boot/dts/sun5i.dtsi                       |  75 +++---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |   6 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |  22 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  23 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |  19 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |  19 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |  19 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  98 +++-----
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  20 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  13 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |  29 +--
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |   9 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |  14 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |  27 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |  26 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |  37 +--
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  13 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  38 +--
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |  24 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |  26 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |   7 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  30 +--
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |   6 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |  12 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  32 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |  27 +-
 .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    |   6 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |  33 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  28 +--
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |  45 ++--
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |  38 ++-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |  25 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |  21 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  25 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |  13 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 277 ++++++++-------------
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  95 +++----
 arch/arm/boot/dts/sun8i-a23-evb.dts                |   7 +-
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |   8 +-
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |   8 +-
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |   9 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |  18 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  11 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   6 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |  21 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  18 +-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  26 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |   4 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  18 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  10 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 104 +++-----
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |   9 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |  36 ++-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |  26 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  23 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  41 ++-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  61 ++---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |  24 +-
 99 files changed, 1083 insertions(+), 1783 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/d965478b/attachment.sig>
