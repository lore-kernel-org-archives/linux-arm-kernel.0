From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 17 Jun 2014 09:38:36 +0200
Subject: [PATCH v4 0/7] mfd: axp20x: add AXP221 PMIC support
Message-ID: <1402990723-28138-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds basic support for X-Powers' AXP221 PMIC.

At the moment the MFD device only exposes AXP221 regulators but other
subdevices might be added later.

Best Regards,

Boris

Changes since v3:
 - rework mfd probe to avoid multiple AXP variant tests
 - add new compatible string to the DT bindings doc

Changes since v2:
 - add helper functions for regulator set registration
 - fix a copy/paste error in the axp20x mfd driver

Changes since v1:
 - merge code with the axp20x driver

Boris BREZILLON (7):
  mfd: axp20x: add AXP221 PMIC support
  regulator: axp20x: prepare support for multiple AXP chip families
  regulator: axp20x: add support for AXP221 regulators
  regulator: axp20x: reset probe data before each probe
  regulator: add support for regulator set registration
  regulator: axp20x: make use of devm_regulator_set_register
  mfd: AXP20x: add "x-powers,axp221" compatible string to DT bindings
    doc

 Documentation/devicetree/bindings/mfd/axp20x.txt |   2 +-
 drivers/mfd/axp20x.c                             |  64 ++++++-
 drivers/regulator/axp20x-regulator.c             | 202 ++++++++++++++++-------
 drivers/regulator/core.c                         | 106 ++++++++++++
 drivers/regulator/devres.c                       |  68 ++++++++
 include/linux/mfd/axp20x.h                       |  56 +++++++
 include/linux/regulator/driver.h                 |  51 ++++++
 7 files changed, 483 insertions(+), 66 deletions(-)

-- 
1.8.3.2
