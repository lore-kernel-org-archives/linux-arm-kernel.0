From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 29 Apr 2016 18:36:25 +0200
Subject: [GIT PULL] Allwinner DT additions for 4.7
Message-ID: <20160429163625.GA5732@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following tag for the next merge window.

Thanks!
Maxime

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.7

for you to fetch changes up to b52e345d43cfe9214fecfa92375525a086d39581:

  ARM: dts: sun7i: Enable S/PDIF on the Cubietruck (2016-04-25 09:56:34 +0200)

----------------------------------------------------------------
Allwinner DT additions for 4.7

The usual bunch of changes, mostly:
  * Addition of the SPDIF support
  * Addition of the pre-requisites for the display support
  * New boards: Difrence DIT4350, colorfly e708 q1, Dserve DSRV9703C,
                Polaroid MID2809PXE4, Orange Pi PC, Orange Pi 2

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun8i: Add Orange Pi PC support

Christopher Spinrath (1):
      ARM: dts: sun7i: Enable S/PDIF on the Cubietruck

Hans de Goede (19):
      ARM: dts: sun5i-a13-inet98v-rev2: Remove mmc2 node
      ARM: dts: sun5i-a13-empire-electronix-d709: Remove mmc2 node
      ARM: dts: sun5i: Add dts for Difrence DIT4350 tablet
      ARM: dts: sun6i: Add dts for colorfly e708 q1 tablet
      ARM: dts: sun8i: Add pmic nodes to sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Add backlight / pwm nodes to sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Fix wrong Quad core / a33 compat for sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Fix regulator for mmc0 for sun8i-a23-gt90h-v4
      ARM: dts: sun8i: Add dts file for the Polaroid MID2809PXE4 tablet
      ARM: dts: sun4i: Add dts file for Dserve DSRV9703C tablet
      ARM: dts: sun8i: Add mmc2_8bit_pins to sun8i-h3.dtsi
      ARM: dts: sun8i: Enable IR receiver on Orangepi Plus boards
      ARM: dts: sun8i: Add wifi dt node on Orangepi Plus boards
      ARM: dts: sun8i: Add eMMC dt node on Orangepi Plus boards
      ARM: dts: sun8i: Fix pio nodes Orangepi Plus dts
      ARM: dts: sun8i: Add dts for Orange Pi 2 SBC
      ARM: dts: sun8i: Orangepi plus gpio keys fixes and improvements
      ARM: dts: sun8i: Base Orange Pi Plus dts on the Orange Pi 2 dts
      ARM: dts: sun8i: Add dts file for the Orange Pi One SBC

JM Friedt (1):
      ARM: dts: sun5i-a13-olinuxino-micro: enable USB DRC

Jens Kuske (1):
      ARM: dts: sun8i: Enable USB host controllers on Orangepi Plus boards

Marcus Cooper (8):
      ARM: dts: sun4i: Add SPDIF TX pin to the A10
      ARM: dts: sun7i: Add SPDIF TX pin to the A20
      ARM: dts: sun4i: Add the SPDIF clk to the A10
      ARM: dts: sun7i: Add the SPDIF clk to the A20
      ARM: dts: sun4i: Add the SPDIF block to the A10
      ARM: dts: sun7i: Add the SPDIF block to the A20
      ARM: dts: sun4i: Add SPDIF to the Mele A1000
      ARM: dts: sun7i: Add SPDIF to the Itead Ibox

Maxime Ripard (3):
      ARM: sun5i: dt: Add pll3 and pll7 clocks
      ARM: sun5i: Add TV encoder gate to the DTSI
      ARM: sun5i: Add DRAM gates

Priit Laes (2):
      ARM: sun4i: dt: Enable dram gate 5 (tve0 clock) for simplefb TV output
      ARM: sun7i: dt: Enable dram gate 5 (tve0 clock) for simplefb TV output

Reinder de Haan (2):
      ARM: dts: sun8i: Add support for H3 usb clocks
      ARM: dts: sun8i: Add usbphy and usb host controller nodes

 arch/arm/boot/dts/Makefile                         |   7 +
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |  24 ++
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   | 281 +++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  33 ++-
 arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts    | 226 +++++++++++++++++
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |  19 +-
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts      |  15 --
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts    |  41 +++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  31 ++-
 arch/arm/boot/dts/sun5i-r8.dtsi                    |   2 +-
 arch/arm/boot/dts/sun5i.dtsi                       |  43 ++++
 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts  | 208 +++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  24 ++
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |  24 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  36 ++-
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           | 120 ++++++++-
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   | 243 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 186 ++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 145 +++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 167 ++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       | 105 +++-----
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 123 +++++++++
 22 files changed, 1986 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-colorfly-e708-q1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160429/25f77615/attachment.sig>
