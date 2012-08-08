From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 14:54:47 +0200
Subject: [PATCH 0/6] ARM: defconfig build errors
Message-ID: <1344430493-5304-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm dusting off my defconfig warning fixes. This is the most important
bunch as these are actual build failures that happen in one of the
defconfigs. I've put these into the "fixes" branch of the arm-soc
tree already and will send them out for -r2 unless I hear objections.

Please take a look.

	Arnd

Cc: Daniel Mack <zonque@gmail.com>
Cc: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>

Arnd Bergmann (6):
  ARM: pxa: remove irq_to_gpio from ezx-pcap driver
  ARM: pxa remove irq_to_gpio from eeti_ts driver
  ARM: sa1100: include asm/io.h in hackkit leds code
  ARM: s3c24xx: use new PWM driver
  ARM: integrator: include <linux/export.h
  ARM: imx: gpmi-nand depends on mxs-dma

 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 arch/arm/mach-integrator/core.c      |    1 +
 arch/arm/mach-pxa/raumfeld.c         |    1 +
 arch/arm/mach-s3c24xx/Kconfig        |    6 ++++--
 arch/arm/mach-sa1100/leds-hackkit.c  |    1 +
 drivers/input/touchscreen/eeti_ts.c  |    8 +++++---
 drivers/mfd/ezx-pcap.c               |    2 +-
 drivers/mtd/nand/Kconfig             |    2 +-
 include/linux/input/eeti_ts.h        |    1 +
 include/linux/mfd/ezx-pcap.h         |    1 +
 10 files changed, 17 insertions(+), 7 deletions(-)

-- 
1.7.10
