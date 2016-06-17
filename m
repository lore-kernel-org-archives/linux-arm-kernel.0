From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 17 Jun 2016 08:10:27 +0200
Subject: [RESEND v7 0/6] regulator: mfd: max8997: Add regmap
Message-ID: <1466143833-5856-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

I'm pushing old Robert's work and I miss only ack from you.
Could you take a look at patch 1/6?


Changes since v6
================
1. Add some acks.
2. Remove patches already applied.


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  extcon: max8997: Fix handling error code of regmap_irq_get_virq()
  rtc: max8997: Check for ERRNO of regmap_irq_get_virq()
  extcon: max8997: Fix inconsistent indenting

Robert Baldyga (3):
  mfd: max8997: Use regmap to access registers
  mfd: max8997: handle IRQs using regmap
  mfd: max8997: Change irq names to upper case

 drivers/extcon/extcon-max8997.c       |  72 +++----
 drivers/input/misc/max8997_haptic.c   |  34 +--
 drivers/leds/leds-max8997.c           |  13 +-
 drivers/mfd/Kconfig                   |   3 +-
 drivers/mfd/Makefile                  |   2 +-
 drivers/mfd/max8997-irq.c             | 383 ----------------------------------
 drivers/mfd/max8997.c                 | 245 +++++++++++++++-------
 drivers/power/max8997_charger.c       |  33 +--
 drivers/regulator/max8997-regulator.c |  87 ++++----
 drivers/rtc/rtc-max8997.c             |  60 +++---
 include/linux/mfd/max8997-private.h   |  82 ++++++--
 11 files changed, 385 insertions(+), 629 deletions(-)
 delete mode 100644 drivers/mfd/max8997-irq.c

-- 
1.9.1
