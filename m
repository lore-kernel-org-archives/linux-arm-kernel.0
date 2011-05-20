From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sat, 21 May 2011 00:05:00 +0200
Subject: [PATCH 0/4] Move U300 and Nomadik GPIO drivers
Message-ID: <1305929100-9012-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This simply moves the U300 and Nomadik GPIO drivers to the
GPIO subsystem and applies debugfs additions and two new calls
on the Nomadik driver.

These patches were split out of an earlier GPIO consolidation
patch set and have all been reviewed in earlier incarnations.

Feel free to drop the two latter patches if you just want to do
the move in this merge window.

The drivers/gpio/Makefile will likely conflict with one or
another update, enjoy.

Linus Walleij (2):
  gpio: move U300 GPIO driver to drivers/gpio
  gpio: move Nomadik GPIO driver to drivers/gpio

Rabin Vincent (1):
  gpio/nomadik: show all pins in debug

Rickard Andersson (1):
  gpio/nomadik: add function to read GPIO pull down status

 arch/arm/mach-u300/Makefile               |    2 +-
 arch/arm/mach-u300/gpio.c                 |  700 -------------------
 arch/arm/plat-nomadik/Kconfig             |    5 -
 arch/arm/plat-nomadik/Makefile            |    1 -
 arch/arm/plat-nomadik/gpio.c              | 1024 ---------------------------
 arch/arm/plat-nomadik/include/plat/gpio.h |    2 +
 drivers/gpio/Makefile                     |    2 +
 drivers/gpio/gpio-nomadik.c               | 1073 +++++++++++++++++++++++++++++
 drivers/gpio/gpio-u300.c                  |  700 +++++++++++++++++++
 9 files changed, 1778 insertions(+), 1731 deletions(-)
 delete mode 100644 arch/arm/mach-u300/gpio.c
 delete mode 100644 arch/arm/plat-nomadik/gpio.c
 create mode 100644 drivers/gpio/gpio-nomadik.c
 create mode 100644 drivers/gpio/gpio-u300.c

-- 
1.7.3.2
