From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 23:48:25 +0200
Subject: [PATCH 0/2] CREG clk driver for NXP LPC18xx family
Message-ID: <1436651307-24098-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a clk driver for the low power clocks found in
the CREG block on lpc18xx. CREG is a collection of miscellaneous
configuration registers that can be accessed through a syscon
regmap interface. The clk driver makes it possible to setup and
enabled these two clocks.

This need to support peripherals like the internal RTC on the
lpc18xx platform.

Based on v4.2-rc1.

Joachim Eastwood (2):
  clk: add lpc18xx creg clk driver
  doc: dt: add documentation for lpc1850-creg-clk driver

 .../devicetree/bindings/clock/lpc1850-creg-clk.txt |  52 +++++++
 drivers/clk/nxp/Makefile                           |   1 +
 drivers/clk/nxp/clk-lpc18xx-creg.c                 | 173 +++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-creg-clk.txt
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-creg.c

-- 
1.8.0
