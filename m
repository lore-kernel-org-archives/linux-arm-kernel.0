From: Thomas.Kunze@gmx.com (Thomas Kunze)
Date: Sat, 28 Nov 2009 13:02:27 +0100
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <20091127220425.GF28193@n2100.arm.linux.org.uk>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>	<20091024211026.GE16451@n2100.arm.linux.org.uk>	<20091025153603.GA24490@rainbow>
	<20091115173048.GA19609@rainbow>	<20091123203931.GI18142@n2100.arm.linux.org.uk>	<20091124212541.GA5751@rainbow>	<20091125165301.GC5136@n2100.arm.linux.org.uk>	<4B0D6DD5.6090403@gmx.com>	<20091125221113.GJ5136@n2100.arm.linux.org.uk>	<4B103A34.8020308@gmx.com>
	<20091127220425.GF28193@n2100.arm.linux.org.uk>
Message-ID: <4B111153.7030705@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 648f4e3e50c4793d9dbf9a09afa193631f76fa26:
  Linus Torvalds (1):
        Linux 2.6.32-rc8

are available in the git repository at:

  git://git.linuxtogo.org/home/thesing/collie.git for-lak

Thomas Kunze (9):
      collie: fix scoop convesion to new api
      collie: prepare for gpiolib use
      move drivers/mfd/*.h to include/linux/mfd
      collie: locomo-led change default trigger
      SA1100: make gpio_to_irq and reverse a macro
      add gpiolib support to ucb1x00
      collie: convert to gpiolib for ucb1x00
      collie: add battery driver
      collie: support pda_power driver

 arch/arm/mach-sa1100/collie.c              |   79 +++++-
 arch/arm/mach-sa1100/include/mach/collie.h |   77 +++---
 arch/arm/mach-sa1100/include/mach/gpio.h   |   19 +-
 arch/arm/mach-sa1100/include/mach/mcp.h    |    1 +
 drivers/leds/leds-locomo.c                 |    2 +-
 drivers/mfd/mcp-core.c                     |    2 +-
 drivers/mfd/mcp-sa11x0.c                   |    3 +-
 drivers/mfd/ucb1x00-assabet.c              |    2 +-
 drivers/mfd/ucb1x00-core.c                 |   89 ++++++-
 drivers/mfd/ucb1x00-ts.c                   |    2 +-
 drivers/power/Kconfig                      |    7 +
 drivers/power/Makefile                     |    1 +
 drivers/power/collie_battery.c             |  418 
++++++++++++++++++++++++++++
 {drivers => include/linux}/mfd/mcp.h       |    3 +
 {drivers => include/linux}/mfd/ucb1x00.h   |    7 +-
 15 files changed, 649 insertions(+), 63 deletions(-)
 create mode 100644 drivers/power/collie_battery.c
 rename {drivers => include/linux}/mfd/mcp.h (97%)
 rename {drivers => include/linux}/mfd/ucb1x00.h (98%)
