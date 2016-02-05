From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 5 Feb 2016 12:26:06 +0800
Subject: [PATCH v8 0/2] power: act8945a: add charger driver for the sub-device
 of ACT8945A MFD
Message-ID: <1454646368-18193-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACT8945A is a Multi Function Device with the following subdevices:
 - Regulator
 - Charger

This patch set is to add regulator driver for ACT8945A.
It is based on the patch set:
	http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/405258.html

Changes in v8:
 - remove the OF table.
 - due to the mfd cell .of_compatible removal, use the platform
   device's parent of_node to read the property and assign it
   to the psy_cfg.of_node.
 - fix the typo.
 - due the mfd cell .of_compatible removal, update the compatibe
   description and example.

Changes in v7:
 - use the helper dev_get_regmap(pdev->dev.parent, NULL) to get regmap.
 - remove *act8945a_dev member from struct act8945a_charger.
 - remove *psy member from struct act8945a_charger.
 - merge _parse_dt() and _charger_config() functions, remove relevent
   members from struct act8945a_charger.
 - remove unused platform_set_drvdata(pdev, charger) statement.

Changes in v6:
 - change the type value to unsigned int.

Changes in v5:
 - remove spare spaces after #define.
 - add OF match table.
 - collect Reviewed-by from Krzysztof.

Changes in v4:
 - use spaces after #define, not tabs.
 - use BIT(n) macros to substitute (0x01 << x).
 - change dt properties with more legible name.
 - change the properties with more legible name, clearer description.

Changes in v3:
 - update the file header with short version license and author line.
 - remove unused member of struct act8945a_charger, dev.
 - action due to removing the member of stuct act8945a_dev, dev.
 - remove the unnecessary print out.
 - remove the unnecessary act8945a_charger_remove().
 - fix align of the code-style.

Changes in v2:
 1./ Substitute of_property_read_bool() for of_get_property().
 2./ Substitute devm_power_supply_register() for power_supply_register().
 3./ Use module_platform_driver(), instead of subsys_initcall().
 4./ Substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").

Wenyou Yang (2):
  power: act8945a: add charger driver for ACT8945A
  power: add documentation for ACT8945A's charger DT bindings

 .../devicetree/bindings/power/act8945a-charger.txt |   35 ++
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/act8945a_charger.c                   |  355 ++++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
 create mode 100644 drivers/power/act8945a_charger.c

-- 
1.7.9.5
