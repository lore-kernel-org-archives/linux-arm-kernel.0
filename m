From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 20 Jan 2016 14:40:33 +0800
Subject: [PATCH v6 0/2] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver
Message-ID: <1453272035-22233-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the Active-semi ACT8945A PMIC
MFD driver. It is a Multi Function Device with the following
subdevices:
 - Regulator
 - Charger

It is interfaced to the host controller using I2C interface,
ACT8945A is a child device of the I2C.

Changes in v6:
 - change MFD_ACT8945A type from bool to tristate.
 - revert depends on to 'I2C'.
 - change the regulator name.

Changes in v5:
 - change depends on to 'I2C=y'.

Changes in v4:
 - add a space before .compatible.
 - collect Reviewed-by from Krzysztof Kozlowski.

Changes in v3:
 - fix the tabbing errors in Example.
 - use "pmic at 5b" label, not "act8945a at 5b" in Example.
 - collect Acked-by from Rob.

Changes in v2:
 - add more help information in Kconfig.
 - update the file header with short version license and author line.
 - remove unused structure members (dev, i2c_client) of stuct act8945a_dev.
 - use define "PLATFORM_DEVID_NONE" for mfd_add_devices(), instead of '-1'.
 - use more explicit info to indicate the failure to add sub devices.
 - remove the unnecessary print out.
 - substitute MODULE_LICENSE("GPL") for MODULE_LICENSE("GPL v2").
 - use more specific label in Example.
 - add pmic and charger nodes in Example.

Wenyou Yang (2):
  mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver
  mfd: add documentation for ACT8945A DT bindings

 Documentation/devicetree/bindings/mfd/act8945a.txt |   82 +++++++++++++++
 drivers/mfd/Kconfig                                |   11 ++
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/act8945a.c                             |  109 ++++++++++++++++++++
 include/linux/mfd/act8945a.h                       |   21 ++++
 5 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/act8945a.txt
 create mode 100644 drivers/mfd/act8945a.c
 create mode 100644 include/linux/mfd/act8945a.h

-- 
1.7.9.5
