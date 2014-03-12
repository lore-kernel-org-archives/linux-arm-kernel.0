From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 12 Mar 2014 16:53:34 +0100
Subject: [PATCH 0/3] spi: bitbang fixes and passive serial driver
Message-ID: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series includes a bugfix and adds LSB mode for the bitbang driver.
It also includes a new character device driver to passively clock a
firmware into an FPGA.

It is an resend after the cc to linux-arm-kernel list got fixed.

Michael Grzeschik (3):
  spi: bitbang: fix shift for getmosi
  spi: bitbang: add lsb first support
  spi: psdev: add passive serial driver

 drivers/spi/Kconfig            |   9 +
 drivers/spi/Makefile           |   1 +
 drivers/spi/spi-bitbang-txrx.h |  98 +++++---
 drivers/spi/spi-bitbang.c      |   3 +-
 drivers/spi/spipsdev.c         | 520 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 601 insertions(+), 30 deletions(-)
 create mode 100644 drivers/spi/spipsdev.c

-- 
1.9.0
