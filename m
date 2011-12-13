From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 13 Dec 2011 18:01:31 +0800
Subject: [GIT PULL] pxa changes for v3.3
Message-ID: <CAN1soZy3fpdcBg+9sZCk5Hig+TT5F3aiqSTghmuxc7K7e9_Qzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull these for v3.3. I rebased those patches on Linux 3.2-rc5.


The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git for-next

Axel Lin (2):
      pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
      Input: zylonite-wm97xx - replace IRQ_GPIO() with gpio_to_irq()

Haojian Zhuang (3):
      ARM: pxa: fix build error for GPIO_bit()
      ARM: pxa: fix the build error because of missing gpio-pxa.h
      MAINTAINERS: update pxa and mmp

Jett.Zhou (5):
      RTC: sa1100: Clean out ost register
      RTC: sa1100: remove redundant code of setting alarm
      RTC: sa1100: support sa1100, pxa and mmp soc families
      ARM: pxa: add dummy clock for sa1100-rtc
      ARM: sa1100: clean up of the clock support

 MAINTAINERS                                 |   22 +--
 arch/arm/Kconfig                            |    2 +-
 arch/arm/mach-pxa/corgi_pm.c                |    1 +
 arch/arm/mach-pxa/devices.c                 |   20 ++
 arch/arm/mach-pxa/pxa25x.c                  |    2 +
 arch/arm/mach-pxa/pxa27x.c                  |    2 +
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
 22 files changed, 329 insertions(+), 173 deletions(-)

Thanks
Haojian
