From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 Jan 2017 09:56:26 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.11
Message-ID: <20170131085626.tg4a6rinnwfze6eq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 1edcd36fcb48fe841bcc62eda36c105037d9583c:

  ARM: sunxi: Convert pinctrl nodes to generic bindings (2016-12-26 08:27:11 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.11

for you to fetch changes up to ef09e0f539f124c67aa44d4154730bc8492196bf:

  ARM: dts: sun8i-h3: Add SPDIF to the Beelink X2 (2017-01-27 21:09:58 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.11

The usual chunk of DT changes, most notably:
  - Support for the H2+ and the V3s
  - CPUFreq support for the A33
  - SPDIF support for the A31 and H3
  - New boards: Beelink X2, Lichee Pi One, Lichee Pi Zero,
    Orange Pi Zero

----------------------------------------------------------------
Chen-Yu Tsai (8):
      ARM: dts: sunxi: Explicitly enable pull-ups for MMC pins
      ARM: dts: sun6i: hummingbird: Enable USB OTG
      ARM: dts: sun8i: Add codec analog path controls node in PRCM for A23/A33
      ARM: dts: sun8i-a23: Add device node for internal audio codec
      ARM: dts: sun8i-a23: q8-tablet: Enable internal audio codec
      ARM: dts: sun8i-h3: Add device nodes for audio codec and its analog controls
      ARM: dts: sun8i-h3: orange-pi-pc: Enable audio codec
      ARM: dts: sun6i: sina31s: Enable USB OTG controller in peripheral mode

Emmanuel Vadot (3):
      ARM: dts: sunxi: Use axp209.dtsi for Olinuxino Lime2
      ARM: dts: sunxi: Add num-cs for A20 spi nodes
      ARM: dts: sunxi: Enable UEXT related nodes for Olimex A20 SOM EVB

Icenowy Zheng (11):
      ARM: dts: sunxi: add support for Orange Pi Zero board
      ARM: dts: sun8i: add a cpu0 label to cpu at 0 node on A23/33
      ARM: dts: sun8i: set cpu-supply in reference tablet DTSI
      ARM: dts: sun8i: add opp-v2 table for A33
      ARM: dts: sun8i: add a delay after reset xr819 on Orange Pi Zero
      ARM: dts: sun5i: add a pinctrl node for 4bit mmc2
      dt-bindings: add vendor prefix for Lichee Pi
      ARM: dts: sun5i: add support for Lichee Pi One board
      devicetree: bindings: Add vendor prefix for Shenzhen Xunlong Software
      ARM: dts: sunxi: add dtsi file for V3s SoC
      ARM: dts: sunxi: add support for Lichee Pi Zero board

J?rg Krause (2):
      ARM: dts: sun7i: Enable audio codec on Banana Pro
      ARM: dts: sun7i: Add wifi dt node on Banana Pro

Marcus Cooper (9):
      ARM: dts: sun6i: Mele I7: Enable internal audio codec
      ARM: dts: sun6i: Add SPDIF TX pin to the A31
      ARM: dts: sun6i: Add the SPDIF block to the A31
      ARM: dts: sun4i: A1000: add axp209 regulator nodes
      ARM: dts: sun6i: Add SPDIF to the Mele I7
      ARM: dts: sun8i-h3: Add dts for the Beelink X2 STB
      ARM: dts: sun8i-h3: Add SPDIF TX pin to the H3
      ARM: dts: sun8i-h3: Add the SPDIF block to the H3
      ARM: dts: sun8i-h3: Add SPDIF to the Beelink X2

Maxime Ripard (3):
      ARM: sun8i: a23/a33: Enable the real LOSC and use it
      ARM: sun8i: a23/a33: Add the oscillators accuracy
      ARM: sun8i: sina33: Enable display

Quentin Schulz (6):
      dt-bindings: power: axp20x-usb: add axp223 compatible
      ARM: dts: add DTSI for AXP223
      ARM: dts: sun8i: a33-olinuxino: use AXP223 DTSI
      ARM: dts: sun8i: sina33: use AXP223 DTSI
      ARM: dts: sun8i: parrot: use AXP223 DTSI
      ARM: dts: sun8i: reference-design: use AXP223 DTSI

 .../bindings/power/supply/axp20x_usb_power.txt     |   5 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/axp223.dtsi                      |  58 ++++
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  31 +++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   1 +
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts       | 224 +++++++++++++++
 arch/arm/boot/dts/sun5i.dtsi                       |   9 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  19 ++
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |  30 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  22 ++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   5 +
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |  33 ++-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  38 +++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |  90 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   6 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  24 +-
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |  23 ++
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  16 ++
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          |   2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  36 ++-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  35 +++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   1 +
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  | 160 +++++++++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 160 +++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   8 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  40 +++
 arch/arm/boot/dts/sun8i-r16-parrot.dts             |   2 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   6 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts      | 103 +++++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 309 +++++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80.dtsi                   |   3 +
 32 files changed, 1436 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp223.dtsi
 create mode 100644 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3s.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/f6368bb9/attachment.sig>
