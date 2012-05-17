From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Thu, 17 May 2012 19:09:25 +0530
Subject: [PATCH v2 0/2] regulator: Add initial suport for max77686
Message-ID: <1337261967-26004-1-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for max77686 which is a multifunction device which
includes regulator (pmic), rtc and charger sub-blocks within it. The support for
mfd driver and regulator driver are added by this patch series. This patch series
also includes device tree and irqdomain support for mfd and regulator portions.

Implemented the required modification, stated in the recieved review comments.
changes since V1:
-added regmap support.
-implemented .get_voltage_sel, .set_voltage_sel and .set_voltage_time_sel after
 removing .get_voltage and .set_voltage in regulator driver.
-used of_regulator_match() for parsing DT.
-added Documentation for Devive Tree binding.

This patch series is based on mark_regulator/for-next and has been tested on
GAIA board.

Yadwinder Singh Brar (2):
  mfd: Add support for MAX77686.
  regulator: Add support for MAX77686.

 Documentation/devicetree/bindings/mfd/max77686.txt |   63 +++
 drivers/mfd/Kconfig                                |   21 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/max77686-irq.c                         |  255 ++++++++++
 drivers/mfd/max77686.c                             |  322 ++++++++++++
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/max77686.c                       |  512 ++++++++++++++++++++
 include/linux/mfd/max77686-private.h               |  282 +++++++++++
 include/linux/mfd/max77686.h                       |  100 ++++
 10 files changed, 1566 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
 create mode 100644 drivers/mfd/max77686-irq.c
 create mode 100644 drivers/mfd/max77686.c
 create mode 100644 drivers/regulator/max77686.c
 create mode 100644 include/linux/mfd/max77686-private.h
 create mode 100644 include/linux/mfd/max77686.h
