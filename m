From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Mar 2018 16:56:23 +0100
Subject: [GIT PULL] Allwinner H3/H5 DT changes for 4.17
Message-ID: <20180322155623.gr44ltpzfo33kpas@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is the usual bunch of changes shared between arm and arm64 for
the merge window.

Thanks!
Maxime

PS: I've just noticed that I forgot to cc the LAKML on my previous
PRs. I'll bounce the mails to the ML.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-h3-h5-for-4.17

for you to fetch changes up to a7affb13b271a3e451efe15e911c0c0ab2db4859:

  arm64: allwinner: H5: Add Xunlong Orange Pi Zero Plus (2018-03-20 11:43:41 +0100)

----------------------------------------------------------------
Allwinner H3/H5 changes for 4.17

Here is our usual bunch of changes to the common DTSI shared between arm
and arm64, and their associated device trees.

Even though the diffstat is quite big, it's been mostly just cleanups. The
big feature is that the HDMI is now suported on H3 and H5 boards.

----------------------------------------------------------------
Giulio Benetti (1):
      ARM: dts: sun8i-h3: Add Mali node

Hauke Mehrtens (1):
      arm64: allwinner: H5: Add Xunlong Orange Pi Zero Plus

Icenowy Zheng (1):
      ARM: dts: sun8i: h2+: add support for Banana Pi M2 Zero board

Jelle van der Waa (1):
      ARM: dts: nanopi-neo-air: Add WiFi / eMMC

Jernej Skrabec (3):
      ARM: dts: sunxi: h3/h5: Add HDMI pipeline
      ARM: dts: sun8i: h3: Enable HDMI output on H3 boards
      ARM64: dts: sun50i: h5: Enable HDMI output on H5 boards

Joonas Kylm?l? (5):
      ARM: dts: sunxi: h3-h5: remove mmc0 card detection pin from pinctrl
      ARM: dts: sunxi: h3-h5: Move pinctrl of mmc0 from dts to dtsi
      ARM: dts: sunxi: h3-h5: Move pinctrl of mmc1 from dts to dtsi
      ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a
      ARM: dts: sun8i: h2-plus: remove unnecessary mmc1_pins node

Tuomas Tynkkynen (1):
      ARM: dts: sunxi: Switch MMC nodes away from cd-inverted property

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   3 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   3 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |   3 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   3 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |   3 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   3 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   3 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   3 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |   3 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |   3 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   3 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |   3 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   3 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   3 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   3 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   3 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |   3 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |   3 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   3 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |   3 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |   3 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |   3 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |   3 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   6 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |   3 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |   3 +-
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |   3 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |   3 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |   3 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |   3 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts                |   3 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |   3 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |   3 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |   3 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |   3 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |   3 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |   3 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |   3 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   3 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   3 +-
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |   3 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |   3 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |   3 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |   3 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |   3 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |   3 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   3 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |   3 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |   3 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |   3 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |   3 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   3 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |   3 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   3 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   6 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |   3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   6 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |   6 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |   3 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |   3 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |   3 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |   3 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |   3 +-
 arch/arm/boot/dts/sun8i-a23-evb.dts                |   3 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   3 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   3 +-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |   3 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |   3 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |   3 +-
 .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 121 +++++++++++++++++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  11 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  32 ++++-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |  32 ++++-
 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts |  30 ++++-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |   2 -
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |  25 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts      |  27 +++-
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |   5 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  32 ++++-
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |  32 ++++-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  29 ++++-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |   2 -
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  30 ++++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  27 ++++
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts       |   3 +-
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   3 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   3 +-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  |   3 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |   3 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |   3 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 | 122 ++++++++++++++++--
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   |   4 -
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   |   2 -
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |  27 +++-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     |  29 ++++-
 .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 143 +++++++++++++++++++++
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts    |  29 ++++-
 101 files changed, 794 insertions(+), 242 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180322/011d4b3c/attachment-0001.sig>
