From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 20 Jul 2015 15:36:31 +0800
Subject: regulator: MT6311: Add support for MT6311 regulator 
Message-ID: <1437377793-31558-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT6311 is PMIC IC which includes the following analog functions,
and is fully controlled by an I2C-compatible serial interface.
- BUCK: Provides regulated lower output voltage level from Li-Ion battery
- Sink LDO: One sink current LDO for enhancement DRAM driver reliability

This patch set adds support for the MediaTek PMIC MT6311 regulator driver,
which adds MT6311 related buck/ldo voltage data to the driver,
and creates the regulator_desc table.

Henry Chen (2):
  dt-bindings: Add document for MT6311 regulator
  regulator: MT6311: Add support for MT6311 regulator

 .../bindings/regulator/mt6311-regulator.txt        |  34 +++
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mt6311-regulator.c               | 272 +++++++++++++++++++++
 drivers/regulator/mt6311-regulator.h               |  65 +++++
 include/linux/regulator/mt6311.h                   |  39 +++
 6 files changed, 420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6311-regulator.txt
 create mode 100644 drivers/regulator/mt6311-regulator.c
 create mode 100644 drivers/regulator/mt6311-regulator.h
 create mode 100644 include/linux/regulator/mt6311.h

-- 
1.8.1.1.dirty
