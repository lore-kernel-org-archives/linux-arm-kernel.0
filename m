From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:04:35 +0930
Subject: [PATCH 0/2] watchdog: Add Aspeed watchdog driver
Message-ID: <1462797277-14969-1-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the watchdog timer found in Aspeed ast2400 and
ast2500 BMC SoCs.

The u-boot that ships on the edk and with many systems leaves the watchdog
running when jumping to the kernel, making this driver required for operation.

It has been tested on the ast2400 in an OpenPower Palmetto, and the ast2500-edk
dev board.

Cheers,

Joel

Joel Stanley (2):
  doc/devicetree: Add Aspeed watchdog timer bindings
  watchdog: Add Aspeed watchdog driver

 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  14 ++
 drivers/watchdog/Kconfig                           |  13 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/aspeed_wdt.c                      | 199 +++++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
 create mode 100644 drivers/watchdog/aspeed_wdt.c

-- 
2.8.1
