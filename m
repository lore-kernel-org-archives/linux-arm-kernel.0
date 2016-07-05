From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 22:12:39 +0200
Subject: [GIT PULL] Allwinner DT patches for 4.8
Message-ID: <20160705201239.GA21186@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following DT changes for the next merge window.

Since it was conflicting on some files with the sunxi-fixes-for-4.7
tag I sent earlier, this branch is based on that tag.

Thanks,
Maxime

The following changes since commit eee25ab19de632af1ab4d2ac50bfc5006802e664:

  ARM: dts: sun7i: Fix pll3x2 and pll7x2 not having a parent clock (2016-06-29 09:03:13 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.8

for you to fetch changes up to d509e205d81f074a9b8d93ac80ab56405dede48b:

  ARM: dts: sun5i: Enable otg on the auxtex t004 (2016-07-05 08:54:33 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.8

The usual amount of DT patches, among which:
  - I2S support
  - Support for the AXP809 in the relevant boards (A80 based)
  - New boards: Banapi M1+, Banapi M2+, Allwinner Parrot (R16 EVB),
  - The other patches to enable various controllers on our boards, most
    notably USB OTG

----------------------------------------------------------------
Aleksei Mamlin (2):
      ARM: dts: sun4i: Re-order pinctrl nodes alphabetically
      ARM: dts: sun7i: Re-order pinctrl nodes alphabetically

Boris Brezillon (2):
      ARM: dts: sun4i: Add NFC node to Allwinner A10 SoC
      ARM: dts: sun7i: Add NFC node to Allwinner A20 SoC

Chen-Yu Tsai (15):
      ARM: dts: axp209: Disable ldo5 by default
      ARM: dts: sun5i: q8-common: Enable USB power supply
      ARM: dts: sun5i: q8-common: Enable audio codec
      ARM: dts: sun5i: q8-common: Enable display pipeline and LCD display
      ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
      ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC device node and regulators
      ARM: dts: sun9i: cubieboard4: Add AXP809 PMIC device node and regulators
      ARM: dts: sun8i-h3: move uart0 pins to sort pinmux list in proper order
      ARM: dts: sun8i-h3: Add uart1 pinmux setting
      ARM: dts: sun8i-h3: Add dts file for Sinovoip BPI-M2+
      ARM: dts: sun9i: a80-optimus: Drop sunxi-common-regulators.dtsi
      ARM: dts: sun9i: cubieboard4: Drop sunxi-common-regulators.dtsi
      ARM: dts: sun9i: cubieboard4: Order nodes by alphabetical order
      ARM: dts: sun9i: a80-optimus: Order nodes by alphabetical order
      ARM: dts: sun5i: q8-common: Enable USB-based WiFi

Emilio L?pez (1):
      ARM: sun7i: Add mod1 clock nodes

Florian Fainelli (1):
      ARM: dts: sun7i: Add BCM53125 switch nodes to the lamobo-r1 board

Hans de Goede (20):
      ARM: dts: sun5i-a10s-wobo-i5: Enable ldo4 too
      ARM: dts: sunxi: Add a startup delay for fixed regulator enabled phys
      ARM: dts: sun4i: HDMI and the tv-encoder use tcon ch1 not ch0
      ARM: dts: sun7i: HDMI and the tv-encoder use tcon ch1 not ch0
      ARM: dts: axp22x.dtsi: Disable axp22x ldo_io# regulators by default
      ARM: dts: axp22x.dtsi: Add usb_power_supply node
      ARM: dts: axp22x.dtsi: Add reg_drivebus node
      ARM: dts: sun8i-a?3-q8-tablet.dts: Add full otg support
      ARM: dts: sun8i-a23-polaroid-mid2809pxe04: Add full otg support
      ARM: dts: sun8i-a23-polaroid-mid2809pxe04: Disable ehci0
      ARM: dts: sun4i: The blue led on the Mele A1000 is a power led
      ARM: dts: sun6i: The blue led on the Mele A1000G quad is a power led
      ARM: dts: sun6i: The blue led on the Mele M9 is a power led
      ARM: dts: sun6i: Add pmic / regulator nodes to Mele A1000G quad dts
      ARM: dts: sun6i: Add pmic / regulator nodes to Mele M9 dts
      ARM: dts: sun8i-q8-common: Add support for USB wifi controllers
      ARM: dts: sun5i: Enable otg on the mk802
      ARM: dts: sun5i: Add axp152 pmic node to mk802
      ARM: dts: sun5i: Add mmc1 / sdio-wifi node to mk802
      ARM: dts: sun5i: Enable otg on the auxtex t004

Luo Yi (1):
      ARM: dts: sun7i: Add dts file for Bananapi M1 Plus board

Maxime Ripard (4):
      ARM: sun5i: a13: Add LCD pins
      ARM: sun5i: Move display blocks to A13
      ARM: sun7i: Add DAI nodes
      ARM: sun5i: Allow PLL3 2x fixed factor clock to change PLL3 rate

Michal Suchanek (2):
      ARM: dts: sun5i: a10s: add spi2 pins
      ARM: dts: sun5i: add spi2 on A10s Olinuxino Micro

Priit Laes (2):
      ARM: sun4i: A10: Add display and TCON clocks
      ARM: sun7i: A20: Add display and TCON clocks

Quentin Schulz (1):
      ARM: sun8i: Add Parrot Board DTS

 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/axp209.dtsi                      |   1 +
 arch/arm/boot/dts/axp22x.dtsi                      |  12 +
 arch/arm/boot/dts/axp809.dtsi                      |  53 +++
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   4 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   1 +
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   1 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   | 227 +++++++---
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  19 +
 arch/arm/boot/dts/sun5i-a10s-mk802.dts             |  32 ++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   7 +
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |  10 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  14 +
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts          |  10 -
 arch/arm/boot/dts/sun5i-a13.dtsi                   | 122 ++++++
 arch/arm/boot/dts/sun5i-q8-common.dtsi             |  62 +++
 arch/arm/boot/dts/sun5i-r8.dtsi                    | 120 +-----
 arch/arm/boot/dts/sun5i.dtsi                       |   2 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                 |  96 ++++-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts   |  96 ++++-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   | 230 ++++++++++
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |  60 ++-
 arch/arm/boot/dts/sun7i-a20.dtsi                   | 474 ++++++++++++++-------
 .../boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts   |  34 +-
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |  15 -
 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts          |  15 -
 .../arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts | 195 +++++++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  21 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |  42 ++
 arch/arm/boot/dts/sun8i-r16-parrot.dts             | 351 +++++++++++++++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 164 ++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            | 195 +++++++--
 32 files changed, 2235 insertions(+), 455 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp809.dtsi
 create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-sinovoip-bpi-m2-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-parrot.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/f186e6df/attachment.sig>
