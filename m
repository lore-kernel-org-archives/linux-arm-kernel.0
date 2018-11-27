From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:01 +0100
Subject: [PATCH 00/77] ARM: dts: sunxi: Cleanup DTC warnings
Message-ID: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a (rather big) series that fixes most of our DTC warnings. The
number of warnings when compiled with W=1 after applying this series
goes from 3343 to 23, 21 of them being the same warning, which would
be fixed by the current series adding support for the Cedrus driver on
H3/H5.

The two remaining one are on the A80 and would require some change in
the clock driver. Given how little activity there is on the A80, we
can expect it to not happen in a near future, but I can live with two
warnings.

I also took the occasion to convert all the arm SoCs to our newer
syntax and rules when applicable.

Let me know what you think,
Maxime

Maxime Ripard (77):
  ARM: dts: sun4i: Fix gpio-keys warning
  ARM: dts: sun4i: Fix HDMI output DTC warning
  ARM: dts: sun5i: Change framebuffer node names to avoid warnings
  ARM: dts: sun5i: Fix display pipeline endpoint warnings in DTC
  ARM: dts: sun5i: Change clock node names to avoid warnings
  ARM: dts: sun5i: Remove skeleton to avoid warnings
  ARM: dts: sun5i: Remove SoC node unit-name to avoid warnings
  ARM: dts: sun5i: Remove redundant interrupt-controller
  ARM: dts: sun5i: Change LRADC node names to avoid warnings
  ARM: dts: sun5i: Remove all useless pinctrl nodes
  ARM: dts: sun5i: Remove card detect pull-up
  ARM: dts: sun5i: Change pinctrl nodes to avoid warning
  ARM: dts: sun5i: a10s: Fix HDMI output DTC warning
  ARM: dts: sunxi: Change default CMA pool node name
  ARM: dts: sunxi: Remove the CMA node label
  ARM: dts: sun5i: Remove underscores from nodes names
  ARM: dts: sunxi: Change LRADC node names to avoid warnings
  ARM: dts: sun5i: Fix Display Engine DTC warnings
  ARM: dts: sun5i: A10s: Remove empty SRAM node
  ARM: dts: sun5i: Remove underscores from nodes names
  ARM: dts: sun5i: Provide default muxing for relevant controllers
  ARM: dts: sun6i: Remove skeleton and memory to avoid warnings
  ARM: dts: sun6i: Change framebuffer node names to avoid warnings
  ARM: dts: sun6i: Change clock node names to avoid warnings
  ARM: dts: sun6i: Remove SoC node unit-name to avoid warnings
  ARM: dts: sun6i: Fix Display Engine DTC warnings
  ARM: dts: sun6i: Change LRADC node names to avoid warnings
  ARM: dts: sun6i: Remove all useless pinctrl nodes
  ARM: dts: sun6i: Remove card detect pull-up
  ARM: dts: sun6i: Remove redundant MMC pinmux tuning
  ARM: dts: sun6i: Change pinctrl nodes to avoid warning
  ARM: dts: sun6i: Remove underscores from nodes names
  ARM: dts: sun6i: colombus: Change i2c node name to avoid warnings
  ARM: dts: sun6i: Provide default muxing for relevant controllers
  ARM: dts: sun7i: Remove skeleton and memory to avoid warnings
  ARM: dts: sun7i: Remove SoC node unit-name to avoid warnings
  ARM: dts: sun7i: Change clock node names to avoid warnings
  ARM: dts: sun7i: Change framebuffer node names to avoid warnings
  ARM: dts: sun7i: Remove all useless pinctrl nodes
  ARM: dts: sun7i: Remove card detect pull-up
  ARM: dts: sun7i: Change LRADC node names to avoid warnings
  ARM: dts: sun7i: Remove gpio-keys warnings
  ARM: dts: sun7i: Change pinctrl nodes to avoid warning
  ARM: dts: sun7i: Split the RTS and CTS pins out of the UART nodes
  ARM: dts: sun7i: som204: Use the UART3 TX and RX pin group
  ARM: dts: sun7i: Remove underscores from nodes names
  ARM: dts: sun7i: Fix HDMI output DTC warning
  ARM: dts: sun7i: Provide default muxing for relevant controllers
  ARM: dts: sun7i: Remove redundant MMC pinmux tuning
  ARM: dts: sun7i: lamobo-r1: Remove unused address-cells/size-cells
  ARM: dts: sun8i: a23/a33: Remove skeleton and memory to avoid warnings
  ARM: dts: sun8i: a23/a33: Remove SoC node unit-name to avoid warnings
  ARM: dts: sun8i: a23/a33: Fix Display Engine DTC warnings
  ARM: dts: sun8i: a23/a33: Fix OPP DTC warnings
  ARM: dts: sun8i: a23/a33: Remove unused address-cells/size-cells
  ARM: dts: sun8i: a23/a33: Remove leading zeros from unit-addresses
  ARM: dts: sun8i: a23/a33: Change framebuffer node names to avoid warnings
  ARM: dts: sun8i: a23/a33: Remove redundant MMC pinmux tuning
  ARM: dts: sun8i: a23/a33: Remove all useless pinctrl nodes
  ARM: dts: sun8i: a23/a33: Change LRADC node names to avoid warnings
  ARM: dts: sun8i: a23/a33: Reorder the pin groups
  ARM: dts: sun8i: a23/a33: Remove card detect pull-up
  ARM: dts: sun8i: a23/a33: Change pinctrl nodes to avoid warning
  ARM: dts: sun8i: a23/a33: Remove underscores from nodes names
  ARM: dts: sunxi: reference: Move the muxing back to the common DTSI
  ARM: dts: sun8i: a23/a33: Provide default muxing for relevant controllers
  ARM: dts: sun8i: BPI-M2M: Remove i2c nodes
  ARM: dts: sun8i: h3: Remove leading zeros from unit-addresses
  ARM: dts: sun8i: v3s: Change LRADC node names to avoid warnings
  ARM: dts: sun8i: v3s: Change pinctrl nodes to avoid warning
  ARM: dts: sun8i: v3s: Provide default muxing for relevant controllers
  ARM: dts: sun8i: v3s: Remove skeleton and memory to avoid warnings
  ARM: dts: sun8i: v3s: Fix Display Engine DTC warnings
  ARM: dts: sun8i: a83t: Fix Display Engine DTC warnings
  ARM: dts: sun8i: r40: Fix Display Engine DTC warnings
  ARM: dts: sun9i: Fix Display Engine DTC warnings
  ARM: dts: sun9i: Add missing unit address

 Documentation/devicetree/bindings/media/cedrus.txt       |   2 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts             |   2 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts                  |   2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                         |   2 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts             |  14 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts             |  24 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts                   |  29 +--
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts         |  54 +---
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts            |  20 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts                 |  30 +--
 arch/arm/boot/dts/sun5i-a10s.dtsi                        |  30 +--
 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts   |  24 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts                 |  29 +--
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts             |  14 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts          |  34 +--
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts                |  40 +--
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts                |  10 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts                 |  14 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                         |   6 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts                 |  34 +--
 arch/arm/boot/dts/sun5i-gr8-evb.dts                      |  59 +---
 arch/arm/boot/dts/sun5i-gr8.dtsi                         |  12 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                      |  40 +--
 arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi     |  35 +--
 arch/arm/boot/dts/sun5i.dtsi                             |  93 ++---
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts                |  10 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts                 |  33 +--
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              |  51 +---
 arch/arm/boot/dts/sun6i-a31-i7.dts                       |  32 +--
 arch/arm/boot/dts/sun6i-a31-m9.dts                       |  30 +--
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts         |  30 +--
 arch/arm/boot/dts/sun6i-a31.dtsi                         |  78 +---
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts        |   2 +-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts                   |   6 +-
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts               |   8 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 |  27 +--
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi           |   2 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts                 |  27 +--
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts         |  47 +---
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts |  20 +-
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi     |  10 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts         |  46 +---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts                 |  44 +--
 arch/arm/boot/dts/sun7i-a20-bananapro.dts                |  65 +----
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts              |  21 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts               |  64 +----
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts              |  60 +---
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts                |  47 +---
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts              |  10 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts               |  10 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts                |  48 +---
 arch/arm/boot/dts/sun7i-a20-m3.dts                       |  21 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts                   |  26 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb-emmc.dts      |   2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts           |  68 +----
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb-emmc.dts   |   2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts        |  36 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts           |  22 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts     |  11 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts          |  28 +--
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro-emmc.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts          |  54 +--
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts            |  52 +---
 arch/arm/boot/dts/sun7i-a20-orangepi.dts                 |  44 +--
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts            |  31 +--
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts                 |  39 +--
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts           |  39 +--
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts         |  23 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                         | 144 ++++----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                     |  82 ++---
 arch/arm/boot/dts/sun8i-a23-evb.dts                      |  20 +-
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts                 |   2 +-
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts    |  15 +-
 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts    |  15 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                         |   6 +-
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts               |   4 +-
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts           |  12 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts                |   4 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts           |  36 +--
 arch/arm/boot/dts/sun8i-a33.dtsi                         |  57 +---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                |   3 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                        |  17 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                          |  10 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi                   |   8 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts             |  33 +--
 arch/arm/boot/dts/sun8i-r16-nintendo-nes-classic.dts     |   2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts                   |  46 +---
 arch/arm/boot/dts/sun8i-r40.dtsi                         |   5 +-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi     |  17 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts       |   8 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts            |   4 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                         |  22 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts              |  15 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                         |  66 +----
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi           |   2 +-
 arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi     |  10 +-
 96 files changed, 599 insertions(+), 2047 deletions(-)

base-commit: 814a053bbbdb23039a22ddbaf781e8d5744d0e32
-- 
git-series 0.9.1
