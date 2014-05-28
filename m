From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 May 2014 19:11:04 +0200
Subject: [PATCH 0/5] regulator: Enhance AXP209 DT support
Message-ID: <1401297069-7423-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset modifies the regulator core and axp209 regulator driver
to be able to set in each regulators sub-node the supply, that should
be possible, given that it's documented as such in the bindings, but
is not at the moment, since whenever looking up the supply in the DT,
of_get_regulator will always look into the parent's device of_node
pointer.

This leads to a common pattern accross the regulators to have multiple
supply in the main device node, while it would be more intuitive yet
follow the documented bindings to look into the regulator sub-nodes
first.

Any comments are, of course, welcome.
Maxime

Maxime Ripard (5):
  regulator: Allow to pass the device node to regulator_dev_lookup
  regulator: Pass the config device node to regulator_dev_lookup
  regulator: axp20x: Update the bindings to use a local parent regulator
  mfd: axp209x: Drop the parent supplies field
  ARM: sun7i: cubieboard2: Enable the AXP209

 Documentation/devicetree/bindings/mfd/axp20x.txt | 22 +++++--------
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 41 +++++++++++++++++++++++
 drivers/mfd/axp20x.c                             | 11 -------
 drivers/regulator/axp20x-regulator.c             | 42 ++++++++++++++----------
 drivers/regulator/core.c                         | 16 ++++++---
 5 files changed, 87 insertions(+), 45 deletions(-)

-- 
1.9.3
