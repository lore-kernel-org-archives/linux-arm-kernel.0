From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Sep 2015 18:21:59 +0200
Subject: [PATCH v3 0/2] power: reset: support for Atmel alternative Shutdown
 Controller
Message-ID: <1443630121-13912-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series to add driver for a new Atmel Shutdown Controller. This new IP
is extensible and some features will be added later (see the TODO section).
Its extensible nature led to write a new binding so that wake-up sources can be
described easily.

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
  ARM: at91/dt: shdwc binding: add new shutdown controller documentation
  power: reset: at91-shdwc: add new shutdown controller driver

 .../devicetree/bindings/arm/atmel-at91.txt         |  54 ++++
 drivers/power/reset/Kconfig                        |   8 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/at91-shdwc.c                   | 288 +++++++++++++++++++++
 4 files changed, 351 insertions(+)
 create mode 100644 drivers/power/reset/at91-shdwc.c

-- 
2.1.3
