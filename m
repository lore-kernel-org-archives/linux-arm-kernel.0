From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:35 +0200
Subject: [PATCH 00/20] sunxi: Cleanup DT warnings for the A10 and A80
Message-ID: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've had quite a big number of warnings in our device trees due to some
convention that was added before any kind of warning was introduced, and
went on since.

Some of our newest SoC will not generate any warning but the unavoidable
ones (generic properties with underscores, mostly, like USB OTG dr_mode).

However, most of them just needed some cleanup. Here is a serie that would
clean two of these SoCs (plus one SoC-tree wide change).

This brings down the number of DTC warnings with W=2 from 10482 to 4504,
which is a nice stat, but will obviously need some more work.

Let me know what you think,
Maxime

Maxime Ripard (20):
  ARM: dts: sunxi: Remove leading zeros from unit-addresses
  ARM: dts: axp209: Rename usb_power_supply node to avoid warnings
  ARM: dts: sun4i: Change framebuffer node names to avoid warnings
  ARM: dts: sun4i: Change clock node names to avoid warnings
  ARM: dts: sun4i: Change pinctrl nodes to avoid warning
  ARM: dts: sun4i: Provide default muxing for relevant controllers
  ARM: dts: sun4i: Remove skeleton and memory to avoid warnings
  ARM: dts: sun4i: Change LRADC node names to avoid warnings
  ARM: dts: sun4i: Remove SoC node unit-name to avoid warnings
  ARM: dts: sun4i: Rename thermal nodes to avoid warnings
  ARM: dts: sun4i: Remove all useless pinctrl nodes
  ARM: dts: sun4i: Remove underscores from nodes names
  ARM: dts: sun4i: Remove gpio-keys warnings
  ARM: dts: sun9i: Remove skeleton to avoid warnings
  ARM: dts: sun9i: Rename pinctrl nodes to avoid warnings
  ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid warnings
  ARM: dts: sun9i: optimus: Remove card detect pull-up
  ARM: dts: sun9i: cubieboard4: Remove card detect pull-up
  ARM: dts: sun9i: Change node names to remove underscores
  ARM: dts: sun9i: Change node names to remove underscores

 arch/arm/boot/dts/axp209.dtsi                        |   2 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts                |  28 +--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts           |  16 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts      |  20 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts           |  20 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts     |  50 +---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts             |  23 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts            |  24 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts         |  10 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts                |  36 +--
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts            |  24 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts         |  68 +---
 arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts |  21 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts           |  26 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts            |  25 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts           |  10 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts                |  24 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts              |   6 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts       |  22 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts              |  32 +--
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts             |   9 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts     |  43 +--
 arch/arm/boot/dts/sun4i-a10.dtsi                     | 210 ++++++------
 arch/arm/boot/dts/sun5i-a10s.dtsi                    |   6 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                     |   4 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                     |   8 +-
 arch/arm/boot/dts/sun5i.dtsi                         |  82 ++---
 arch/arm/boot/dts/sun6i-a31.dtsi                     | 112 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi                     | 122 +++----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                 |  62 ++--
 arch/arm/boot/dts/sun8i-a23.dtsi                     |   4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                     |  18 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                     |  32 +-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts          |  36 +--
 arch/arm/boot/dts/sun9i-a80-optimus.dts              |  56 +---
 arch/arm/boot/dts/sun9i-a80.dtsi                     | 117 +++----
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi       |   4 +-
 37 files changed, 525 insertions(+), 887 deletions(-)

base-commit: c27ad2958485126c3828e59d53013d3b45ec14f2
-- 
git-series 0.9.1
