From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  2 May 2015 23:11:33 +0200
Subject: [PATCH v2 0/2] gpio driver for NXP LPC18xx family
Message-ID: <1430601095-31984-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a gpio driver for NXP LPC18xx/43xx devices.
Patchset is based on Linus master 4.1-rc1.

changes in v2:
 - use PBYTE register for gpio set/get
 - refactor direction setup
 - add lock for direction set RMW cycle
 - expand doc example

Base support for the family can be found here:
http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2

DTS changes will come once base support and clk patches goes upstream.

Joachim Eastwood (2):
  gpio: add lpc18xx gpio driver
  doc: dt: add documentation for lpc1850-gpio driver

 .../devicetree/bindings/gpio/nxp,lpc1850-gpio.txt  |  39 +++++
 drivers/gpio/Kconfig                               |   8 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-lpc18xx.c                        | 180 +++++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/nxp,lpc1850-gpio.txt
 create mode 100644 drivers/gpio/gpio-lpc18xx.c

-- 
1.8.0
