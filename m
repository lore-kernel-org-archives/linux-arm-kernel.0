From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 30 Sep 2015 14:39:44 +0800
Subject: [PATCH v2 0/3] regulator: axp20x: Drop AXP221 DC1SW/DC5LDO supplies
 from bindings
Message-ID: <1443595188-1283-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of "regulators: axp20x: Rename AXP221 DC1SW and DC5LDO supply
names". v2 removes the regulator supply properties for AXP221 DC1SW
and DC5LDO, instead of renaming them. These 2 regulators are secondary
outputs for DCDC1 and DCDC5 buck regulators, respectively, so they are
connected to them internally. This relationship should not be represented
in the device tree.


Patch 1 drops the AXP22X DC1SW/DC5LDO supply properties from the axp20x
DT bindings.

Patch 2 updates the axp20x regulator driver.

Patch 3 updates the only dts, the Hummingbird A31, that uses these
bindings.

If everything's ok, could we merge this for 4.4?

Thanks.


Regards,
ChenYu


Chen-Yu Tsai (3):
  mfd: axp20x: Drop AXP221 DC1SW and DC5LDO regulator supplies from
    bindings
  regulator: axp20x: set supply names for AXP22X DC1SW/DC5LDO internally
  ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and DC5LDO supplies

 Documentation/devicetree/bindings/mfd/axp20x.txt |  4 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts      |  2 -
 drivers/regulator/axp20x-regulator.c             | 54 ++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 8 deletions(-)

-- 
2.5.3
