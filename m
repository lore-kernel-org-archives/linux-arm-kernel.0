From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 8 Dec 2011 15:22:39 +0800
Subject: [GIT PULL] pxa changes for v3.3
Message-ID: <CAN1soZz3LcnoFUmFR8go5_ga0-tT9rnxDwtVz9j-P=Ef2Lkp4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull these for v3.3.

The four patches in below are used to fix build issue while gpio-pxa
is changed to platform driver.
      pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
      Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()
      ARM: pxa: fix build error for GPIO_bit()
      ARM: pxa: fix the build error because of missing gpio-pxa.h


The following changes since commit 1fc27d6c81c881a67fcd1ff983f23c06cdd2a93f:

  Merge branch 'fixes' into for-next (2011-12-06 14:24:24 +0000)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git for-next

Axel Lin (2):
      pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
      Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()

Haojian Zhuang (2):
      ARM: pxa: fix build error for GPIO_bit()
      ARM: pxa: fix the build error because of missing gpio-pxa.h

Jett.Zhou (5):
      RTC: sa1100: Clean out ost register
      RTC: sa1100: remove redundant code of setting alarm
      RTC: sa1100: support sa1100, pxa and mmp soc families
      ARM: pxa: add dummy clock for sa1100-rtc
      ARM: sa1100: clean up of the clock support

 arch/arm/Kconfig                            |    2 +-
 arch/arm/mach-pxa/corgi_pm.c                |    1 +
 arch/arm/mach-pxa/devices.c                 |   20 ++
 arch/arm/mach-pxa/pxa25x.c                  |    1 +
 arch/arm/mach-pxa/pxa27x.c                  |    1 +
 arch/arm/mach-pxa/pxa300.c                  |    1 +
 arch/arm/mach-pxa/pxa320.c                  |    1 +
 arch/arm/mach-pxa/pxa3xx.c                  |    1 +
 arch/arm/mach-pxa/pxa95x.c                  |    1 +
 arch/arm/mach-pxa/spitz_pm.c                |    1 +
 arch/arm/mach-sa1100/clock.c                |   91 ++++++---
 arch/arm/mach-sa1100/generic.c              |   20 ++
 drivers/input/touchscreen/zylonite-wm97xx.c |    5 +-
 drivers/pcmcia/pxa2xx_e740.c                |   11 +-
 drivers/pcmcia/pxa2xx_palmld.c              |    2 +-
 drivers/pcmcia/pxa2xx_palmtc.c              |    2 +-
 drivers/pcmcia/pxa2xx_stargate2.c           |    6 +-
 drivers/pcmcia/pxa2xx_trizeps4.c            |    5 +-
 drivers/pcmcia/pxa2xx_vpac270.c             |    4 +-
 drivers/rtc/Kconfig                         |    2 +-
 drivers/rtc/rtc-sa1100.c                    |  300 ++++++++++++++++-----------
 21 files changed, 320 insertions(+), 158 deletions(-)
