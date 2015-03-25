From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 14:21:24 -0700
Subject: [GIT PULL] Allwinner DT additions for 4.1
Message-ID: <20150325212124.GA17842@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This is the usual pull request for the Allwinner DT changes.

This branch is merging the clock branch I sent to mike to remove some
bisection and dependency issues.

Thanks!
Maxime

The following changes since commit f1017969661dd33ead5ba7c3f4a0793c6611441a:

  clk: sunxi: Add pll6 / 4 clock output to sun4i-a10-pll6 (2015-03-25 11:46:41 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.1

for you to fetch changes up to b4f8a14b1262c7e965d6f2412cf7295fbaef0d6f:

  ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i (2015-03-25 11:50:09 -0700)

----------------------------------------------------------------
Allwinner DT additions for 4.1, take 1

All the device tree related changes for the 4.1 merge window.

It has a rather big diffstat, because of a lot of mechanical and harmless
changes, as described below.

There is mostly:
  - The end of the DT relicensing. All our DT should now be under the dual
    X11/GPL license.
  - Convertion of all the DT to a label based syntax, instead of duplicating
    the tree like was done before.
  - Rework of the A10s and A13 DTSI to share the common devices
  - A few drivers enablings: A80 USB, the A31 PMIC, A31 and A23 arch timers, etc.
  - A few new boards : cubieboard4, mele i7, utoo p66, auxtex t004, pcduino3
    nano, gemei G9

----------------------------------------------------------------
Adam Sampson (1):
      ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board

Aleksei Mamlin (2):
      ARM: dts: sun7i: Add dts file for Wexler TAB7200
      dt-bindings: Add vendor-prefix for Wexler

Boris BREZILLON (1):
      ARM: dts: sun6i: add p2wi controller node to dtsi

Chen-Yu Tsai (14):
      ARM: dts: sun9i: Add usb clock nodes to a80 dtsi
      ARM: dts: sun9i: Add usb phy nodes to a80 dtsi
      ARM: dts: sun9i: Add USB host controller nodes to a80 dtsi
      ARM: dts: sun9i: Enable USB support on A80 Optimus board
      ARM: dts: sun6i: hummingbird: Enable IR receiver
      ARM: dts: sun6i: hummingbird: Enable P2WI controller
      ARM: dts: sun6i: hummingbird: Add AXP221 PMIC device node
      ARM: dts: sun6i: hummingbird: Add AXP221 regulator nodes
      ARM: dts: sun6i: Add pinmux settings for mmc1 to dtsi
      ARM: dts: sun6i: hummingbird: Enable the onboard WiFi module
      ARM: dts: sun8i: Enable ARM architected timer on A23
      ARM: dts: sun9i: Enable ARM architected timer on A80
      ARM: dts: sun9i: optimus: Switch to phy core regulator bindings for usb phys
      ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i

Hans de Goede (9):
      ARM: dts: sun4i: Enable tablet keys on Chuwi V7 CW0825
      ARM: dts: sun5i: Stop using different compatibles for ehci/ohci on a13 vs a10s
      ARM: dts: sun5i: Add mmc2 pinmux settings
      ARM: dts: sun5i: Add new Auxtek-t004 board
      ARM: dts: sun5i: Add new Utoo P66 board
      ARM: dts: sunxi: Adjust touchscreen compatible for sun5i and later
      ARM: dts: sunxi: Add address- and size-cells properties to the mmc ctrl nodes
      ARM: dts: sun7i: Add OOB irq support to boards with broadcom sdio wifi
      ARM: dts: sun6i: csq cs908 dts cleanup

Marcus Cooper (1):
      ARM: sun6i: dt: Add new Mele I7 device

Maxime Ripard (36):
      ARM: sun4i: Relicense the A10 DTSI under GPLv2/X11
      ARM: sun5i: Relicense the A10s/A13 DTSI under GPLv2/X11
      ARM: sun7i: hummingbird: Relicense the device tree under GPLv2/X11
      ARM: sun7i: olinuxino micro: Relicense the device tree under GPLv2/X11
      ARM: sun5i: Add a DTSI common to A10s and A13
      ARM: sun5i: a13: Move to the common sun5i DTSI
      ARM: sun5i: a10s: Move to the common sun5i DTSI
      ARM: sun4i: a1000: Convert to DT label based syntax
      ARM: sun4i: ba10 tvbox: Convert to DT label based syntax
      ARM: sun4i: cubieboard: Convert to DT label based syntax
      ARM: sun4i: hackberry: Convert to DT label based syntax
      ARM: sun4i: inet97fv2: Convert to DT label based syntax
      ARM: sun4i: mini xplus: Convert to DT label based syntax
      ARM: sun4i: olinuxino lime: Convert to DT label based syntax
      ARM: sun4i: pcduino: Convert to DT label based syntax
      ARM: sun5i: a10s: olinuxino micro: Convert to DT label based syntax
      ARM: sun5i: a10s: r7 tv dongle: Convert to DT label based syntax
      ARM: sun5i: a13: hsg h702: Convert to DT label based syntax
      ARM: sun5i: a13: olinuxino micro: Convert to DT label based syntax
      ARM: sun5i: a13: olinuxino: Convert to DT label based syntax
      ARM: sun6i: app4 evb1: Convert to DT label based syntax
      ARM: sun6i: colombus: Convert to DT label based syntax
      ARM: sun6i: m9: Convert to DT label based syntax
      ARM: sun7i: bananapi: Convert to DT label based syntax
      ARM: sun7i: cubieboard2: Convert to DT label based syntax
      ARM: sun7i: cubietruck: Convert to DT label based syntax
      ARM: sun7i: hummingbird: Convert to DT label based syntax
      ARM: sun7i: i12 tvbox: Convert to DT label based syntax
      ARM: sun7i: m3: Convert to DT label based syntax
      ARM: sun7i: olinuxino lime: Convert to DT label based syntax
      ARM: sun7i: olinuxino lime2: Convert to DT label based syntax
      ARM: sun7i: olinuxino micro: Convert to DT label based syntax
      ARM: sun7i: pcduino3: Convert to DT label based syntax
      ARM: sun8i: ippo q8h v5: Convert to DT label based syntax
      ARM: sunxi: DT: Add stdout-path property
      Merge branch 'sunxi/clocks-for-4.1' into sunxi/dt-for-4.1

Priit Laes (1):
      ARM: dts: sun4i: Add initial dts for Gemei G9 tablet

Tyler Baker (2):
      ARM: dts: add vendor prefix for cubietech
      ARM: dts: add cubietech cubieboard4

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |  19 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts              | 202 +++----
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         | 176 +++---
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  35 ++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         | 216 +++----
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           | 176 ++++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          | 191 +++----
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   8 +
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          | 118 ++--
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   8 +
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         | 144 ++---
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   8 +
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |   8 +
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     | 194 +++----
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            | 180 +++---
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  54 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       | 159 ++++++
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |   8 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   | 319 +++++------
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      | 134 ++---
 arch/arm/boot/dts/sun5i-a10s.dtsi                  | 620 +++------------------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           | 138 ++---
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    | 150 ++---
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          | 240 ++++----
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           | 203 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 596 +++-----------------
 arch/arm/boot/dts/sun5i.dtsi                       | 583 +++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |  58 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           | 140 ++---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        | 103 +++-
 arch/arm/boot/dts/sun6i-a31-i7.dts                 | 154 +++++
 arch/arm/boot/dts/sun6i-a31-m9.dts                 | 154 ++---
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  37 ++
 arch/arm/boot/dts/sun6i-a31s-cs908.dts             |  43 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           | 264 ++++-----
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |  10 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        | 200 +++----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         | 326 +++++------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        | 430 +++++++-------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          | 262 ++++-----
 arch/arm/boot/dts/sun7i-a20-m3.dts                 | 186 ++++---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     | 192 +++----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    | 296 +++++-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    | 414 +++++++-------
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      | 199 +++++++
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           | 212 +++----
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     | 188 +++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  23 +-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        | 112 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  16 +
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  99 ++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  67 ++-
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 132 +++++
 54 files changed, 5371 insertions(+), 3835 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
 create mode 100644 arch/arm/boot/dts/sun5i.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31-i7.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
 create mode 100644 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/f3f492d8/attachment.sig>
