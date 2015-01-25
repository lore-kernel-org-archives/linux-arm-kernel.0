From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 Jan 2015 18:43:32 +0100
Subject: [GIT PULL] Allwinner DT changes for 3.20
Message-ID: <20150125174332.GA27481@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are the dt changes for the Allwinner boards for the 3.20 merge window.

Please note that this is based on the fixes branch I sent a pull
request for earlier to avoid conflicts on the simplefb nodes.

Thanks!
Maxime

The following changes since commit 8cedd6628472aa2d8f2f54dfcc36633e46a59db8:

  ARM: dts: sun4i: Add simplefb node with de_fe0-de_be0-lcd0-hdmi pipeline (2015-01-21 09:56:35 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-3.20

for you to fetch changes up to c121f45e6291e00c71b919ce4a439e0b6e829668:

  ARM: dts: sun5i: Enable axp209 support on A13-OLinuxIno (2015-01-25 17:08:41 +0100)

----------------------------------------------------------------
Allwinner device tree changes for 3.20

A lot of changes to the device tree for the 3.20 merge window, mostly with:
  - More DT license convertions, only two DTS and two DTSI are still uncertain
    and have not been converted yet
  - Use the C-preprocessor includes in the device trees.
  - Add support for the A31s SoC and improve the A80 support
  - Add IR receiver, lradc, PS/2 support
  - Add cpufreq support for all SoCs but the A23 and A80.
  - And a lot of new boards

----------------------------------------------------------------
Aleksei Mamlin (2):
      ARM: dts: sunxi: Add missing mdio label
      ARM: dts: sun4i: Add Marsboard A10 board

Alexandru Gagniuc (2):
      ARM: sun4i: dt: Add pin muxing options for SPI
      ARM: sun4i: dt: cubieboard: Enable SPI0

Chen-Yu Tsai (25):
      ARM: dts: sun6i: hummingbird: Add ethernet phy reset gpio properties
      ARM: dts: sunxi: Enable thermal sensor support for RTP on sun[457]i
      ARM: dts: sun7i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sun5i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sun4i: Add cpu clock reference and operating points to dtsi
      ARM: dts: sunxi: Add dtsi for AXP209 PMIC
      ARM: dts: sun7i: Add cpu thermal zones to dtsi
      ARM: dts: sun5i: Add cpu thermal zones to dtsi
      ARM: dts: sun4i: Add cpu thermal zones to dtsi
      ARM: dts: sun7i: cubieboard2: add axp209 regulator nodes
      ARM: dts: sun7i: cubietruck: add axp209 regulator nodes
      ARM: dts: sun5i: hsg-h702: add axp209 regulator nodes
      ARM: dts: sun4i: cubieboard: add axp209 regulator nodes
      ARM: dts: sun9i: Add mmc module clock nodes for A80
      ARM: dts: sun9i: Add clock-indices property for bus gate clocks
      ARM: dts: sunxi: Use label to reference pio in sunxi-common-regulators
      ARM: dts: sun9i: Add pinmux setting for mmc0
      ARM: dts: sun6i: Convert hummingbird a31 dts to label references
      ARM: dts: sun9i: Add mmc config clock nodes
      ARM: dts: sun9i: Add mmc controller nodes to the A80 dtsi
      ARM: dts: sun9i: Convert a80 optimus board dts to label referencing
      ARM: dts: sun9i: Enable mmc0 on A80 Optimus Board
      ARM: dts: sun9i: Add 8 bit mmc pinmux setting for mmc2
      ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board
      ARM: dts: sun6i: Add resistive touchscreen controller node to dtsi

Hans de Goede (20):
      ARM: dts: sun6i: Add pinmux settings for the ir pins
      ARM: dts: sun6i: Add ir_clk node
      ARM: dts: sun6i: Add ir node
      ARM: dts: sun6i: Enable ir receiver on the Mele M9
      ARM: dts: sun4i: Add lradc node
      ARM: dts: sun5i: Add lradc node
      ARM: dts: sun7i: Add lradc node
      ARM: dts: sun6i: Add sun6i-a31s.dtsi
      ARM: dts: sun6i: Add dts file for CSQ CS908 board
      ARM: dts: sunxi: Add simplefb nodes for de_be0-lcd0, de_be0-lcd0-tve0 pipelines
      ARM: dts: sun8i: Add lradc node to sun8i-a23.dtsi
      ARM: dts: sun8i: Enable lradc on a23-ippo-q8h-v5
      ARM: dts: sun8i: Add dts file for Ippo Q8H v1.2 tablets
      ARM: dts: sun7i: Add dts file for Bananapro board
      ARM: dts: sun4i: Add dts file for Chuwi V7 CW0825 tablet
      ARM: dts: sun4i: Add mk802 board
      ARM: dts: sun4i: Add mk802ii board
      ARM: dts: sun5i: Add mk802_a10s board
      ARM: dts: sun4i: Add Hyundau A7HD board
      ARM: dts: sun5i: Enable axp209 support on A13-OLinuxIno

Maxime Ripard (9):
      ARM: sunxi: DT: Convert to device tree includes
      ARM: sunxi: DT: convert DTs to use common GPIOs includes
      ARM: sunxi: DT: Convert the DTs to use a header for the DMA arguments
      ARM: sunxi: DT: Convert the DTs to use a header for the pinctrl nodes
      ARM: sunxi: DT: Convert the DTs to use the GIC headers
      ARM: sunxi: DT: Convert the DTs to use the generic interrupt header
      ARM: sun7i: cubieboard2: Relicense the device tree under GPLv2/X11
      ARM: sun7i: cubietruck: Relicense the device tree under GPLv2/X11
      ARM: sun6i: Enable ARM arch timers

Vishnu Patekar (2):
      ARM: sunxi: dts: Add PS2 nodes to dtsi for A10,A20
      ARM: sunxi: dts: Add A10/A20 PS2 pin muxing options

Zoltan HERPAI (1):
      ARM: dts: pcduino: Enable user LED and button support for pcDuino

 arch/arm/boot/dts/Makefile                       |  13 +-
 arch/arm/boot/dts/axp209.dtsi                    |  97 +++++++
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |  23 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |  10 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts  | 100 +++++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  58 +++-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  21 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts     | 105 +++++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |   8 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        | 183 ++++++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  11 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts            | 109 +++++++
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts          | 113 ++++++++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  21 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  68 ++++-
 arch/arm/boot/dts/sun4i-a10.dtsi                 | 204 ++++++++++---
 arch/arm/boot/dts/sun5i-a10s-mk802.dts           | 125 ++++++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  72 ++++-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    |  25 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  68 +++--
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  59 +++-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  25 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  75 ++++-
 arch/arm/boot/dts/sun5i-a13.dtsi                 | 112 ++++++--
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  13 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  21 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      | 185 ++++++------
 arch/arm/boot/dts/sun6i-a31-m9.dts               |  31 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                 | 182 +++++++-----
 arch/arm/boot/dts/sun6i-a31s-cs908.dts           | 104 +++++++
 arch/arm/boot/dts/sun6i-a31s.dtsi                |  58 ++++
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  28 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts        | 262 +++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 101 +++++--
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       | 125 ++++++--
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  38 +--
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts        |  40 +--
 arch/arm/boot/dts/sun7i-a20-m3.dts               |  18 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts   |  24 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts  |  24 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  79 +++++-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts         |  21 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                 | 347 +++++++++++++++--------
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts    |  59 ++++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  33 ++-
 arch/arm/boot/dts/sun8i-a23.dtsi                 | 100 ++++---
 arch/arm/boot/dts/sun9i-a80-optimus.dts          | 112 +++++---
 arch/arm/boot/dts/sun9i-a80.dtsi                 | 192 ++++++++++---
 arch/arm/boot/dts/sunxi-common-regulators.dtsi   |  65 ++---
 include/dt-bindings/dma/sun4i-a10.h              |  56 ++++
 include/dt-bindings/pinctrl/sun4i-a10.h          |  62 ++++
 51 files changed, 3312 insertions(+), 773 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp209.dtsi
 create mode 100644 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-marsboard.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mk802ii.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-mk802.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-cs908.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapro.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
 create mode 100644 include/dt-bindings/dma/sun4i-a10.h
 create mode 100644 include/dt-bindings/pinctrl/sun4i-a10.h

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150125/d8612c00/attachment.sig>
