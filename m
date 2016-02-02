From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  2 Feb 2016 18:27:33 +0800
Subject: [PATCH 00/11] mfd: axp20x: Add support for AXP809 PMIC
Message-ID: <1454408864-24112-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for X-Powers' AXP809 PMIC. This is the primary
PMIC accompanying Allwinner's A80 SoC. For now, only the power button
(PEK) and regulators are supported. These are supported using existing
axp20x drivers. This is based on the AXP223 series v7.

Patch 1 adds a MAINTAINERS entry for the X-Powers AXP PMICs. I list
myself as the maintainer.

Patch 2 adds AXP809 to the axp20x bindings.

Patch 3 adds AXP809 support to the axp20x mfd driver.

Patch 4 removes voltage readout for switch outputs.

Patch 5 converts AXP20X LDO4 from using voltage tables to linear voltage
ranges. Either one works, but regulators found on later PMICs match up
with linear ranges better.

Patch 6 adds AXP809 support to the axp20x regulator driver. This patch
depends on the previous 3 patches. It's probably easier to apply them
together.

Patch 7 adds a dtsi file for AXP809.

Patch 8 enables AXP809 support on the A80 Optimus board.

Patch 9 enables AXP809 support on the Cubieboard 4.

Patch 10 disables the dummy regulators from sunxi-common-regulators.dtsi
on the A80 Optimus board. These aren't used in the board DTS anymore.

Patch 11 disables the dummy regulators from sunxi-common-regulators.dtsi,
on the Cubieboard4. These aren't used in the board DTS anymore.


Regards
ChenYu


Chen-Yu Tsai (11):
  MAINTAINERS: Add entry for X-Powers AXP family PMIC drivers
  mfd: axp20x: Add bindings for AXP809 PMIC
  mfd: axp20x: Add support for AXP809 PMIC
  regulator: axp20x: Remove voltage readout support for switch
    regulators
  regulator: axp20x: Use linear voltage ranges for AXP20X LDO4
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

 Documentation/devicetree/bindings/mfd/axp20x.txt   |  31 +++-
 MAINTAINERS                                        |   6 +
 .../dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} | 151 ++++++++++---------
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts        | 133 ++++++++++++++++-
 arch/arm/boot/dts/sun9i-a80-optimus.dts            | 133 ++++++++++++++++-
 drivers/mfd/axp20x-rsb.c                           |   1 +
 drivers/mfd/axp20x.c                               |  79 ++++++++++
 drivers/regulator/axp20x-regulator.c               | 165 ++++++++++++++-------
 include/linux/mfd/axp20x.h                         |  59 ++++++++
 9 files changed, 623 insertions(+), 135 deletions(-)
 copy arch/arm/boot/dts/{sun9i-a80-cubieboard4.dts => axp809.dtsi} (53%)

-- 
2.7.0
