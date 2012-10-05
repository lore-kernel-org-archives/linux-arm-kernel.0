From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Fri,  5 Oct 2012 12:16:05 +0200
Subject: [RFC PATCH v3 0/4] watchdog: core: dt: add support for the
 timeout-sec dt property
Message-ID: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
in the next revision i will add the s3c2410 driver.

changes:
v3:
  - rename watchdog_probe_dt_timeout ->  watchdog_init_timeout
  - move the watchdog_init_timeout function from inline to watchdog_core.c
  - add timeout parameter handling code to watchdog_init_timeout
  - add timeout-sec property to the pnx4008-wdt driver
  - add two small commit for fixup and cleanup
v2:
  - change "timeout" to "timeout-sec" as asked by Jean-Christophe
  - at91sam9_wdt: use the new helper function
  - at91sam9_wdt: add bounds checking
  - watchdog.h: add bounds checking 



Fabio Porcedda (4):
  watchdog: core: dt: add support for the timeout-sec dt property
  watchdog: add timeout-sec property binding to some drivers
  watchdog: orion_wdt: litte cleanup
  watchdog: WatchDog Timer Driver Core: fix comment

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 ++++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 ++++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 ++++
 Documentation/watchdog/watchdog-kernel-api.txt     |  4 ++++
 drivers/watchdog/Kconfig                           |  1 +
 drivers/watchdog/at91sam9_wdt.c                    | 17 ++++++++++----
 drivers/watchdog/orion_wdt.c                       | 13 ++++-------
 drivers/watchdog/pnx4008_wdt.c                     |  7 +++---
 drivers/watchdog/watchdog_core.c                   | 27 ++++++++++++++++++++++
 include/linux/watchdog.h                           |  6 ++++-
 10 files changed, 71 insertions(+), 17 deletions(-)

-- 
1.7.11.3
