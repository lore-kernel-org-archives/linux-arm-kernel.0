From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  1 Jun 2016 00:23:18 +0800
Subject: [PATCH resend v2 0/6] regulator: axp20x: Add support for AXP809 PMIC
Message-ID: <1464711804-19256-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

These are the remaining patches of my AXP809 PMIC support series. The
mfd parts and regulator fixes were merged in v4.7-rc1. What's left are
the AXP809 regulator driver and dts changes.

Patch 1 adds AXP809 support to the axp20x regulator driver. This patch
depends on patch 3, and patches already in regulator/topic/axp20x.

Patch 2 adds a dtsi file for AXP809.

Patch 3 enables AXP809 support on the A80 Optimus board.

Patch 4 enables AXP809 support on the Cubieboard 4.

Patch 5 disables the dummy regulators from sunxi-common-regulators.dtsi
on the A80 Optimus board. These aren't used in the board DTS anymore.

Patch 6 disables the dummy regulators from sunxi-common-regulators.dtsi,
on the Cubieboard4. These aren't used in the board DTS anymore.


Chen-Yu Tsai (6):
  regulator: axp20x: support AXP809 variant
  ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
  ARM: dts: sun9i: a80-optimus: Add AXP809 PMIC device node and
    regulators
  ARM: dts: sun9i: cubieboard4: Add AXP809 PMIC device node and
    regulators
  ARM: dts: sun9i: a80-optimus: Disable dummy regulators vcc3v0, vcc3v3,
    vcc5v0
  ARM: dts: sun9i: cubieboard4: Disable dummy regulators vcc3v0, vcc3v3,
    vcc5v0

 .../dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} |  98 ++------------
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 143 ++++++++++++++++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            | 143 ++++++++++++++++++++-
 drivers/regulator/axp20x-regulator.c               | 119 ++++++++++++-----
 4 files changed, 380 insertions(+), 123 deletions(-)
 copy arch/arm/boot/dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} (52%)

-- 
2.8.1
