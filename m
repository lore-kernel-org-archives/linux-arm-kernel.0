From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Mar 2016 17:22:23 +0800
Subject: [PATCH resend v2 0/9] mfd: axp20x: Add support for AXP809 PMIC
Message-ID: <1459243352-23344-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is a resend of v2 of the AXP809 PMIC support series. This adds
support for X-Powers' AXP809 PMIC. This is the primary PMIC accompanying
Allwinner's A80 SoC. For now, only the power button (PEK) and regulators
are supported. These are supported using existing axp20x drivers.

Driver patches are based on v4.6-rc1, while DT patches are based on
Maxime's sunxi/dt-for-4.7 branch.

Some regulator patches were merged into v4.6-rc1. Those have been
dropped from this series. Other than that there are no changes.

Patch 1 adds a MAINTAINERS entry for the X-Powers AXP PMICs.
I list myself as the maintainer.

Patch 2 adds AXP809 to the axp20x bindings.

Patch 3 adds AXP809 support to the axp20x mfd driver.

Patch 4 adds AXP809 support to the axp20x regulator driver.
This patch depends on patch 3.

Patch 5 adds a dtsi file for AXP809.

Patch 6 enables AXP809 support on the A80 Optimus board.

Patch 7 enables AXP809 support on the Cubieboard 4.

Patch 8 disables the dummy regulators from sunxi-common-regulators.dtsi
on the A80 Optimus board. These aren't used in the board DTS anymore.

Patch 9 disables the dummy regulators from sunxi-common-regulators.dtsi,
on the Cubieboard4. These aren't used in the board DTS anymore.


Regards
ChenYu

Chen-Yu Tsai (9):
  MAINTAINERS: Add entry for X-Powers AXP family PMIC drivers
  mfd: axp20x: Add bindings for AXP809 PMIC
  mfd: axp20x: Add support for AXP809 PMIC
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

 Documentation/devicetree/bindings/mfd/axp20x.txt   |  31 ++++-
 MAINTAINERS                                        |   6 +
 .../dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} |  98 ++------------
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 143 ++++++++++++++++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            | 143 ++++++++++++++++++++-
 drivers/mfd/axp20x-rsb.c                           |   1 +
 drivers/mfd/axp20x.c                               |  79 ++++++++++++
 drivers/regulator/axp20x-regulator.c               | 119 ++++++++++++-----
 include/linux/mfd/axp20x.h                         |  59 +++++++++
 9 files changed, 554 insertions(+), 125 deletions(-)
 copy arch/arm/boot/dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} (52%)

-- 
2.7.0
