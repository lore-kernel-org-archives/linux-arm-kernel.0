From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 27 Jan 2016 10:57:41 +0800
Subject: [PATCH v4 0/2] regulator: act8945a: add regulator driver for the
 sub-device of ACT8945A MFD
Message-ID: <1453863463-30515-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACT8945A is a Multi Function Device with the following subdevices:
 - Regulator
 - Charger

This patch set is to add regulator driver for ACT8945A.
It is based on the patch set:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/402199.html

Changes in v4:
 - change the name "act8945a-pmic" to "act8945a-regulator"
   to align mfd subdevice's name.

Changes in v3:
 - use the core regulators_node and of_match implementation,
   remove the redundant code.
 - use the core dev_get_regmap(dev->parent) code, remove
   the redundant code.
 - change the regulator name to easily implement macro.
 - use a space after #define, not tabs.
 - add OF match table.

Changes in v2:
 - add more help information in Kconfig.
 - update the file header with short version license and author line.
 - remove unused structure, struct act8945a_pmic.
 - substitute of_property_read_bool() for of_get_property().
 - due to removing the member of stuct act8945a_dev, dev.
 - remove the unnecessary print out.
 - use module_platform_driver(), instead of subsys_initcall().
 - substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").
 - add Acked-by Rob Herring.

Wenyou Yang (2):
  regulator: act8945a: add regulator driver for ACT8945A
  regulator: add documentation for ACT8945A's regulator DT bindings

 .../bindings/regulator/act8945a-regulator.txt      |   78 +++++++++
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/act8945a-regulator.c             |  172 ++++++++++++++++++++
 4 files changed, 260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
 create mode 100644 drivers/regulator/act8945a-regulator.c

-- 
1.7.9.5
