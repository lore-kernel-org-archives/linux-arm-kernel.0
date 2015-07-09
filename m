From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  9 Jul 2015 22:19:05 +0200
Subject: [PATCH v4 0/2] NXP SPIFI driver for LPC18xx/43xx familiy
Message-ID: <1436473147-31063-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a SPI-NOR driver for the NXP SPI Flash (SPIFI)
controller that can be found on newer NXP MCUs. For example on the
LPC18xx and LPC43xx familiy.

NXP SPIFI is a specialized SPI interface for serial Flash devices.
It supports one Flash device with 1-, 2- and 4-bits width in SPI
mode 0 or 3. The controller operates in either command or memory
mode. In memory mode the Flash is made accessible for the CPU as
normal memory.

This version fix a bug in the write function discovered during
testing with JFFS2.

Changes since v3:
 - fix bug in write function
 - rebase on 4.2-rc1

Changes since v2:
 - default to auto detection unless chip is specified
 - update doc with reference to jedec,spi-nor.txt

Changes since v1:
 - use readb_poll_timeout instead of open coding
 - cache current mode (memory/command)
 - depend on HAS_IOMEM
 - removed stray white space
 - removed leftover debug print

Joachim Eastwood (2):
  mtd: spi-nor: add driver for NXP SPI Flash Interface (SPIFI)
  doc: dt: add documentation for nxp,lpc1773-spifi

 .../devicetree/bindings/mtd/nxp-spifi.txt          |  58 +++
 drivers/mtd/spi-nor/Kconfig                        |  11 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/nxp-spifi.c                    | 494 +++++++++++++++++++++
 4 files changed, 564 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nxp-spifi.txt
 create mode 100644 drivers/mtd/spi-nor/nxp-spifi.c

-- 
1.8.0
