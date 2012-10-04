From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu,  4 Oct 2012 10:26:57 +0200
Subject: [RFC PATCH v2 0/2] watchdog: core: dt: add support for the
 timeout-sec dt property
Message-ID: <1349339219-1467-1-git-send-email-fabio.porcedda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
in the next revision i will add the pnx4008 and s3c2410 driver.

changes:
v2:
  - change "timeout" to "timeout-sec" as asked by Jean-Christophe
  - at91sam9_wdt: use the new helper function
  - at91sam9_wdt: add bounds checking
  - watchdog.h: add bounds checking 

Fabio Porcedda (2):
  watchdog: core: dt: add support for the timeout-sec dt property
  watchdog: add timeout-sec property binding to some drivers

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 ++++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 +++++
 Documentation/watchdog/watchdog-kernel-api.txt     |  3 +++
 drivers/watchdog/at91sam9_wdt.c                    | 23 ++++++++++++++++------
 drivers/watchdog/orion_wdt.c                       | 13 ++++++------
 include/linux/watchdog.h                           | 15 ++++++++++++++
 6 files changed, 51 insertions(+), 12 deletions(-)

-- 
1.7.11.3
