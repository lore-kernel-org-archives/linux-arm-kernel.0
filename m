From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Aug 2015 11:41:43 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.3
Message-ID: <20150803094143.GA16612@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the DT changes for the 4.3 merge window.

I'll be in holidays for the three next weeks, so this is probably
going to be my last "feature" pull request for the 4.3 merge window.

Thanks!
Maxime


The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.3

for you to fetch changes up to 60018d027d792bdfe9d98c83a470fa2cdd6a0e1a:

  ARM: dts: sun7i: Change cubietruck wifi enable pin to use mmc-pwrseq (2015-08-01 11:25:11 +0200)

----------------------------------------------------------------
Allwinner Device Tree changes for 4.3

A bunch of device tree patches that:
  - Enable the OTG controller on some boards
  - Various additions to the existing boards
  - New boards: A33 Ippo Q8H, Iteaduino Plus,

----------------------------------------------------------------
Chen-Yu Tsai (4):
      ARM: dts: sun8i: Add support for USB controllers on A23/A33
      ARM: dts: sun8i: sina33: Enable USB hosts
      ARM: dts: sun5i: hsg-h702: Enable side volume buttons with LRADC
      ARM: dts: sun5i: hsg-h702: Enable USB OTG controller

Hans de Goede (22):
      ARM: dts: sun4i: Add USB Dual Role Controller
      ARM: dts: sun5i: Add USB Dual Role Controller
      ARM: dts: sun6i: Add USB Dual Role Controller
      ARM: dts: sun8i: Add A23 usb-phy and otg nodes
      ARM: dts: sun8i: Add A33 usb-phy and otg nodes
      ARM: dts: sun4i: Enable USB DRC on Chuwi V7 CW0825
      ARM: dts: sun4i: Enable USB DRC on the Cubieboard
      ARM: dts: sun5i: Enable USB DRC on UTOO P66
      ARM: dts: sun6i: Enable USB DRC on the Mele A1000G quad
      ARM: dts: sun7i: Enable USB DRC on A20-OLinuxIno-Lime
      ARM: dts: sun7i: Enable USB DRC on A20-OLinuxIno-Micro
      ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A23 tablets
      ARM: dts: sun8i: Enable USB DRC on GA10H-A33 tablets
      ARM: dts: sun8i: Enable USB host on GA10H-A33 tablets
      ARM: sun8i: dts: Add Ippo-q8h v1.2 with A33
      ARM: dts: sunxi: Add regulator-boot-on to usb host port regulator nodes
      ARM: dts: sun4i: Enable otg controller on the ba10-tvbox
      ARM: dts: sun4i: Enable otg controller on the mini-x
      ARM: dts: sun6i: Enable otg controller on the cs908
      ARM: dts: sun5i: Enable USB DRC on A10s OLinuxIno Micro
      ARM: dts: sun8i: Enable USB DRC on Ippo Q8H-A33 tablet
      ARM: dts: sun7i: Change cubietruck wifi enable pin to use mmc-pwrseq

Josef Gajdusek (1):
      ARM: dts: sun4i: Add Iteaduino Plus A10

Karsten Merker (1):
      devicetree: Add msi to the vendor-prefix list

Mark Janssen (1):
      ARM: dts: sun5i: Enable USB DRC on A13 OLinuxIno

Maxime Ripard (1):
      ARM: sunxi: dt: Convert users to the PIO interrupts binding

Michal Suchanek (2):
      ARM: dts: axp152: Add a dtsi file for the axp152 pmic
      ARM: dts: A10s-OLinuxIno: Add a node for axp152 pmic

Remy van Elst (1):
      ARM: dts: sun4i: Enable USB DRC on A10 OLinuxIno Lime

Roman Byshko (2):
      ARM: dts: sun7i: Add USB Dual Role Controller
      ARM: dts: sun7i: Enable USB DRC on Cubietruck

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/axp152.dtsi                      |  49 +++++
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |  15 ++
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  34 ++++
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |  19 ++
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    | 202 +++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |  15 ++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  32 ++++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  16 +-
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  37 +++-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |  58 ++++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |  37 ++++
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  29 ++-
 arch/arm/boot/dts/sun5i.dtsi                       |  16 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |   5 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  16 +-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts             |   5 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  56 ++++--
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |  32 ++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  32 ++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  16 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  25 ++-
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        |   9 +
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  33 ++++
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |  17 ++
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts      | 133 ++++++++++++++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  13 ++
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  33 ++++
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |   2 +
 31 files changed, 962 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp152.dtsi
 create mode 100644 arch/arm/boot/dts/sun4i-a10-itead-iteaduino-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150803/50eb4ded/attachment-0001.sig>
