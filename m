From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Jun 2015 14:28:07 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.2, take 2
Message-ID: <20150603122807.GA1810@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following tag on top of the previous pull-request.

Thanks!
Maxime

The following changes since commit f3022c6ca06e0b8d8e77c94da1af5f41210e52ba:

  ARM: sunxi: dt: Split the SPI pinctrl groups (2015-05-10 10:23:56 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.2-2

for you to fetch changes up to 16b2a7d4cb922ee7ec238233d0c4e46be97e9db0:

  ARM: dts: sun6i: Add a dts file for the Mele A1000G quad top set box (2015-06-02 23:39:46 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.2, take 2

A bunch of new DT changes for the 4.2 merge window, among which:
  - Enable the SRAM controller on the A10/A10s/A13/A20
  - A33 support
  - New boards: A23 EVB, SinA33, GA10H-A33, Mele A1000G

----------------------------------------------------------------
Chen-Yu Tsai (4):
      ARM: dts: sun9i: Add device node for watchdog
      ARM: dts: sun8i: Add pinmux setting for 8bit mmc2
      ARM: dts: sun8i-a33: Add pinmux setting for uart0 on PB pins
      ARM: dts: sun8i-a33: Add dts for Sinlinx SinA33 development board.

Hans de Goede (3):
      ARM: dts: sun8i: Add usb_clk node for a23/a33
      ARM: dts: sun8i: Add dts file for the GA10H-A33 tablet
      ARM: dts: sun6i: Add a dts file for the Mele A1000G quad top set box

Maxime Ripard (5):
      ARM: sun8i: Introduce A23 Evaluation Board Support
      ARM: dts: sunxi: Revert SRAM controller drivers patches
      ARM: dts: sun4i: Add A10 SRAM and SRAM controller
      ARM: dts: sun5i: Add A10s and A13 SRAM and SRAM controller
      ARM: dts: sun7i: Add A20 SRAM and SRAM controller

Michael Ring (2):
      ARM: dts: sun7i: Add uart4_pins_b definition
      ARM: dts: sun7i: Add uart4 support for BananaPro, disable uart2

Vishnu Patekar (3):
      ARM: dts: sun8i: Add sun8i-a23-a33 dtsi
      ARM: dts: sun8i: Add sun8i-a33 dtsi
      ARM: dts: sun8i: Add ET-Q8 A33 support

 arch/arm/boot/dts/Makefile                       |   7 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |   4 +
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts       |   4 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |   4 +
 arch/arm/boot/dts/sun4i-a10-hackberry.dts        |   4 +
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts       |   4 +
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        |   4 +
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts   |   4 +
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |   4 +
 arch/arm/boot/dts/sun4i-a10.dtsi                 |  61 +--
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   4 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                |   9 +
 arch/arm/boot/dts/sun5i.dtsi                     |  54 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts               |   2 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts | 149 ++++++
 arch/arm/boot/dts/sun7i-a20-bananapro.dts        |   6 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  68 +--
 arch/arm/boot/dts/sun8i-a23-a33.dtsi             | 636 +++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a23-evb.dts              | 134 +++++
 arch/arm/boot/dts/sun8i-a23.dtsi                 | 576 +-------------------
 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts       |  88 ++++
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts       | 125 +++++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts   | 129 +++++
 arch/arm/boot/dts/sun8i-a33.dtsi                 |  97 ++++
 arch/arm/boot/dts/sun9i-a80.dtsi                 |   6 +
 25 files changed, 1522 insertions(+), 661 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-a33.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-a23-evb.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/5ccd03fc/attachment.sig>
