From: henryc.chen@mediatek.com (Henry Chen)
Date: Thu, 23 Jul 2015 11:39:57 +0800
Subject: [PATCH v3] regulator: mt6311: Add support for MT6311 regulator 
Message-ID: <1437622799-28115-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the MediaTek PMIC mt6311 regulator driver,
 which adds mt6311 related buck/ldo voltage data to the driver,
 and creates the regulator_desc table.

Changes in v3:
- Removed the struct mt6311 since the members of mt6311 were not be necessary.

Changes in v2:
- Re-ordered the sequence of makefile and Kconfig.
- Specifying the regulator DT bindings by providing of_match and 
regulators_node in the regulator_desc and delete the DT handling code.


Henry Chen (2):
  dt-bindings: regulator: mt6311: Add document for mt6311 regulator
  regulator: mt6311: Add support for mt6311 regulator

 .../bindings/regulator/mt6311-regulator.txt        |  35 ++++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6311-regulator.c               | 183 +++++++++++++++++++++
 drivers/regulator/mt6311-regulator.h               |  65 ++++++++
 include/linux/regulator/mt6311.h                   |  29 ++++
 6 files changed, 322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
 create mode 100644 drivers/regulator/mt6311-regulator.c
 create mode 100644 drivers/regulator/mt6311-regulator.h
 create mode 100644 include/linux/regulator/mt6311.h

-- 
1.8.1.1.dirty
