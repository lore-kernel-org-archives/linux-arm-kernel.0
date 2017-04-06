From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 10:58:10 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.12
Message-ID: <20170406085810.lhizqmi65h2jats3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following DT changes for the next merge window.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt-for-4.12

for you to fetch changes up to 367d2b0cb15dfbfa7243b200957c3c6b86276b54:

  ARM: sun8i: sina33: add highest OPP of CPUs (2017-04-05 14:11:36 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.12

As usual a number of changes, among which:
  - All the sun5i DTSI has been reworked based on the new documentation and
    the IPs that are actually found in all those SoCs. Part of that rework
    also brought the GR8 DTSI to include sun5i.dtsi
  - Mali devfreq and thermal throttling support on the A33
  - AC power supplies for the AXP209 and AXP22X PMIC
  - CAN support for the A20
  - CPUFreq-based thermal throttling for the A33
  - New board: NanoPi NEO Air

----------------------------------------------------------------
Alexander Syring (1):
      ARM: sun7i: cubietruck: enable ACIN und USB power supply subnode

Chen-Yu Tsai (5):
      ARM: dts: sun8i-a23-q8-tablet: Drop pinmux setting for codec PA gpio
      ARM: dts: sunxi: Remove no longer used pinctrl/sun4i-a10.h header
      ARM: dts: sun6i: sina31s: Enable SPDIF out
      dt-bindings: display: sun4i: Add display backend interrupt to device tree binding
      ARM: dts: sun5i: Add interrupt for display backend

Emmanuel Vadot (1):
      ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2

Ezequiel Garcia (1):
      ARM: dts: sun7i: Use axp209.dtsi on A20-OLinuXino-Micro

Jelle van der Waa (1):
      ARM: dts: sun8i: Add dts file for NanoPi NEO Air

Jonathan Liu (1):
      ARM: sun7i: Enable audio codec on A20-OLinuXino-Micro

Marcus Cooper (1):
      ARM: dts: sun8i-h3: Add mmc2 node to the X2

Maxime Ripard (12):
      ARM: sun5i: A10s: Switch the EMAC pins indices
      ARM: sun5i: a10s: switch simple framebuffer indices
      ARM: sun5i: Add UART2 pin group
      ARM: sun5i: Rename UART3 flow control pins
      ARM: sun5i: a13: Merge common controllers into the common DTSI
      ARM: sun5i: a10s: Merge common controllers into the common DTSI
      ARM: sun5i: r8: Merge common controllers into the common DTSI
      ARM: sun5i: gr8: Use common sun5i DTSI
      dt-bindings: gpu: mali: Add optional memory-region
      dt-bindings: gpu: mali: Add optional OPPs
      ARM: sun8i: a33: Add the Mali OPPs
      ARM: sun8i: a33: Add devfreq-based GPU cooling

Patrick Menschel (6):
      ARM: dts: sun4i: Add CAN node
      ARM: dts: sun4i: Add can0_pins_a pinctrl settings
      ARM: dts: sun7i: Add CAN node
      ARM: dts: sun7i: Add can0_pins_a pinctrl settings
      ARM: dts: sun4i: fix device node ordering
      ARM: dts: sun7i: fix device node ordering

Quentin Schulz (9):
      ARM: dtsi: axp209: add AC power supply subnode
      ARM: dtsi: axp22x: add AC power supply subnode
      ARM: dts: sun8i: sina33: enable ACIN power supply subnode
      ARM: sun5i: chip: enable ACIN power supply subnode
      ARM: sun8i: a33: add all operating points
      ARM: sun8i: sina33: add cpu-supply
      ARM: sun8i: a33: add thermal sensor
      ARM: sun8i: a33: add CPU thermal throttling
      ARM: sun8i: sina33: add highest OPP of CPUs

 .../bindings/display/sunxi/sun4i-drm.txt           |   2 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |   8 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/axp209.dtsi                      |   5 +
 arch/arm/boot/dts/axp22x.dtsi                      |   5 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   1 -
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   1 -
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |   1 -
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   1 -
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |   1 -
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   1 -
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   1 -
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   1 -
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   1 -
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   1 -
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |   1 -
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   1 -
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |   1 -
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  40 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |   1 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |   1 -
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   5 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts      |   1 -
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |   3 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  77 +--
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |   1 -
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |   1 -
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts       |   1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |   1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |   1 -
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 140 -----
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts           |   4 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts                |   4 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                   | 618 +--------------------
 arch/arm/boot/dts/sun5i-r8-chip.dts                |   6 +-
 arch/arm/boot/dts/sun5i-r8.dtsi                    |  40 --
 arch/arm/boot/dts/sun5i.dtsi                       | 284 +++++++++-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts          |   1 -
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |   1 -
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |   1 -
 arch/arm/boot/dts/sun6i-a31-i7.dts                 |   1 -
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |   1 -
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |   1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   1 -
 arch/arm/boot/dts/sun6i-a31s-cs908.dts             |   2 -
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |   1 -
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi     |   1 -
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  23 +
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |  57 ++
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |   1 -
 .../boot/dts/sun6i-reference-design-tablet.dtsi    |   1 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |   1 -
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |   1 -
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   9 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |   1 -
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |   1 -
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |   1 -
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   1 -
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |   1 -
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   1 -
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |   1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  36 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |   1 -
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |   1 -
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |   1 -
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  46 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   2 +-
 arch/arm/boot/dts/sun8i-a23-evb.dts                |   1 -
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |  10 -
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  23 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 155 ++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   2 -
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |   1 -
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |   1 -
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |  11 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts      |  96 ++++
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   1 -
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |   1 -
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |   1 -
 arch/arm/boot/dts/sun9i-a80.dtsi                   |   2 -
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |   1 -
 .../boot/dts/sunxi-reference-design-tablet.dtsi    |   1 -
 88 files changed, 806 insertions(+), 968 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/c5e13564/attachment-0001.sig>
