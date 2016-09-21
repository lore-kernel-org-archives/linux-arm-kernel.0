From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Sep 2016 11:58:14 +0300
Subject: [GIT PULL] Allwinner late DT changes for 4.9
Message-ID: <20160921085814.GA25513@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

This is a late (and last) PR for the Allwinner device trees.

It comes on top of the previous one (so it still has the dependency in
the clock changes).

Let me know if you have any questions,
Maxime

The following changes since commit 7a988a4dd29a8cfcf405a12441533d765d25a6b8:

  ARM: dts: gr8: Add support for the GR8 evaluation board (2016-09-11 22:23:17 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.9-3

for you to fetch changes up to 90cb4b8c7e3af989c78227954e01455fc7c1e767:

  ARM: dts: sun8i: Add accelerometer to polaroid-mid2407pxe03 (2016-09-21 11:48:09 +0300)

----------------------------------------------------------------
Allwinner DT changes for 4.9, late edition

Here is a bunch of late changes for the 4.9 merge window, mostly:
  - Added a bunch of touchscreens nodes to tablets
  - Added support for the AXP806 PMIC found in the A80 boards
  - Enabled a few pinmux options for the H3

----------------------------------------------------------------
Chen-Yu Tsai (5):
      ARM: dts: sun9i: a80-optimus: Declare AXP809 SW regulator as unused
      ARM: dts: sun9i: cubieboard4: Declare AXP809 SW regulator as unused
      ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC device node and regulators
      ARM: dts: sun9i: cubieboard4: Add AXP806 PMIC device node and regulators
      ARM: dts: sun9i: a80-optimus: Disable EHCI1

Hans de Goede (6):
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-gt90h
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-inet86dz
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-polaroid-mid2407pxe03
      ARM: dts: sun8i: Add touchscreen node for sun8i-a23-polaroid-mid2809pxe04
      ARM: dts: sun8i: Add touchscreen node for sun8i-a33-ga10h
      ARM: dts: sun8i: Add accelerometer to polaroid-mid2407pxe03

Icenowy Zheng (2):
      ARM: dts: sun8i: add pinmux for UART1 at PG
      ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board

Jorik Jonker (5):
      dts: sun8i-h3: add pinmux definitions for UART2-3
      dts: sun8i-h3: split off RTS/CTS for UART1 in seperate pinmux
      dts: sun8i-h3: associate exposed UARTs on Orange Pi Boards
      dts: sun8i-h3: add pinmux definitions for I2C0-2
      dts: sun8i-h3: add I2C0-2 peripherals to H3 SOC

 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  10 ++
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           |   9 ++
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts           |   9 ++
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |  26 +++++
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |   9 ++
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |  10 ++
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts     |  20 ++++
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |   2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  18 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |  18 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  18 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  85 +++++++++++++-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 116 +++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            | 123 ++++++++++++++++++++-
 14 files changed, 468 insertions(+), 5 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160921/3be903f5/attachment.sig>
