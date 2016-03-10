From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Mar 2016 16:37:38 +0100
Subject: [PATCH v4 0/2] power: reset: support for Atmel alternative Shutdown
 Controller
Message-ID: <1457624260-30350-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series to add driver for a new Atmel Shutdown Controller. This new IP
is extensible and some features will be added later (see the TODO section).
Its extensible nature led to write a new binding so that wake-up sources can be
described easily.

Changes in v4:
- change property to debounce-delay-us so that we can use a generic property
  and we can have the unit explicitly included it the name according to
  Documentation/devicetree/bindings/property-units.txt.
- move to atmel,wakeup-active-high boolean property instead of a "high", "low"
  string comparison.
- fix warning found by 0-day robot: large integer implicitly truncated to
  unsigned type [-Woverflow]
- add entry in MAINTAINERS file

Changes in v3:
- get and use slow clock and specify its handler in binding
- add the slow clock handle as the IP uses it
- remove useless protection at the beginning of pm_power_off handler
- allow to compile it as a module
- add COMPILE_TEST directive in Kconfig
- update description in file header

Changes in v2:
- add MODULE_DEVICE_TABLE as advised by Sebastian Reichel
- review indentation and braces to correct errors pointed out by checkpatch

Nicolas Ferre (2):
  ARM: dts: at91: shdwc binding: add new shutdown controller
    documentation
  power: reset: at91-shdwc: add new shutdown controller driver

 .../devicetree/bindings/arm/atmel-at91.txt         |  59 +++++
 MAINTAINERS                                        |   5 +
 drivers/power/reset/Kconfig                        |   8 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91-shdwc.c                   | 282 +++++++++++++++++++++
 5 files changed, 355 insertions(+)
 create mode 100644 drivers/power/reset/at91-shdwc.c

-- 
2.1.3
