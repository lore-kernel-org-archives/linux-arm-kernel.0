From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jun 2017 21:48:15 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.13
Message-ID: <20170614194815.on43pqxdocd76jvc@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our usual PR for the arm DT we have.

Thanks!
Maxime

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.13

for you to fetch changes up to d5e9edfd37fc32098349b7753637bc1c80a16003:

  ARM: sun6i: a31s: primo81: Enable battery power supply (2017-06-14 21:27:19 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.13

The usual chunk of patches. The most notable improvements are the power
supplies improvements (battery and AC-IN), crypto support for the sun5i
family, HDMI support for the A10s, plus a lot of new things for the V3S and
the A83T.

----------------------------------------------------------------
Antoine Tenart (2):
      ARM: sun5i: add a cryptographic engine node
      ARM: dts: sunxi: add SoC specific compatibles for the crypto nodes

Chen-Yu Tsai (26):
      ARM: sun8i: a83t: Drop skeleton.dtsi
      ARM: sun8i: a83t: Rename pinmux setting names
      ARM: sunxi: common-regulators: Drop pinmux settings for GPIO pins
      ARM: sunxi: Drop mmc0_cd_pin_reference_design pinmux setting
      ARM: sun8i: h3: orangepi-pc: Enable USB OTG
      ARM: sun8i: h3: bananapi-m2-plus: Enable USB OTG
      ARM: dts: sun6i: Add second display pipeline device nodes
      ARM: dts: sun6i: Enable tcon0 by default
      ARM: sun8i: a83t: Drop leading zeroes from device node addresses
      ARM: sun8i: a83t: Replace underscores with hyphens in pinmux node names
      ARM: sun8i: a83t: Add CCU device nodes
      ARM: sun8i: a83t: Set clock accuracy for 24MHz oscillator
      ARM: sun8i: a83t: Add device node for DMA controller
      ARM: sun8i: a83t: Add device node for SPDIF transmitter
      ARM: sun8i: a83t: cubietruck-plus: Add LED device nodes
      ARM: sun8i: a83t: cubietruck-plus: Enable SPDIF output
      ARM: sun7i: a20: cubieboard2: Move usb_otg node for alphabetical ordering
      ARM: sun7i: a20: cubieboard2: Enable AXP209's ACIN power supply
      ARM: sun7i: a20: bananapi-m1-plus: Enable AXP209's ACIN power supply
      ARM: sun4i: a10: cubieboard: Enable AXP209's ACIN power supply
      ARM: sun6i: a31: hummingbird: Enable AXP221's ACIN power supply
      ARM: sun7i: a20: cubietruck: Tie AXP209's USB power supply to USB PHY
      ARM: sun8i: a83t: Add device node for PRCM
      ARM: sun8i: a83t: Add device node for R_PIO
      ARM: sun6i: a31s: primo81: Change USB OTG to OTG mode
      ARM: sun6i: a31s: primo81: Enable battery power supply

Corentin Labbe (1):
      ARM: sun8i: a83t: Add dt node for the syscon control module

Fabio Estevam (1):
      ARM: dts: sunxi: Fix BCM43xx node name

Icenowy Zheng (6):
      ARM: sun8i: v3s: restore the usage of CCU definitions
      ARM: sun8i: v3s: add LRADC device node
      ARM: sun8i: v3s: add pinmux for mmc1
      ARM: sun8i: v3s: add support for Lichee Pi Zero w/ dock board
      ARM: sun8i: v3s: enable SPI
      ARM: sun8i: v3s: add device nodes for DE2 display pipeline

Jagan Teki (1):
      ARM: dts: sun8i: h3: Add initial NanoPi M1 Plus support

Marcus Cooper (1):
      ARM: dts: sun8i-h3: orange-pi-2: Enable audio codec

Maxime Ripard (2):
      ARM: sun5i: a10s: Add the HDMI controller node
      ARM: sun5i: a10s-olinuxino: Enable HDMI

Oleksij Rempel (1):
      arm: dts: sun7i-a20-bananapi: name the GPIO lines

Quentin Schulz (4):
      ARM: dtsi: axp209: add battery power supply subnode
      ARM: dtsi: axp22x: add battery power supply subnode
      ARM: dts: sun8i: sina33: enable battery power supply subnode
      ARM: sun5i: chip: enable battery power supply subnode

Sergey Matyukevich (1):
      ARM: dts: orange-pi-zero: add node for SPI NOR

Viresh Kumar (1):
      ARM: sun8i: Use - instead of @ for DT OPP entries

 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/axp209.dtsi                      |   5 +
 arch/arm/boot/dts/axp22x.dtsi                      |   5 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   2 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |   2 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   6 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |   2 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   2 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   6 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |   2 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |   2 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   2 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |   2 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   2 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |   2 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |   2 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   2 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |   2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   6 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |   8 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |   4 -
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  33 +++-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |   4 -
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  47 ++++++
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |   4 -
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |   5 -
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |   4 -
 arch/arm/boot/dts/sun5i-r8-chip.dts                |   4 +
 arch/arm/boot/dts/sun5i.dtsi                       |  10 ++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  10 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 172 ++++++++++++++++++-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  20 ++-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   2 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |   6 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |  51 ++++++
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |   2 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  14 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   5 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |   2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |   4 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |   2 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |   2 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   8 -
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |   2 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |   2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |   6 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |   4 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   9 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  30 ++--
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |   2 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  50 +++++-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 111 +++++++++++--
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  13 ++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  24 ++-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |  64 +++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  13 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  22 ++-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  96 +++++++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 183 +++++++++++++++++----
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |  30 ----
 72 files changed, 951 insertions(+), 221 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170614/5f7241ee/attachment.sig>
