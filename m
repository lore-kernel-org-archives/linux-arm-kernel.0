From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 15 Jul 2016 12:52:43 +0200
Subject: [GIT PULL] Allwinner DT patches for 4.8, take 2
Message-ID: <20160715105243.GA4468@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the final (hopefully) pull request for the Allwinner SoCs for
the 4.8 merge window.

Thanks!
Maxime

The following changes since commit d509e205d81f074a9b8d93ac80ab56405dede48b:

  ARM: dts: sun5i: Enable otg on the auxtex t004 (2016-07-05 08:54:33 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.8-2

for you to fetch changes up to 339120c5f638727a8359b054ec06ed2d66dc9b19:

  ARM: dts: sun8i: Add dts file for inet86dz board (2016-07-11 08:39:27 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.8, take 2

Another set of changes for the 4.8 merge window, among which:
  - Reworking of the DT for the tablets based on Allwinner reference design
    and q8 designs to avoid duplication as much as possible
  - Renaming a DT merged in the first PR for consistency
  - Enable a few devices on some boards
  - New boards: Polaroid MID2407PXE03, inet86dz

----------------------------------------------------------------
Chen-Yu Tsai (9):
      ARM: dts: sun7i: lamobo-r1: Fix USB-based WiFi module power
      ARM: dts: sun7i: lamobo-r1: Remove usb1 vbus regulator
      ARM: dts: sun8i-h3: Rename sinovoip-bpi-m2-plus to bananapi-m2-plus
      ARM: dts: sun7i: lamobo-r1: Fix GPIO flags in reg_ahci_5v
      ARM: dts: sun7i: lamobo-r1: Enable audio codec
      ARM: dts: sun7i: bananapi-m1-plus: Reindent whole file using tabs
      ARM: dts: sun7i: bananapi-m1-plus: Unify suffix for board specific labels
      ARM: dts: sun7i: bananapi-m1-plus: red LED is power LED
      ARM: dts: sun7i: bananapi-m1-plus: Enable USB OTG

Hans de Goede (13):
      ARM: dts: sunxi: Rename sunxi-q8-common.dtsi sunxi-reference-design-tablet.dtsi
      ARM: dts: sun5i: Move q8 display bits to sun5i-a13-q8-tablet.dts
      ARM: dts: sun5i: Rename sun5i-q8-common.dtsi sun5i-reference-design-tablet.dtsi
      ARM: dts: sun5i: reference-design-tablet: Set lradc vref to avcc
      ARM: dts: sun5i: reference-design-tablet: Remove mention of q8
      ARM: dts: sun5i: Use sun5i-reference-design-tablet.dtsi for dit4350 dts
      ARM: dts: sun5i: Use sun5i-reference-design-tablet.dtsi for utoo p66 dts
      ARM: dts: Copy sun8i-q8-common.dtsi sun8i-reference-design-tablet.dtsi
      ARM: dts: sun8i: reference-design-tablet: Add drivevbus-supply
      ARM: dts: sun8i: Use sun8i-reference-design-tablet for polaroid mid2809pxe04
      ARM: dts: sun8i: Use sun8i-reference-design-tablet for ga10h dts
      ARM: dts: sun8i: Add dts file for Polaroid MID2407PXE03 tablet
      ARM: dts: sun8i: Add dts file for inet86dz board

 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/sun5i-a13-difrnce-dit4350.dts    | 178 +-----------
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts          |  38 ++-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           | 180 ++-----------
 ...mon.dtsi => sun5i-reference-design-tablet.dtsi} |  46 +---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   | 300 ++++++++++++---------
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  20 +-
 arch/arm/boot/dts/sun8i-a23-inet86dz.dts           |  58 ++++
 .../boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts   |  50 ++++
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   | 207 +-------------
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts         |  77 +-----
 ...i-m2-plus.dts => sun8i-h3-bananapi-m2-plus.dts} |   6 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi             | 173 +-----------
 .../boot/dts/sun8i-reference-design-tablet.dtsi    | 216 +++++++++++++++
 ...mon.dtsi => sunxi-reference-design-tablet.dtsi} |   0
 15 files changed, 577 insertions(+), 976 deletions(-)
 rename arch/arm/boot/dts/{sun5i-q8-common.dtsi => sun5i-reference-design-tablet.dtsi} (88%)
 create mode 100644 arch/arm/boot/dts/sun8i-a23-inet86dz.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts
 rename arch/arm/boot/dts/{sun8i-h3-sinovoip-bpi-m2-plus.dts => sun8i-h3-bananapi-m2-plus.dts} (97%)
 create mode 100644 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
 rename arch/arm/boot/dts/{sunxi-q8-common.dtsi => sunxi-reference-design-tablet.dtsi} (100%)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/f7eab20b/attachment-0001.sig>
