From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 21:41:22 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.10
Message-ID: <20161115204122.x3vnb3bkny5esdya@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is our pull request for the next merge window.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.10

for you to fetch changes up to e39a30cf736144814b0bddb3fff28fbbc2a8be0f:

  ARM: sunxi: Add the missing clocks to the pinctrl nodes (2016-11-15 18:49:47 +0100)

----------------------------------------------------------------
Allwinner DT additions for 4.10

The usual bunch of DT additions, but most notably:
  - A31 DRM driver
  - A31 audio codec
  - WiFi for the A80-Based boards and the CHIP
  - Support for the NextThing Co CHIP Pro (the first board with NAND
    enabled)
  - New boards: NanoPi M1,

----------------------------------------------------------------
Antoine Tenart (1):
      ARM: sun5i: chip: add a node for the w1 gpio controller

Chen-Yu Tsai (12):
      ARM: dts: sun6i: Sort pinmux setting nodes
      ARM: dts: sun6i: Add device nodes for first display pipeline
      ARM: dts: sun6i: Add A31 LCD0 RGB888 pins
      ARM: dts: sun9i: Add mmc1 pinmux setting
      ARM: dts: sun9i: a80-optimus: Enable AP6330 WiFi
      ARM: dts: sun9i: cubieboard4: Enable AP6330 WiFi
      ARM: dts: sun6i: Add audio codec device node
      ARM: dts: sun6i: hummingbird: Enable internal audio codec
      ARM: dts: sun6i: sina31s: Enable internal audio codec
      ARM: dts: sun7i: bananapi-m1-plus: Enable USB PHY for USB host support
      ARM: dts: sun7i: bananapi-m1-plus: Add PMIC regulators
      ARM: dts: sun7i: bananapi-m1-plus: Enable USB OTG

Emmanuel Vadot (1):
      ARM: dts: sunxi: Add cpu-supply for Olimex A20 EVB

Hans de Goede (1):
      ARM: dts: sun8i: reference-design-tablet: ldo_io1 is vcc-touchscreen

Maxime Ripard (16):
      ARM: sun5i: a13-olinuxino: Enable VGA bridge
      ARM: gr8: Add the UART3
      ARM: gr8: Fix typo in the i2s mclk pin group
      ARM: gr8: Add missing pwm channel 1 pin
      ARM: gr8: Add UART2 pins
      ARM: gr8: Add UART3 pins
      ARM: gr8: Add CHIP Pro support
      ARM: sun5i: chip: Enable Wi-Fi SDIO chip
      ARM: sun5i: Rename A10s pins
      ARM: sun5i: Add SPI2 pins
      ARM: sun5i: Add RGB 565 LCD pins
      ARM: sun5i: chip: Add optional buses
      ARM: gr8: evb: Enable SPDIF
      ARM: gr8: evb: Add i2s codec
      ARM: sun8i: sina33: Enable USB gadget
      ARM: sunxi: Add the missing clocks to the pinctrl nodes

Milo Kim (5):
      ARM: dts: sun8i: Add common dtsi file for NanoPi SBCs
      ARM: dts: sun8i: Use the common file in NanoPi NEO SBC
      ARM: dts: sun8i: Add dts file for NanoPi M1 SBC
      ARM: dts: sun8i: Add SPI pinctrl node in H3
      ARM: dts: sun8i: Add SPI controller node in H3

Sudeep Holla (1):
      ARM: dts: sun8i: replace enable-sdio-wakeup with wakeup-source for BananaPi M1+

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/ntc-gr8-chip-pro.dts             | 266 +++++++++++++++++++++
 arch/arm/boot/dts/ntc-gr8-evb.dts                  |  33 +++
 arch/arm/boot/dts/ntc-gr8.dtsi                     |  47 +++-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   3 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   4 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   4 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  54 +++++
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  69 ++++++
 arch/arm/boot/dts/sun5i.dtsi                       |  27 ++-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  13 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 266 +++++++++++++++++----
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |   8 +
 arch/arm/boot/dts/sun6i-a31s.dtsi                  |   8 +
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |  62 ++++-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   4 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   3 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   6 +-
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |   7 -
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   5 +
 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           |  64 +++++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |  79 +-----
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi             | 144 +++++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  52 +++-
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |   7 +
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  32 +++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  30 +++
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  14 +-
 28 files changed, 1165 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/boot/dts/ntc-gr8-chip-pro.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/c1f6ab49/attachment.sig>
