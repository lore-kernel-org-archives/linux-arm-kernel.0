From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Sep 2016 21:43:22 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.9
Message-ID: <20160907194322.GA7535@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here are our usual DT patches for the 4.9 merge window.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.9

for you to fetch changes up to accfb2f19d185628858dc0c063c69c8b75b32724:

  devicetree: Add vendor prefix for FriendlyARM (2016-09-06 08:41:23 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.9

Business as usual on our side, with a mix of new boards and new IPs enabled
on boards:
  - Support for the GPIO found on the AXP PMIC
  - ESP8089 on the relevant boards
  - More boards converted to the reference design and q8 designs
  - New boards: Orange Pi PC Plus, Orange Pi 2, Orange Pi Plus 2E, Orange
    Pi Lite, Olimex A33-Olinuxino, Empire Electronix M712, inet-d978_rev2,
    Nano Pi Neo

----------------------------------------------------------------
Chen-Yu Tsai (4):
      ARM: dts: sun9i: a80-optimus: Add device node for AC100
      ARM: dts: sun9i: cubieboard4: Add device node for AC100
      ARM: dts: sun9i: Switch to the AC100 RTC clock outputs for osc32k
      ARM: dts: sun9i: Add missing #interrupt-cells to R_PIO pinctrl device node

Hans de Goede (19):
      ARM: dts: sun6i-a31s-colorfly-e708-q1: Add full otg support
      ARM: dts: sun8i: Add dts file for the Orange Pi PC Plus SBC
      ARM: dts: sun8i: Add ethernet1 alias to Orange Pi 2 dts
      ARM: dts: sun8i: Add dts file for the Orange Pi Lite SBC
      ARM: dts: sun8i: Use sun8i-reference-design-tablet for gt90h dts
      ARM: dts: sun8i: Add dt node for rtl8703as wifi chip on ga10h
      ARM: dts: sun8i: reference-design-tablet: Add gsl1680 touchscreen node
      ARM: dts: sun6i: colorfly-e708-q1: Remove unused mma8452_int_e708_q1 node
      ARM: dts: sun6i: Add sun6i-reference-design-tablet.dtsi
      ARM: dts: sun6i: Add new dts file for tablets using the inet-q972 PCB
      ARM: dts: sun8i: Add dt node for esp8089 wifi chip on polaroid-mid2407
      ARM: dts: sun8i: Add dt node for esp8089 wifi chip on polaroid-mid2809
      ARM: dts: sun4i: Disable ohci1 on ba10-tv-box
      ARM: dts: sun5i: Convert inet-98v-rev2 dts to use reference-design-tablet.dtsi
      ARM: dts: sun5i: Add dts file for the Empire Electronix M712 tablet
      ARM: dts: sun8i: Rename reference-design-tablet touchscreen node
      ARM: dts: sun8i: Orange Pi Plus dts is for the Plus and Plus 2
      ARM: dts: sun8i: Add dts file for the Orange Pi Plus2E SBC
      ARM: dts: sun8i-q8-common: Add support for SDIO wifi controllers

Icenowy Zheng (2):
      ARM: dts: sun8i: add NAND controller node for A23/A33
      ARM: dts: sun8i: Add dts file for inet-d978_rev2 tablets

James Pettigrew (2):
      ARM: dts: sun8i: Add dts file for the NanoPi NEO SBC
      devicetree: Add vendor prefix for FriendlyARM

Maxime Ripard (2):
      ARM: dt: axp209: Add AXP209 GPIO driver
      ARM: sun5i: chip: Add status LED

Milo Kim (1):
      ARM: dts: sun8i: Add PWM controller node in H3

Stefan Mavrodiev (1):
      ARM: dts: sun8i: Add dts file for Olimex A33-OLinuXino

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   8 +
 arch/arm/boot/dts/axp209.dtsi                      |   6 +
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   4 -
 .../boot/dts/sun5i-a13-empire-electronix-m712.dts  |  51 +++++
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts      | 164 +--------------
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  10 +
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts  | 138 +------------
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts         | 100 +++++++++
 .../boot/dts/sun6i-reference-design-tablet.dtsi    | 193 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  21 ++
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           | 192 +----------------
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |  42 ++++
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |  42 ++++
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |  18 ++
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |  88 ++++++++
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts          | 226 +++++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          | 125 ++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  10 +
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 178 ++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |  88 ++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |   2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts     |  53 +++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   8 +
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |  49 +++++
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |  26 +++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  29 +++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  29 +++
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  14 +-
 29 files changed, 1411 insertions(+), 504 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-empire-electronix-m712.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts
 create mode 100644 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-olinuxino.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/7b718a64/attachment.sig>
