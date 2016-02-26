From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Feb 2016 11:47:18 -0800
Subject: [GIT PULL] arm: Allwinner DT changes for 4.6
Message-ID: <20160226194718.GA21116@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.6

for you to fetch changes up to d250d17d4f9b2d3d14d20cf6c70da8da7676848b:

  ARM: dts: sun8i: Add leds and switch on Orangepi Plus boards (2016-02-26 11:37:15 -0800)

----------------------------------------------------------------
Allwinner DT Additions for 4.6

Quite a few changes, among which:
  - Support for the A83t
  - Support for the eMMC DDR on a few boards
  - Support for the OTG controller on a few boards
  - New boards: Itead Ibox, Cubietruck plus, Homlet v2, Lamobo R1

----------------------------------------------------------------
Chen-Yu Tsai (14):
      ARM: dts: sun8i: Add watchdog device node for A83T
      ARM: dts: sun8i: Add device tree for Cubietruck Plus
      ARM: dts: sun8i: sina33: Enable hardware reset and HS-DDR for eMMC
      ARM: dts: sun9i: Use sun9i specific mmc compatible
      ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
      ARM: dts: sun6i: sina31s: Switch to mmc3 for onboard eMMC
      ARM: dts: sun8i: Include SDC2_RST pin in mmc2_8bit_pins
      ARM: dts: sun9i: Include SDC2_RST pin in mmc2_8bit_pins
      ARM: dts: sun9i: a80-optimus: Enable hardware reset and HS-DDR for eMMC
      ARM: dts: sun9i: cubieboard4: Enable hardware reset and HS-DDR for eMMC
      ARM: dts: sun9i: a80-optimus: Remove i2c3 and uart4
      ARM: dts: sun8i-a83t: Correct low speed oscillator clocks
      ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device and regulator nodes
      ARM: dts: sun8i: q8-common: Add AXP223 PMIC device and regulator nodes

Hans de Goede (4):
      ARM: dts: sun4i: Add touchscreen node to inet9f-rev03 tablet dts file
      ARM: dts: sun4i: Add touchscreen node to chuwi-v7 dts file
      ARM: dts: sun4i: Add touchscreen node to inet97fv2 dts file
      ARM: dts: sun8i: Add ir receiver nodes to H3 dtsi

Jelle de Jong (1):
      ARM: dts: sun7i: Add dts file for the lamobo-r1 board

Krzysztof Adamski (4):
      ARM: dts: sunxi: Fix #interrupt-cells for PIO in H3
      dts: sun8i-h3: Add APB0 related clocks and resets
      ARM: dts: sun8i-h3: Add R_PIO controller node to the dtsi
      ARM: dts: sun8i: Add leds and switch on Orangepi Plus boards

Marcus Cooper (6):
      ARM: dts: sunxi: Add sunxi-itead-core-common.dtsi
      ARM: dts: sun7i: Add Itead Ibox support
      ARM: dts: sun4i: Itead Iteaduino to use common code
      ARM: dts: sun7i: Enable USB DRC on MK808C
      ARM: dts: sun7i: Enable USB DRC on Olimex A20 EVB
      ARM: dts: sun4i: Enable USB DRC on the MK802

Maxime Ripard (1):
      ARM: sun5i: chip: Add CPU regulator for cpufreq

Peter Korsgaard (1):
      ARM: dts: sun4i: Enable USB DRC on Hyundai-a7hd

Vishnu Patekar (3):
      ARM: dts: sun8i: Add Allwinner A83T dtsi
      ARM: dts: sun8i: Add A83T HomletV2 Board by Allwinner
      ARM: dts: sun8i: Enable timer node for A83T

 arch/arm/boot/dts/Makefile                         |   4 +
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |  10 +
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |  34 +++
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |  10 +
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   9 +
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |  86 +-----
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |  33 +++
 arch/arm/boot/dts/sun5i-r8-chip.dts                |   4 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  10 +
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi     |   6 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         | 125 +++++++++
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          | 287 +++++++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |  35 +++
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |  32 +++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  79 +++++-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |  64 +++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  65 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 228 ++++++++++++++++
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  57 ++++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  64 ++++-
 arch/arm/boot/dts/sun8i-q8-common.dtsi             |  83 +++++-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        |   6 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  28 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |  11 +-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi     | 136 ++++++++++
 26 files changed, 1388 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-a83t.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-itead-core-common.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/56aef42d/attachment.sig>
