From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 17:34:14 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 1
Message-ID: <20151011163414.GA12938@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes for the 4.4 merge window.

Thanks!
Maxime

The following changes since commit f594297830b29c8204c421fafe66001178ac0f9a:

  ARM: dts: Fix Makefile target for sun4i-a10-itead-iteaduino-plus (2015-09-13 14:20:26 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.4

for you to fetch changes up to 52095d179c5b3254fa87aaa6990e164c5cf21e12:

  ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and DC5LDO supplies (2015-10-07 11:34:54 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.4

DT patches for the 4.4 merge window, most notably:
  - Enable the OTG controller on more boards
  - Create new DTSI for the q8's design
  - Added RSB support to the A23 and A33 SoCs
  - New boards: Olimex A20 EVB, Yones bs1078v2

Plus the usual random patches enabling and / or enhancing a few things in
particular boards.

----------------------------------------------------------------
Aleksei Mamlin (2):
      ARM: dts: sun4i: Enable USB DRC on the Marsboard A10
      ARM: dts: sun7i: Enable USB DRC on Wexler TAB7200

Chen-Yu Tsai (12):
      ARM: dts: sun6i: hummingbird: Add missing pinmux setting for gmac phy reset
      ARM: dts: sun6i: Add lradc node
      ARM: dts: sun6i: Add mmc2 pins for 8 bit emmc
      ARM: dts: sun8i: Add PWM controller node for A23/A33
      ARM: dts: sun8i: Add PWM channel 0 pinmux setting for A23/A33
      ARM: dts: sun8i: Add pwm-backlight device for A23/A33 Q8 format tablets
      ARM: dts: sun8i-a33: Add security system crypto engine clock and device nodes
      ARM: dts: sun6i: hummingbird: Add aliases for rtc devices
      ARM: dts: sun8i: Add Reduced Serial Bus controller device node to A23/A33 dtsi
      ARM: dts: sun8i: q8-common: Enable RSB controller for A23/A33 Q8 tablets
      ARM: dts: sun8i: sinlinx-sina33: Enable Reduced Serial Bus controller
      ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and DC5LDO supplies

Hans de Goede (21):
      ARM: dts: sun4i: Enable otg in host only mode on Jesurun Q5
      ARM: dts: sun4i: Enable i2c1 and i2c2 on the Chuwi V7-CW0825 tablet
      ARM: dts: sun6i: Columbus: Add i2c controller for communicating with the LCD
      ARM: dts: sun5i: Add simplefb node for tvencoder output
      ARM: dts: sun8i: Add support for qt90h-v4 tablets
      ARM: dts: sun5i: Add support for the Auxtek-T003 HDMI stick
      ARM: dts: sun4i: inet97fv2: Disable unused usb controllers
      ARM: dts: sun4i: inet97fv2: Add regulator nodes
      ARM: dts: sun4i: inet97fv2: Enable otg controller
      ARM: dts: sun4i: inet97fv2: Enable support for tablet keys
      ARM: dts: sun4i: inet97fv2: Enable i2c1 and i2c2 controllers
      ARM: dts: sun5i: Add dts file for inet98v_rev2 based tablets
      ARM: dts: sunxi: Add sun?i-q8-common.dtsi files for q8 tablets
      ARM: dts: sun4i: Add dts file inet9f-rev03 based tablets
      ARM: dts: sun4i: Add dts file for iNet-1 based tablets
      ARM: dts: sun5i: Add sun5i-q8-common.dtsi
      ARM: dts: sun5i: Add dts file for q8 formfactor a13 based tablets
      ARM: dts: sun8i: Add sun8i-a33-q8-tablet.dts file
      ARM: dts: sun8i: Make ippo-q8h-v1.2.dts a symlink to q8-tablet.dts
      ARM: dts: axp209: Add usb_power_supply child node to the ax209 node
      ARM: dts: sun7i: Enable USB DRC on orangepi-mini

Jelle de Jong (1):
      ARM: dts: sun7i: Add dts file for Wits Pro A20 DKT

Jelle van der Waa (4):
      ARM: dts: sun7i: Add regulator configuration to the pcduino3 dts file
      ARM: dts: sun7i: Enable USB DRC on pcDuino 3
      ARM: dts: sun5i: Add emac_pins_b definition
      ARM: dts: sun5i: Add dts file for the Wobo i5 top set box

Lawrence Yu (1):
      ARM: dts: sun6i: Add support for Yones Toptech bs1078v2 tablets

Marcus Cooper (1):
      ARM: sun7i: dt: Add new Olimex A20 EVB device

Maxime Ripard (3):
      ARM: sun8i: Add the A33 AHB1 gates clock driver
      ARM: sun8i: Move A23 AHB1 gates out of common DTSI
      ARM: sun8i: A23: Add missing msgbox gate

Olliver Schinagl (6):
      ARM: dts: sunxi: enable otg port on the sun7i-a20-olinuxino-lime2
      dts: sunxi: add eeprom to A10 OLinuXino Lime board
      dts: sunxi: correct vendor prefix on OLinuXino a10s micro
      dts: sunxi: add eeprom to A20 OLinuXino Lime board
      dts: sunxi: add eeprom to A20 OLinuXino Lime2 board
      dts: sunxi: add eeprom to A20 OLinuXino micro board

Priit Laes (1):
      ARM: dts: sun4i: gemei-g9: Add accelerometer (bma250) IRQ

Ralph Benadski (1):
      ARM: dts: sun7i: Enable USB DRC on cubieboard2

Reinder de Haan (1):
      ARM: dts: sun7i: Enable USB DRC on the Orange pi

Sander Vermin (1):
      ARM: dts: sun6i: Add accelerometer on Columbus A31

Siarhei Siamashka (1):
      ARM: dts: sun4i: Add AXP209 PMU regulators for pcDuino1/2

Yassin Jaffer (1):
      ARM: dts: sun7i: Add keypad clk node

 arch/arm/boot/dts/Makefile                         |  15 +-
 arch/arm/boot/dts/axp209.dtsi                      |   5 +
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  12 ++
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  11 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              | 226 ++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          | 117 ++++++++++-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       | 227 +++++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |  15 ++
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |  19 ++
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |  12 ++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |  35 +++-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       | 159 +++++++++++++++
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |   2 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           | 224 ++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  20 ++
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts      | 227 +++++++++++++++++++++
 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts          |  60 ++++++
 arch/arm/boot/dts/sun5i-q8-common.dtsi             | 170 +++++++++++++++
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |  24 +++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  13 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  17 ++
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     | 134 ++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  19 ++
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     | 198 ++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |  12 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |  47 +++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   6 +
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |  29 +++
 arch/arm/boot/dts/sun7i-a20-orangepi.dts           |  29 +++
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |  54 ++++-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |  33 ++-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   | 226 ++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   8 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |  61 +++---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts           | 145 +++++++++++++
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts        |  76 +------
 arch/arm/boot/dts/sun8i-a23.dtsi                   |  25 +++
 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts      | 134 +-----------
 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts          |  65 ++++++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   4 +
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  45 ++++
 arch/arm/boot/dts/sun8i-q8-common.dtsi             | 101 +++++++++
 arch/arm/boot/dts/sunxi-q8-common.dtsi             |  77 +++++++
 43 files changed, 2879 insertions(+), 259 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-inet1.dts
 create mode 100644 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-q8-tablet.dts
 create mode 100644 arch/arm/boot/dts/sun5i-q8-common.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a33-ippo-q8h-v1.2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a33-q8-tablet.dts
 create mode 100644 arch/arm/boot/dts/sun8i-q8-common.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-q8-common.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/793ccec0/attachment-0001.sig>
