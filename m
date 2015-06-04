From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  4 Jun 2015 18:54:01 +0200
Subject: [PATCH v3 0/2] NXP SPIFI driver for LPC18xx/43xx familiy
Message-ID: <1433436843-22296-1-git-send-email-manabian@gmail.com>
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

This version address the comment from Ezequiel Garcia on v2. I
have done some tests with both "jedec,spi-nor" and specific
Flash name and both cases seems to work just fine now.

Changes since v2:
 - default to auto detection unless chip is specified
 - update doc with reference to jedec,spi-nor.txt

Changes since v1:
 - use readb_poll_timeout instead of open coding
 - cache current mode (memory/command)
 - depend on HAS_IOMEM
 - removed stray white space
 - removed leftover debug print

Support for LPC18xx/43xx can found in linux-next now.

Patch against l2-mtd.git master branch.

Joachim Eastwood (2):
  mtd: spi-nor: add driver for NXP SPI Flash Interface (SPIFI)
  doc: dt: add documentation for nxp,lpc1773-spifi

 .../devicetree/bindings/mtd/nxp-spifi.txt          |  58 +++
 drivers/mtd/spi-nor/Kconfig                        |  11 +
 drivers/mtd/spi-nor/Makefile                       |   1 +
 drivers/mtd/spi-nor/nxp-spifi.c                    | 496 +++++++++++++++++++++
 4 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nxp-spifi.txt
 create mode 100644 drivers/mtd/spi-nor/nxp-spifi.c

-- 
1.8.0
