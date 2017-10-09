From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Oct 2017 22:22:49 +0200
Subject: [PATCH v2 0/5] sunxi: Cleanup DT warnings for the A10 and A80
Message-ID: <cover.e7363fd7884334063590603c0b0de566f66e0c18.1507580565.git-series.maxime.ripard@free-electrons.com>
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

Changes from v1:
  - Dropped the patches merged
  - Reworked a bit the commit logs
  - Removed the changes to the LDO node names
  - Renamed the PS2 pins names

Maxime Ripard (5):
  ARM: dts: sun4i: Change pinctrl nodes to avoid warning
  ARM: dts: sun4i: Provide default muxing for relevant controllers
  ARM: dts: sun4i: Remove underscores from nodes names
  ARM: dts: sun9i: Change node names to remove underscores
  ARM: dts: sun9i: Change node names to remove underscores

 arch/arm/boot/dts/sun4i-a10-a1000.dts                | 12 +--
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts           | 10 +--
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts      | 14 +---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts           | 20 +---
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts     | 18 +---
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts             |  8 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts            |  8 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts         | 10 +--
 arch/arm/boot/dts/sun4i-a10-inet1.dts                | 16 +---
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts            | 14 +---
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts         | 18 +---
 arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts | 21 ++--
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts           | 10 +--
 arch/arm/boot/dts/sun4i-a10-marsboard.dts            | 18 +---
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts           | 10 +--
 arch/arm/boot/dts/sun4i-a10-mk802.dts                |  4 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts              |  6 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts       | 16 +---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts              | 12 +--
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts     | 18 +---
 arch/arm/boot/dts/sun4i-a10.dtsi                     | 72 +++++++------
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts          |  2 +-
 arch/arm/boot/dts/sun9i-a80-optimus.dts              |  2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                     | 10 +-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi       |  4 +-
 25 files changed, 123 insertions(+), 230 deletions(-)

base-commit: 86f8b2d35966768a0aa666f7ca22a7acd321003d
-- 
git-series 0.9.1
