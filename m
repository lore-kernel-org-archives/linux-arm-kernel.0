From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 12 Jan 2016 16:17:07 +0800
Subject: [PATCH v2 0/2] regulator: act8945a: add regulator driver for the
 sub-device of ACT8945A MFD
Message-ID: <1452586629-1117-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACT8945A is a Multi Function Device with the following subdevices:
 - Regulator
 - Charger

This patch set is to add regulator driver for ACT8945A.
It is based on the patch set:
	[PATCH v2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver

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

 .../bindings/regulator/act8945a-regulator.txt      |   78 ++++++
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/act8945a-regulator.c             |  267 ++++++++++++++++++++
 4 files changed, 355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
 create mode 100644 drivers/regulator/act8945a-regulator.c

-- 
1.7.9.5
