From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 27 Sep 2010 14:32:22 +0200
Subject: [PATCH v3 0/5] mfd: regulator: max8998: BUCK1/2 control augmented by
	GPIO pins
Message-ID: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series provides the "fast patch" for BUCK1/2 voltage setting. When requested
voltage is required and it is available at MAX8998 internal registers, no I2C communication
is performed and voltage is changed by GPIO setting.

For BUCK1 two predefined, maximum voltages may be defined. BUCK2 allows for one such 
value definition.

Changes v3:
- GPIOs not defined at platform data ( i.e. = 0) are causing WARN_ON
- patches are presenting changes in the driver in a more clear way
- ability to add predefined (preferably maximal) voltage values
- no constants used when predefined voltage values defined
- checks if driver is operating at valid GPIOs 

Lukasz Majewski (5):
  mfd: regulator: max8998: separate set_voltage for ldo and buck
  mfd: regulator: max8998: Support for chips compliant with max8998
  mfd: regulator: max8998: BUCK1/2 internal voltages and their index
    added
  mfd: regulator: max8998: voltages and GPIOs added to platform data
    structure
  mfd: regulator: max8998: BUCK1/2 voltage change with use of GPIOs

 drivers/mfd/max8998.c               |    5 +-
 drivers/regulator/max8998.c         |  257 ++++++++++++++++++++++++++++++++---
 include/linux/mfd/max8998-private.h |   23 +++-
 include/linux/mfd/max8998.h         |   12 ++
 4 files changed, 268 insertions(+), 29 deletions(-)
