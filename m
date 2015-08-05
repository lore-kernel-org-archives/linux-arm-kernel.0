From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 5 Aug 2015 16:57:20 +0800
Subject: [PATCH v3 0/2] add a new driver to support SAMA5D4 watchdog timer
Message-ID: <1438765043-11030-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Because the watchdog WDT_MR register can be written more than once,
its work mechanism is different from the at91sam9260 watchdog driver.
Open the device file to enable the watchdog hardware, close to disable it,
and ping it from the user space directly to keep it alive.

Thank for Guenter's review, the version 2.0 changes are listed as below.

Changes from v2.0
 1./ Use a specific driver name, at91_sama5d4_wdt.c.
 2./ Remove '-' at the end of macro name and unnecessary check.
 3./ Use alphabetic order for include files.

Wenyou Yang (2):
  drivers: watchdog: add a driver to support SAMA5D4 watchdog timer
  Documentation: dt: binding: atmel-sama5d4-wdt: for SAMA5D4 watchdog
    driver

 .../bindings/watchdog/atmel-sama5d4-wdt.txt        |   35 +++
 drivers/watchdog/Kconfig                           |    9 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/at91_sama5d4_wdt.c                |  279 ++++++++++++++++++++
 drivers/watchdog/at91sam9_wdt.h                    |    2 +
 5 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
 create mode 100644 drivers/watchdog/at91_sama5d4_wdt.c

-- 
1.7.9.5
