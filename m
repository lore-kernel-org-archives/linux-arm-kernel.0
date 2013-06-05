From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  5 Jun 2013 12:34:35 +0400
Subject: [PATCH v2 0/4] leds: leds-mc13xxx
Message-ID: <1370421279-23348-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is series for add MC13892 LED support into mc13783 (mc13xxx) LED driver.
Further development of drivers I see it as follows:
I think that we need to replace all the variables from the platform_data
to the default register values (reg0=xxx, reg1=xxx etc.).
It is not too complicate the use of platform_data and will add DT-support
for the driver.
Comments are welcome.

Alexander Shiyan (4):
  leds: leds-mc13783: Prepare driver to support MC13892 LEDs
  leds: leds-mc13783: Add MC13892 LED support
  leds: leds-mc13783: Rename unit to indicate various MC13xxx chips
    support
  leds: leds-mc13xxx: Use module_platform_driver_probe for driver

 arch/arm/configs/imx_v4_v5_defconfig |   2 +-
 drivers/leds/Kconfig                 |   8 +-
 drivers/leds/Makefile                |   2 +-
 drivers/leds/leds-mc13783.c          | 391 -------------------------
 drivers/leds/leds-mc13xxx.c          | 545 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/mc13xxx.h          |  49 +++-
 6 files changed, 586 insertions(+), 411 deletions(-)
 delete mode 100644 drivers/leds/leds-mc13783.c
 create mode 100644 drivers/leds/leds-mc13xxx.c

-- 
1.8.1.5
