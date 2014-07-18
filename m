From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Jul 2014 22:50:31 +0200
Subject: [GIT PULL] Allwinner DT additions for 3.17
Message-ID: <20140718205031.GA27834@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are the sunxi DT changes for 3.17.

Thanks!
Maxime

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-3.17

for you to fetch changes up to c220aec2bb793bf5a1fb451fd3e4db87654c5ba5:

  ARM: dts: sun6i: Add Merrii A31 Hummingbird support (2014-07-18 22:40:37 +0200)

----------------------------------------------------------------
Allwinner DT additions for 3.17

Among the few patches that we have so far, there's a few noticeable changes:
  - Introduction of the Allwinner A23 SoC
  - Support for the GMAC on the A31. This is only available so far on the
    boards which bootloader enable the PHY regulator.
  - Addition of the infrared receiver

----------------------------------------------------------------
Alexander Bersenev (3):
      ARM: sunxi: Add pins for IR controller on A20 to dtsi
      ARM: sunxi: Enable IR controller on cubieboard 2 and cubietruck in dts
      ARM: sunxi: Add IR controllers on A20 to dtsi

Carlo Caione (2):
      ARM: dts: sun4i: Add AXP209 support to various boards
      ARM: dts: sun7i: Add AXP209 support to various boards

Chen-Yu Tsai (10):
      ARM: sunxi: Add Allwinner A23 dtsi
      ARM: sun8i: dt: Add Ippo-q8h v5 support
      ARM: dts: sunxi: Add #interrupt-cells to pinctrl nodes
      ARM: sun8i: Add basic clock nodes to the DTSI
      ARM: sun8i: Add reset controller nodes to the DTSI
      ARM: sun8i: Add PRCM clock and reset controller nodes to the DTSI
      ARM: dts: sun6i: Add pin muxing options for GMAC
      ARM: dts: sun6i: Add GMAC clock node to the A31 dtsi
      ARM: dts: sun6i: Add A31 GMAC gigabit ethernet controller node
      ARM: dts: sun6i: Add ethernet alias for GMAC

Hans de Goede (5):
      ARM: dts: sun7i: Rename sun7i-a20-ir to sun4i-a10-ir
      ARM: dts: sun7i: Add ir receiver support to a20-i12-tvbox
      ARM: dts: sun4i: Add new ba10-tvbox board
      ARM: dts: sun4i: Add ir controller nodes and pinmux
      ARM: dts: sun4i: Add ir node to various boards

Maxime Ripard (1):
      ARM: dts: sun6i: Add Merrii A31 Hummingbird support

Zoltan HERPAI (1):
      ARM: dts: sun7i: Add board support for LinkSprite pcDuino V3

 arch/arm/boot/dts/Makefile                      |   7 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |  15 ++
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts      | 110 ++++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |  15 ++
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       |  21 ++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts       |  21 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      |  28 ++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |  15 ++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |   9 +
 arch/arm/boot/dts/sun4i-a10.dtsi                |  34 ++-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |   2 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                |   2 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     | 119 ++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi                |  92 ++++++-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  16 ++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |  16 ++
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       |  22 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  10 +
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        | 173 ++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                |  34 ++-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts     |  30 +++
 arch/arm/boot/dts/sun8i-a23.dtsi                | 343 ++++++++++++++++++++++++
 22 files changed, 1121 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31-hummingbird.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-pcduino3.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/639bc452/attachment.sig>
