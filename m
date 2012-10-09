From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue,  9 Oct 2012 14:04:03 +0200
Subject: [PATCH v4 0/8] watchdog: dt: add support for the timeout-sec dt
 property
Message-ID: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
to the at91sam9_wdt driver and on all framework enabled watchdog driver
with dt support.
This patchset depends on the patchset already sent:
"[PATCH v8 0/3] watchdog: at91sam9_wdt: add device tree support"

The at91sam9_wdt is tested on evk-pr3,
the other drivers are compile tested only.


changes:
v4:
  - add of_get_timeout_sec
  - add s3c2410_wdt driver
  - split driver patch
  - fixed watchdog_init_timeout handling of min_timeout and max_timeout
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


Fabio Porcedda (8):
  dt: add helper inline for retrieving timeout-sec property
  watchdog: core: dt: add support for the timeout-sec dt property
  watchdog: orion_wdt: add timeout-sec property binding
  watchdog: pnx4008: add timeout-sec property binding
  watchdog: s3c2410_wdt: add timeout-sec property binding
  watchdog: at91sam9_wdt: add timeout-sec property binding
  watchdog: orion_wdt: move the min_timeout initialization
  watchdog: WatchDog Timer Driver Core - fix comment

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 +++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 +++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 +++
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |  3 ++
 Documentation/watchdog/watchdog-kernel-api.txt     | 10 ++++++
 drivers/watchdog/Kconfig                           |  1 +
 drivers/watchdog/at91sam9_wdt.c                    | 16 ++++++++--
 drivers/watchdog/orion_wdt.c                       | 10 +++---
 drivers/watchdog/pnx4008_wdt.c                     |  7 ++--
 drivers/watchdog/s3c2410_wdt.c                     |  6 ++--
 drivers/watchdog/watchdog_core.c                   | 37 ++++++++++++++++++++++
 include/linux/of.h                                 | 11 +++++++
 include/linux/watchdog.h                           |  5 ++-
 13 files changed, 103 insertions(+), 16 deletions(-)

-- 
1.7.11.3
