From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Dec 2015 13:53:48 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.5
Message-ID: <20151214125348.GA28370@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a bunch of DT changes for the Allwinner SoCs for the 4.5 merge
window.

Maxime

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.5

for you to fetch changes up to 2367cee5fda1e9ebc605b13175492b31030acd9d:

  ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3 (baseboard SD socket) (2015-12-11 09:21:29 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.5

Allwinner device-tree related patches for the 4.5 merge window.
  * Support for the H3
  * Addition of the RSB to the relevant devices (sun8i, sun9i)
  * Addition of the Video Engine clocks for the older SoCs (sun4i, sun7i)
  * Addition of the DRAM gates for the older SoCs (sun4i, sun7i)
  * Addition of the audio codec to a bunch of boards
  * New board: ICNova SWAC

----------------------------------------------------------------
Adam Sampson (1):
      ARM: sun7i: dt: Enable audio codec on pcDuino V3 Nano

Aleksei Mamlin (1):
      ARM: dts: sun7i: Enable audio codec on Wexler TAB7200 tablet.

Chen-Yu Tsai (17):
      ARM: dts: sun8i: Add simplefb node labels to reference at board level
      ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes
      ARM: dts: sun9i: Add TODO comments for the main and low power clocks
      ARM: dts: sun9i: Add A80 R_PIO pin controller device node
      ARM: dts: sun9i: optimus: Enable LED3
      ARM: dts: sun9i: Add consumer IR receiver device node and pinmux settings
      ARM: dts: sun9i: optimus: Enable consumer IR receiver
      ARM: dts: sun9i: Add Reduced Serial Bus controller device node to A80 dtsi
      ARM: dts: sun9i: optimus: Enable Reduced Serial Bus controller
      ARM: dts: sun9i: Add NMI controller device node
      ARM: dts: sun4i: Add DRAM gates
      ARM: dts: sun7i: Add DRAM gates
      ARM: dts: sun4i: Add VE (Video Engine) module clock node
      ARM: dts: sun7i: Add VE (Video Engine) module clock node
      ARM: dts: sun9i: cubieboard4: Enable LEDs
      ARM: dts: sun9i: cubieboard4: Enable consumer IR receiver
      ARM: dts: sun9i: cubieboard4: Enable Reduced Serial Bus controller

Hans de Goede (7):
      ARM: dts: sun4i: inet9f-rev03: Add support for game buttons / joysticks
      ARM: dts: sun4i: Enable onboard codec used on the iNet1 tablet
      ARM: dts: sun4i: Add backlight node to iNet1 tablet
      ARM: dts: sun5i: Add backlight node to UTOO P66 tablet
      ARM: dts: sun4i: Add backlight node to pov protab2 ips9 tablet
      ARM: dts: sun4i: Add touchscreen node to iNet1 tablet
      ARM: dts: sun4i: Add touchscreen node to pov protab2-ips9 tablet

Jelle van der Waa (1):
      ARM: dts: sun7i: Enable audio codec on pcDuino

Jens Kuske (2):
      ARM: dts: sunxi: Add Allwinner H3 DTSI
      ARM: dts: sun8i: Add Orange Pi Plus support

Karsten Merker (2):
      ARM: dts: sun7i: Olimex A20-SOM-EVB: Add LRADC keys
      ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3 (baseboard SD socket)

Lawrence Yu (1):
      dts: sun6i: yones toptech bs1078 v2: Add AXP221 support to dts

Marcus Weseloh (1):
      ARM: dts: sun4i: Enable audio codec on Olimex A20-SOM-EVB

Michael van Slingerland (1):
      ARM: dts: sun5i: Add i2c axp152 pmic support for Auxtek T004 boards

Priit Laes (3):
      ARM: dts: sun4i: gemei-g9: Convert to use axp209 regulator nodes
      ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of reg_vcc3v0
      ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec support

Stefan Monnier (2):
      ARM: dts: sun7i: Enable audio codec on OrangePi Mini
      ARM: dts: sun7i: Enable audio codec on BananaPi

Stefan Roese (1):
      arm: sun7i: Add sun7i-a20-icnova-swac.dts

 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |  42 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |  48 ++
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       | 164 +++++++
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |  47 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  45 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |  14 +
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts           |  16 +
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts     |  85 +++-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |   4 +
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        | 169 +++++++
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  77 ++++
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts      |   4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |   4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |   4 +
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |   4 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  41 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  77 ++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 497 +++++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |  30 ++
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  24 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 159 ++++++-
 23 files changed, 1536 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/d9f52156/attachment.sig>
