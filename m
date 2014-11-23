From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 23 Nov 2014 17:34:13 +0100
Subject: [GIT PULL] Allwinner DT for 3.19, bis
Message-ID: <20141123163413.GA5585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

Here is the DT pull request for the Allwinner changes that replaces
the previous one.

The patch that was breaking the arm-soc boot has been dropped, and
will go through the clock tree.

Thanks,
Maxime

The following changes since commit 532425a7a7738b479406496ca4ad6b3247688e44:

  ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required by dma controller (2014-11-08 15:56:36 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-3.19-bis

for you to fetch changes up to 109588fd214c930ce6561997250f0eea456a8f7b:

  ARM: dts: sun6i: Add ethernet support to M9 board (2014-11-23 17:00:25 +0100)

----------------------------------------------------------------
Allwinner Device Tree Changes for 3.19

A lot of things happened during that merge window, but mostly:
  - Preliminary Support for the A80
  - New Boards Support
    + Mele M3
    + Banana Pi
    + Optimus
    + OLinuXino Lime2
  - Device Tree Relicensing to GPLv2/X11 dual license

----------------------------------------------------------------
Chen-Yu Tsai (10):
      ARM: dts: sunxi: Add Allwinner A80 dtsi
      ARM: dts: sun9i: Add A80 Optimus Board support
      ARM: dts: sun9i: Add basic clocks and reset controls
      ARM: dts: sun9i: Add i2c controller nodes to a80 dtsi
      ARM: dts: sun9i: Add i2c3 pinmux setting for A80 SoC
      ARM: dts: sun9i: Enable i2c3 on A80 Optimus board
      ARM: dts: sun9i: Add GPIO LEDs for A80 Optimus board
      ARM: dts: sun9i: Add uart4 pinmux setting for A80 SoC
      ARM: dts: sun9i: Enable uart4 for A80 Optimus board
      ARM: sun6i: DT: Add PLL6 multiple outputs

Hans de Goede (9):
      ARM: dts: sun7i: Add spi0_pins_a pinctrl setting
      ARM: dts: sun7i: Add uart3_pins_b pinctrl setting
      ARM: dts: sun7i: Add Banana Pi board
      ARM: dts: sun7i: Add mmc2_pins_a pinctrl definition
      ARM: dts: sun7i: Add Mele M3 board
      ARM: dts: sunxi: Add regulator-boot-on property to ahci-5v regulator
      ARM: dts: sun6i: Add EHCI support for the M9 board
      ARM: dts: sun6i: Add support for the status led
      ARM: dts: sun6i: Add ethernet support to M9 board

Iain Paton (1):
      ARM: sun7i: add support for A20-OLinuXino-Lime2

Karsten Merker (1):
      ARM: dts: sunxi: Banana Pi: increase startup-delay for the GMAC PHY regulator

Maxime Ripard (24):
      ARM: sunxi: regulators: Relicense the device tree under GPLv2/X11
      ARM: sun4i: ba10: Relicense the device tree under GPLv2/X11
      ARM: sun4i: hackberry: Relicense the device tree under GPLv2/X11
      ARM: sun4i: inet97fv2: Relicense the device tree under GPLv2/X11
      ARM: sun4i: mini xplus: Relicense the device tree under GPLv2/X11
      ARM: sun4i: olinuxino lime: Relicense the device tree under GPLv2/X11
      ARM: sun5i: olinuxino micro: Relicense the device tree under GPLv2/X11
      ARM: sun5i: r7: Relicense the device tree under GPLv2/X11
      ARM: sun5i: olinuxino micro: Relicense the device tree under GPLv2/X11
      ARM: sun6i: colombus: Relicense the device tree under GPLv2/X11
      ARM: sun6i: hummingbird: Relicense the device tree under GPLv2/X11
      ARM: sun6i: m9: Relicense the device tree under GPLv2/X11
      ARM: sun7i: i12: Relicense the device tree under GPLv2/X11
      ARM: sun8i: q8h: Relicense the device tree under GPLv2/X11
      ARM: sun6i: app4: Relicense the device tree under GPLv2/X11
      ARM: sunxi: Fix GPLv2 wording
      ARM: sun4i: a1000: Relicense the device tree under GPLv2/X11
      ARM: sun9i: Enable the A80 pinctrl driver
      ARM: sun9i: optimus: Set UART0 muxing
      ARM: sun7i: olinuxino lime: Relicense the device tree under GPLv2/X11
      ARM: sun4i: pcduino: Relicense the device tree under GPLv2/X11
      ARM: sun7i: pcduino3: Relicense the device tree under GPLv2/X11
      ARM: sun4i: cubieboard: Relicense the device tree under GPLv2/X11
      ARM: sun5i: olinuxino: Relicense the device tree under GPLv2/X11

Roman Byshko (4):
      ARM: dtsi: sunxi: add common VBUS regulator
      ARM: sun7i: dtsi: add support for usbphy0
      ARM: dts: sun7i: Cubietruck: override regulator pin
      ARM: dts: sun7i: Cubietruck: add power supply regulator for USB OTG VBUS

 arch/arm/boot/dts/Makefile                       |   5 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |  46 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  46 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  46 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  46 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  46 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  46 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  46 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  46 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  46 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    |  46 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |   6 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  48 ++-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  46 +-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  46 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  46 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  46 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts               | 103 ++++-
 arch/arm/boot/dts/sun6i-a31.dtsi                 |  34 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         | 214 ++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |  14 +
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        |  46 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts               | 168 ++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   |  46 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  | 228 ++++++++++
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         |  46 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  31 +-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  46 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                 |   6 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts          | 119 ++++++
 arch/arm/boot/dts/sun9i-a80.dtsi                 | 514 +++++++++++++++++++++++
 arch/arm/boot/dts/sunxi-common-regulators.dtsi   |  66 ++-
 32 files changed, 2249 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-m3.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
 create mode 100644 arch/arm/boot/dts/sun9i-a80-optimus.dts
 create mode 100644 arch/arm/boot/dts/sun9i-a80.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141123/a7629cf4/attachment.sig>
