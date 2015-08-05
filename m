From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 5 Aug 2015 10:35:28 +0800
Subject: [PATCH v2 0/2] add a new driver to support SAMA5D4 watchdog timer
Message-ID: <1438742130-2089-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thank for Guenter's advice, add a new driver to support SAMA5D4 watchdog timer.

Because the watchdog WDT_MR register can be written more than once, its work
mechanism is different from the previous one. Open the device file to enable
the watchdog hardware, close to disable it, and ping it from the user space
directly to keep it alive.

Best Regards,
Wenyou Yang

Wenyou Yang (2):
  drivers: watchdog: add a driver to support SAMA5D4 watchdog timer
  Documentation: dt: binding: atmel-sama5d4-wdt: for SAMA5D4 watchdog
    driver

 .../bindings/watchdog/atmel-sama5d4-wdt.txt        |   35 +++
 drivers/watchdog/Kconfig                           |    9 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/at91sam9_wdt.h                    |    4 +
 drivers/watchdog/atmel_wdt.c                       |  290 ++++++++++++++++++++
 5 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
 create mode 100644 drivers/watchdog/atmel_wdt.c

-- 
1.7.9.5
