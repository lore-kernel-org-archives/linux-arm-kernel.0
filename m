From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Thu, 17 Dec 2009 11:13:19 +0100
Subject: [PATCH 0/3] i2c port expanders support for nomadik nhk8815
Message-ID: <cover.1261044597.git.rubini@unipv.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

The first patch adds a driver for STMPE2401, an i2c port expander with
keypad and pwm support, as well as irq capabilities.  The driver
currently only supports gpio, I'll add keypad later. The device is
used in the nomadik evaluation kit (already upstream) and in the U8500
evaluation kit, which is goint to be upstreamed soon. There are no
dependencies on PLAT_NOMADIK as the driver is generic and other boards
may mount the chip.

The second patch fixes NR_IRQS for the nhk8815 board, as some devices
use STMPE2401-driven GPIO pins.

The third patch adds platform data for nhk8815 so the expanders
actually work on the board.

Alessandro Rubini (3):
  i2c: added stmpe2401 port extender with irq support
  nhk8815: add port expander to NR_IRQS
  nhk8815: add platform data for port expanders

 arch/arm/mach-nomadik/i2c-8815nhk.c       |   33 ++
 arch/arm/mach-nomadik/include/mach/irqs.h |   27 ++-
 drivers/gpio/Kconfig                      |    7 +
 drivers/gpio/Makefile                     |    1 +
 drivers/gpio/stmpe2401.c                  |  571 +++++++++++++++++++++++++++++
 include/linux/i2c/stmpe2401.h             |  145 ++++++++
 6 files changed, 783 insertions(+), 1 deletions(-)
 create mode 100644 drivers/gpio/stmpe2401.c
 create mode 100644 include/linux/i2c/stmpe2401.h
