From: zhouqiao@marvell.com (Qiao Zhou)
Date: Thu, 28 Jun 2012 11:13:31 +0800
Subject: [PATCH 0/3 V1] add 88pm80x mfd driver
Message-ID: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change log [v1]:
1, pm800 and pm805 are decoupled and probed separately;
2, re-used the most of API for pm800 and pm805 per Arnd's comments;
3, use regmap_irq, instead of previous 88pm80x_irq_data per Mark's comments.
use regmap_add_irq_chip, and remove previous 88pm80x irq handling.
4, remove callback function in rtc pdata per Arnd's comments.
5, updated some coding style issue.

Qiao Zhou (3):
  mfd: support 88pm80x in 80x driver
  rtc: add rtc support to 88PM80X PMIC
  input: add onkey support to 88PM80X PMIC

 drivers/input/misc/88pm80x_onkey.c |  194 ++++++++++
 drivers/input/misc/Kconfig         |   10 +
 drivers/input/misc/Makefile        |    1 +
 drivers/mfd/88pm80x-core.c         |  545 +++++++++++++++++++++++++++++
 drivers/mfd/88pm80x-i2c.c          |  274 +++++++++++++++
 drivers/mfd/Kconfig                |   12 +
 drivers/mfd/Makefile               |    2 +
 drivers/rtc/Kconfig                |   10 +
 drivers/rtc/Makefile               |    1 +
 drivers/rtc/rtc-88pm80x.c          |  370 ++++++++++++++++++++
 include/linux/mfd/88pm80x.h        |  678 ++++++++++++++++++++++++++++++++++++
 11 files changed, 2097 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c
 create mode 100644 drivers/mfd/88pm80x-core.c
 create mode 100644 drivers/mfd/88pm80x-i2c.c
 create mode 100644 drivers/rtc/rtc-88pm80x.c
 create mode 100644 include/linux/mfd/88pm80x.h
