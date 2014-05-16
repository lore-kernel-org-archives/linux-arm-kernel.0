From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 May 2014 14:07:21 +0200
Subject: [GIT PULL] Allwinner DT for 3.16
Message-ID: <20140516120721.GA20433@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the pull request for the DT changes for the sunXi SoCs.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.16

for you to fetch changes up to 209394aed532c5de9bf549f4beac92bf1b80f887:

  ARM: sunxi: dt: declare the r_pio pin controller for A31 SoC (2014-05-15 10:38:00 +0200)

----------------------------------------------------------------
Allwinner DT additions for 3.16

  - Introduction of the MMC controlers
  - New board: A10s R7, Mele M9, APP4-EVB1
  - Enabled the PMU on the Cortex A7-based SoCs

----------------------------------------------------------------
Alexandre Belloni (5):
      ARM: sun4i: dt: add pinmux configuration for the PWM
      ARM: sun7i: dt: add pinmux configuration for the PWM
      ARM: sun4i: dt: add PWM support
      ARM: sun7i: dt: add PWM support
      ARM: sunxi: dt: add PWM support for the cubietruck

Boris BREZILLON (3):
      ARM: sunxi: dt: add APP4-EVB1 board support
      ARM: sunxi: dt: add PRCM clk and reset controller subdevices
      ARM: sunxi: dt: declare the r_pio pin controller for A31 SoC

Chen-Yu Tsai (1):
      ARM: dts: sun7i: Add basic support for the Cubietruck WiFi module

David Lanzend?rfer (2):
      ARM: dts: sun4i: Add mmc controller nodes
      ARM: dts: sun5i: Add mmc controller nodes

Hans de Goede (21):
      ARM: sun6i: dt: Fixup prcm node name
      ARM: sun4i: dt: Add address- and size-cells info to i2c controller nodes
      ARM: sun5i: dt: Add address- and size-cells info to i2c controller nodes
      ARM: sun7i: dt: Add address- and size-cells info to i2c controller nodes
      ARM: dts: sun5i: Add pin-muxing info for the mmc controllers
      ARM: dts: sun6i: Add pin-muxing info for the mmc controllers
      ARM: dts: sun4i: Add pin-muxing info for the mmc0 controller
      ARM: dts: sun4i: Enable mmc controller on various A10 boards
      ARM: dts: sun5i: Enable mmc controller on various A10s and A13 boards
      ARM: dts: sun6i: Add mmc clocks
      ARM: dts: sun6i: Add mmc controller nodes
      ARM: dts: sun6i: Add new sun6i-a31-m9 dts file for Mele M9
      ARM: dts: sun7i: Add mmc controller nodes
      ARM: dts: sun7i: Add pin-muxing info for the mmc controllers
      ARM: dts: sun7i: Enable mmc controller on various A20 boards
      ARM: dts: sunxi: Add reg_vcc3v3 supply to sunxi-common-regulators.dtsi
      ARM: dts: sun4i: Add reg_vcc3v3 to sun4i board mmc nodes
      ARM: dts: sun5i: Add reg_vcc3v3 to sun5i board mmc nodes
      ARM: dts: sun6i: Add reg_vcc3v3 to sun6i board mmc nodes
      ARM: dts: sun7i: Add reg_vcc3v3 to sun7i board mmc nodes
      ARM: dts: sun5i: Add new A10s r7 hdmi tv dongle board

Maxime Ripard (6):
      ARM: sun6i: Sort the NMI node by physical address
      ARM: sun6i: dt: Add A31 DMA controller to DTSI
      ARM: sun7i: Add ARM PMU in A20 DTSI
      ARM: sun6i: Add ARM PMU in A31 DTSI
      ARM: sun6i: Add the USB clocks to the DTSI
      ARM: sun6i: dt: Add support for the USB controllers

 arch/arm/boot/dts/Makefile                       |   3 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |  10 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |  10 +
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |  10 +
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts        |  10 +
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts       |  10 +
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |  10 +
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  10 +
 arch/arm/boot/dts/sun4i-a10.dtsi                 |  78 +++++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  34 +++
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts    | 100 ++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  41 ++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  17 ++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  17 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  31 +++
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts        |  57 +++++
 arch/arm/boot/dts/sun6i-a31-m9.dts               |  50 ++++
 arch/arm/boot/dts/sun6i-a31.dtsi                 | 278 ++++++++++++++++++++++-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |  10 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |  47 ++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  27 +++
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  95 ++++++++
 arch/arm/boot/dts/sunxi-common-regulators.dtsi   |   7 +
 23 files changed, 953 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31-m9.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/adda07db/attachment.sig>
