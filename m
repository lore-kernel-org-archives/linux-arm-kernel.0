From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 17 Dec 2014 22:18:03 +0100
Subject: [PATCH v3 0/2] ARM: mediatek: Add watchdog driver
Message-ID: <1418851085-17787-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek SoCs have a watchdog driver. This patch set adds driver and DTS
binding. The driver also implements a restart handler to reboot the SoC.

Changes for v3:
- fix based on file name
- fix style problems
- fix error return value and warning message
- delete unnecessary watchdog_set_drvdata
- delete unused variable

Changes for v2:
- we don't need to have the watchdog enabled to do a sotware reset
- disable dual mode and irq mode when starting the watchdog
- update commit message to name the SoCs the driver supports

Matthias Brugger (2):
  watchdog: Add driver for Mediatek watchdog
  ARM: mediatek: dts: Add bindings for watchdog

 .../devicetree/bindings/watchdog/mtk-wdt.txt       |  13 ++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/mtk_wdt.c                         | 256 +++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
 create mode 100644 drivers/watchdog/mtk_wdt.c

-- 
1.9.1
