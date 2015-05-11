From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 11 May 2015 21:31:38 +0200
Subject: [GIT PULL] Allwinner device tree changes for 4.2
Message-ID: <20150511193138.GA29442@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the first pull request for the 4.2 merge window.

This is mostly what has not been merged during the previous merge
window, plus a few additional patches that got merged since.

Thanks!
Maxime

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.2

for you to fetch changes up to f3022c6ca06e0b8d8e77c94da1af5f41210e52ba:

  ARM: sunxi: dt: Split the SPI pinctrl groups (2015-05-10 10:23:56 +0200)

----------------------------------------------------------------
Allwinner DT additions for 4.1, take 1

All the device tree related changes for the 4.1 merge window.

It has a rather big diffstat, because of a lot of mechanical and harmless
changes, as described below.

There is mostly:
  - The end of the DT relicensing. All our DT should now be under the dual
    X11/GPL license.
  - Convertion of all the DT to a label based syntax, instead of
    duplicating the tree like was done before.
  - Rework of the A10s and A13 DTSI to share the common devices
  - A few drivers enablings: A80 USB, the A31 PMIC, A31 and A23 arch
    timers, etc
  - Fix the checkpatch warnings
  - A few new boards : cubieboard4, mele i7, utoo p66, auxtex t004,
    pcduino3 nano, gemei G9, mk808c, jesurun q5, orange pi, orange pi mini

----------------------------------------------------------------
Adam Sampson (1):
      ARM: dts: sun7i: Add dts file for pcDuino 3 Nano board

Aleksei Mamlin (2):
      ARM: dts: sun7i: Add dts file for Wexler TAB7200
      dt-bindings: Add vendor-prefix for Wexler

Boris BREZILLON (1):
      ARM: dts: sun6i: add p2wi controller node to dtsi

Chen-Yu Tsai (18):
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
      ARM: dts: sun6i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sun6i: Add cpu thermal zones to dtsi
      ARM: sun8i: dt: Enable A23 SMP support
      ARM: dts: sunxi: Update ahb clocks for sun5i and sun7i
      ARM: dts: sun6i: Set PLL6 as parent to AHB1 clock in AHB1 clock node

Hans de Goede (16):
      ARM: dts: sun4i: Enable tablet keys on Chuwi V7 CW0825
      ARM: dts: sun5i: Stop using different compatibles for ehci/ohci on a13 vs a10s
      ARM: dts: sun5i: Add mmc2 pinmux settings
      ARM: dts: sun5i: Add new Auxtek-t004 board
      ARM: dts: sun5i: Add new Utoo P66 board
      ARM: dts: sunxi: Adjust touchscreen compatible for sun5i and later
      ARM: dts: sunxi: Add address- and size-cells properties to the mmc ctrl nodes
      ARM: dts: sun7i: Add OOB irq support to boards with broadcom sdio wifi
      ARM: dts: sun6i: csq cs908 dts cleanup
      ARM: dts: sun5i: Add broken-hpi property for Utoo-P66 eMMC
      ARM: dts: sun4i: Add A10 SRAM and SRAM controller
      ARM: dts: sun5i: Add A13 and A10s SRAM and SRAM controller
      ARM: dts: sun7i: Add dts file for the Orangepi SBC
      ARM: dts: sun7i: Add dts file for the Orangepi mini SBC
      ARM: dts: sun5i: Enable touchscreen on Utoo P66
      ARM: dts: sun7i: Add dts file for the Jesurun Q5 top set box

Marcus Cooper (3):
      ARM: sun6i: dt: Add new Mele I7 device
      ARM: sun7i: dt: Add new MK808C device
      ARM: sunxi: dts: split IR pins for A10 and A20

Maxime Ripard (40):
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
      ARM: dts: sun7i: Add A20 SRAM and SRAM controller
      ARM: sunxi: dt: Remove the FSF address
      ARM: sunxi: DT: Fix lines over 80 characters
      ARM: sunxi: dt: Fix whitespace errors
      ARM: sunxi: dt: Split the SPI pinctrl groups

Priit Laes (1):
      ARM: dts: sun4i: Add initial dts for Gemei G9 tablet

Tyler Baker (2):
      ARM: dts: add vendor prefix for cubietech
      ARM: dts: add cubietech cubieboard4

 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |  23 +-
 arch/arm/boot/dts/axp209.dtsi                      |   5 -
 arch/arm/boot/dts/sun4i-a10-a1000.dts              | 207 +++----
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         | 181 +++---
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  40 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         | 222 +++----
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           | 171 ++++++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          | 196 +++----
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |  13 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          | 123 ++--
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         | 189 ++++++
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |  16 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         | 149 +++--
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |  13 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |  13 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     | 224 ++++---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            | 185 +++---
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 163 +++++-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       | 154 +++++
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |  13 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   | 324 ++++++-----
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      | 139 ++---
 arch/arm/boot/dts/sun5i-a10s.dtsi                  | 642 +++------------------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           | 143 +++--
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    | 155 +++--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          | 245 ++++----
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           | 226 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 608 +++----------------
 arch/arm/boot/dts/sun5i.dtsi                       | 613 ++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |  63 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           | 145 +++--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        | 108 +++-
 arch/arm/boot/dts/sun6i-a31-i7.dts                 | 149 +++++
 arch/arm/boot/dts/sun6i-a31-m9.dts                 | 159 +++--
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 133 ++++-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts             |  48 +-
 arch/arm/boot/dts/sun6i-a31s.dtsi                  |   5 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           | 271 +++++----
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |  21 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        | 205 +++----
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         | 331 +++++------
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        | 426 +++++++-------
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          | 267 ++++-----
 arch/arm/boot/dts/sun7i-a20-m3.dts                 | 191 +++---
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             | 148 +++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     | 197 +++----
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    | 301 +++++-----
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    | 411 +++++++------
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      | 250 ++++++++
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           | 228 ++++++++
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      | 194 +++++++
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           | 217 +++----
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     | 183 ++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 186 ++++--
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts      |   5 -
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        | 117 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  33 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  99 ++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  72 ++-
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 139 ++++-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |   5 -
 62 files changed, 6553 insertions(+), 4151 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
 create mode 100644 arch/arm/boot/dts/sun5i.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31-i7.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-mk808c.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-orangepi.dts
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/9713459b/attachment.sig>
