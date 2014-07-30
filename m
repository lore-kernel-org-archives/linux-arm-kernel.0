From: sassmann@kpanic.de (Stefan Assmann)
Date: Wed, 30 Jul 2014 16:02:27 +0200
Subject: [PATCH 0/2] Enable wifi on pandaboard
Message-ID: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the pandaboard the wifi isn't available because on the TWL6030 chip
the clock CLK32KG never gets enabled. Adding a clock driver for the
TWL6030 which performs the required steps. Moved some register defines
from regulator code to twl.h.

Stefan Assmann (2):
  mfd: twl-core: move TWL6030 defines to twl.h
  clk: initial clock driver for TWL6030

 .../devicetree/bindings/clock/ti/twl6030.txt       |   4 +
 drivers/clk/Kconfig                                |   7 +
 drivers/clk/ti/Makefile                            |   1 +
 drivers/clk/ti/clk-6030.c                          | 141 +++++++++++++++++++++
 drivers/mfd/twl-core.c                             |   3 +
 drivers/regulator/twl-regulator.c                  |  11 --
 include/linux/i2c/twl.h                            |  20 +++
 7 files changed, 176 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/twl6030.txt
 create mode 100644 drivers/clk/ti/clk-6030.c

-- 
1.9.3
