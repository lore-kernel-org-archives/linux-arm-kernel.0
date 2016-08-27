From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 27 Aug 2016 15:55:36 +0800
Subject: [PATCH v2 0/8] mfd: axp20x: Add support for AXP806 PMIC
Message-ID: <20160827075544.26316-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of the AXP806 PMIC support series. The patch "regulator: core:
Try full range when adjusting regulators to constraints" has been dropped.
Other changes are inline in the patches.

This series adds support for X-Powers' AXP806 PMIC. This is the secondary
PMIC accompanying Allwinner's A80 SoC. For now, only the regulators are
supported. While the AXP806 supports standalone operation, no hardware
exists, so this will not be supported.

Patch 1 adds AXP806 to the axp20x bindings.

Patch 2 adds AXP806 support to the axp20x mfd driver.

Patch 3 adds AXP806 support to the axp20x regulator driver.

Patch 4 adds the unused SW switch output of the AXP809 PMIC on the A80
Optimus board. This was accidentally left out of the AXP809 series.

Patch 5 adds the unused SW switch output of the AXP809 PMIC on the
Cubieboard 4. This was accidentally left out of the AXP809 series.

Patch 6 enables AXP809 support on the A80 Optimus board.

Patch 7 enables AXP809 support on the Cubieboard 4.

Patch 8 disables EHCI1 on the A80 Optimus board.


Regards
ChenYu

Chen-Yu Tsai (8):
  mfd: axp20x: Add bindings for AXP806 PMIC
  mfd: axp20x: Add support for AXP806 PMIC
  regulator: axp20x: support AXP806 variant
  ARM: dts: sun9i: a80-optimus: Declare AXP809 SW regulator as unused
  ARM: dts: sun9i: cubieboard4: Declare AXP809 SW regulator as unused
  ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC device node and
    regulators
  ARM: dts: sun9i: cubieboard4: Add AXP806 PMIC device node and
    regulators
  ARM: dts: sun9i: a80-optimus: Disable EHCI1

 Documentation/devicetree/bindings/mfd/axp20x.txt |  28 +++++-
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts      | 116 +++++++++++++++++++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts          | 123 ++++++++++++++++++++++-
 drivers/mfd/axp20x-rsb.c                         |   1 +
 drivers/mfd/axp20x.c                             |  72 +++++++++++++
 drivers/regulator/axp20x-regulator.c             | 118 ++++++++++++++++++++--
 include/linux/mfd/axp20x.h                       |  60 +++++++++++
 7 files changed, 507 insertions(+), 11 deletions(-)

-- 
2.9.3
