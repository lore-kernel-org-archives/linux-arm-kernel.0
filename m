From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Apr 2017 13:09:15 +0800
Subject: [PATCH 0/4] ARM: sunxi: device tree pinctrl clean up and H3 OTG
Message-ID: <20170419050919.6762-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series has 2 parts. The parts are largely unrelated, though the
second part should be applied after the first part, so we don't
accidentally mux pins that we shouldn't. Hence I'm sending them
together.

The first 2 patches clean up the sunxi device tree files, removing
pinmux settings for common GPIO pins. These include the enable pins
for the common regulators, and the mmc0 card detect pin from the
reference designs.

The second part, the latter 2 patches, enable USB OTG on the Orangepi
PC, PC Plus, Plus 2E, and the Bananapi M2+. The first 3 boards are
bunched together, due to how the PC Plus and Plus 2E device trees include
the device tree of the Opi PC.

Regards
ChenYu

Chen-Yu Tsai (4):
  ARM: sunxi: common-regulators: Drop pinmux settings for GPIO pins
  ARM: sunxi: Drop mmc0_cd_pin_reference_design pinmux setting
  ARM: sun8i: h3: orangepi-pc: Enable USB OTG
  ARM: sun8i: h3: bananapi-m2-plus: Enable USB OTG

 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  2 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |  2 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  2 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  2 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |  2 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |  2 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |  6 +----
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |  2 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |  2 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |  2 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |  2 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |  2 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |  2 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |  2 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |  2 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |  2 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  2 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |  2 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |  2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  6 -----
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |  8 ------
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  4 ---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  4 ---
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |  4 ---
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  4 ---
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |  5 ----
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  4 ---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  5 ----
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  2 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  2 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |  2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |  2 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |  2 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |  2 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  8 ------
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |  2 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |  2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |  2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |  2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |  6 +----
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  2 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  6 -----
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 22 +++++++++++++++-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  4 ---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 22 +++++++++++++++-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     | 30 ----------------------
 51 files changed, 78 insertions(+), 138 deletions(-)

-- 
2.11.0
