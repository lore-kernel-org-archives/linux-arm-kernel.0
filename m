From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 17 Oct 2015 18:43:25 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 2
Message-ID: <20151017164325.GA13024@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following pull request for the DT changes for the next
merge window, that comes on top of the first one.

Thanks!
Maxime

The following changes since commit 52095d179c5b3254fa87aaa6990e164c5cf21e12:

  ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and DC5LDO supplies (2015-10-07 11:34:54 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.4-2

for you to fetch changes up to c2aa565107fb539a84494fe8dac5fd5eb5678123:

  ARM: dts: sun6i: Add a dts file for the Sinovoip BPI-M2 board (2015-10-17 18:24:11 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.4, round 2

More DT patches for 4.4, mostly with new boards coming in (CHIP, BananaPi
M2, pcduino2), further consolidation for the q8-based designs and a bunch
of random patches enhancing support for existing boards

----------------------------------------------------------------
Adam Sampson (2):
      ARM: dts: sun7i: Correct USB regulators on pcDuino v3 Nano
      ARM: dts: sun7i: Add regulator configuration for pcDuino v3 Nano

Chen-Yu Tsai (6):
      ARM: dts: sunxi: Add dtsi for AXP22x PMIC
      ARM: dts: sunxi: Enable PWM controller on Q8 format tablets
      ARM: dts: sun6i: hummingbird: Fix VDD-CPU and VDD-GPU regulator names
      ARM: dts: sun6i: hummingbird: Use axp22x.dtsi for AXP221 regulators
      ARM: dts: sun6i: hummingbird: Enable AXP221 DC5LDO regulator as "vdd-cpus"
      ARM: dts: sun8i: Add NMI interrupt controller node

Hans de Goede (11):
      ARM: dts: sun7i: Enable USB DRC on Bananapi
      ARM: dts: sun5i: Add PWM controller node for A13 / A10s
      ARM: dts: sun5i: Add PWM channel 0 pinmux setting for A13/A10s
      ARM: dts: sun5i: Add backlight node to sun5i-q8-common.dtsi
      ARM: dts: sun8i: Add sun8i-a23-q8-tablet.dts file
      ARM: dts: sun8i: Make ippo-q8h-v*.dts a symlink to q8-tablet.dts
      ARM: dts: sun8i: Make et-q8-v1.6.dts a symlink to q8-tablet.dts
      ARM: dts: sun6i: Turn on gmac on Colombus
      ARM: dts: sunxi: Fix interrupt-cells for [r]pio on A23/A31/A33/A80
      ARM: dts: sun6i: Add mmc2_pins_a pinmux setting to sun6i-a31.dtsi
      ARM: dts: sun6i: Add a dts file for the Sinovoip BPI-M2 board

Maxime Ripard (4):
      ARM: sun5i: Add R8 DTSI
      ARM: sun5i: dt: Move uart3 pinctrl node to common DTSI
      ARM: sun5i: dt: Add UART3 CTS and RTS pins
      ARM: sun5i: Add C.H.I.P DTS

Siarhei Siamashka (3):
      ARM: dts: sun4i: Allow to use the PH6 pin for GPIO on pcDuino1/2
      ARM: sun4i: dt: Add new LinkSprite pcDuino2 board
      ARM: dts: sun4i: Enable USB DRC on pcDuino1/2

Timo Sigurdsson (1):
      ARM: dts: sunxi: Add regulators for LeMaker BananaPi

 arch/arm/boot/dts/Makefile                       |   8 +-
 arch/arm/boot/dts/axp22x.dtsi                    | 143 +++++++++++++++
 arch/arm/boot/dts/sun4i-a10-pcduino.dts          |  29 ++-
 arch/arm/boot/dts/sun4i-a10-pcduino2.dts         |  78 +++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  15 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  10 ++
 arch/arm/boot/dts/sun5i-q8-common.dtsi           |  10 ++
 arch/arm/boot/dts/sun5i-r8-chip.dts              | 214 +++++++++++++++++++++++
 arch/arm/boot/dts/sun5i-r8.dtsi                  |  59 +++++++
 arch/arm/boot/dts/sun5i.dtsi                     |  21 +++
 arch/arm/boot/dts/sun6i-a31-colombus.dts         |  12 ++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      | 119 +++++++------
 arch/arm/boot/dts/sun6i-a31.dtsi                 |  12 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 194 ++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  74 +++++++-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts    |  46 +++--
 arch/arm/boot/dts/sun8i-a23-a33.dtsi             |   9 +
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts    |  55 +-----
 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts      |  75 +-------
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts        |  65 +++++++
 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts       |  89 +---------
 arch/arm/boot/dts/sun9i-a80.dtsi                 |   2 +-
 arch/arm/boot/dts/sunxi-q8-common.dtsi           |   6 +
 23 files changed, 1036 insertions(+), 309 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp22x.dtsi
 create mode 100644 arch/arm/boot/dts/sun4i-a10-pcduino2.dts
 create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts
 create mode 100644 arch/arm/boot/dts/sun5i-r8.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v1.2.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a23-ippo-q8h-v5.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts
 mode change 100644 => 120000 arch/arm/boot/dts/sun8i-a33-et-q8-v1.6.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151017/e5b7bb09/attachment.sig>
