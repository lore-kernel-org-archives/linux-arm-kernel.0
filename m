From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 15 Nov 2011 16:23:30 +0800
Subject: [GIT PULL] ARM: pxa: change gpio to platform driver
Message-ID: <CAN1soZw6JuNsty91xQP2G4NLodAz5GfOVUO7xYo+fdx8u0chvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

The following changes since commit 31555213f03bca37d2c02e10946296052f4ecfcd:

  Revert "hvc_console: display printk messages on console."
(2011-11-06 22:22:16 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git gpio

Haojian Zhuang (11):
      ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ
      ARM: pxa: use chained interrupt for GPIO0 and GPIO1
      ARM: pxa: rename gpio_to_irq and irq_to_gpio
      ARM: pxa: recognize gpio number and type
      ARM: pxa: rename NR_BUILTIN_GPIO
      ARM: pxa: use little endian read write in gpio driver
      ARM: pxa: use generic gpio operation instead of gpio register
      ARM: pxa: change gpio to platform device
      ARM: mmp: clear gpio edge detect
      ARM: pxa: add clk support in gpio driver
      driver: pcmcia: replace IRQ_GPIO() with gpio_to_irq()

 arch/arm/Kconfig                                  |    2 +
 arch/arm/mach-mmp/aspenite.c                      |    5 +-
 arch/arm/mach-mmp/avengers_lite.c                 |    1 +
 arch/arm/mach-mmp/brownstone.c                    |    1 +
 arch/arm/mach-mmp/flint.c                         |    5 +-
 arch/arm/mach-mmp/gplugd.c                        |    1 +
 arch/arm/mach-mmp/include/mach/gpio-pxa.h         |    3 +-
 arch/arm/mach-mmp/include/mach/gpio.h             |    7 +-
 arch/arm/mach-mmp/include/mach/irqs.h             |    6 +-
 arch/arm/mach-mmp/include/mach/mmp2.h             |    2 +
 arch/arm/mach-mmp/include/mach/pxa168.h           |    2 +
 arch/arm/mach-mmp/include/mach/pxa910.h           |    2 +
 arch/arm/mach-mmp/mmp2.c                          |   39 ++-
 arch/arm/mach-mmp/pxa168.c                        |   40 ++-
 arch/arm/mach-mmp/pxa910.c                        |   40 ++-
 arch/arm/mach-mmp/tavorevb.c                      |    6 +-
 arch/arm/mach-mmp/teton_bga.c                     |    3 +-
 arch/arm/mach-mmp/ttc_dkb.c                       |    8 +-
 arch/arm/mach-pxa/am200epd.c                      |    4 +-
 arch/arm/mach-pxa/am300epd.c                      |    4 +-
 arch/arm/mach-pxa/balloon3.c                      |    2 +-
 arch/arm/mach-pxa/capc7117.c                      |   12 +-
 arch/arm/mach-pxa/cm-x270.c                       |    4 +-
 arch/arm/mach-pxa/cm-x2xx.c                       |    4 +-
 arch/arm/mach-pxa/cm-x300.c                       |    6 +-
 arch/arm/mach-pxa/colibri-pxa270.c                |    6 +-
 arch/arm/mach-pxa/colibri-pxa300.c                |    4 +-
 arch/arm/mach-pxa/colibri-pxa320.c                |    4 +-
 arch/arm/mach-pxa/corgi.c                         |    2 +-
 arch/arm/mach-pxa/corgi_pm.c                      |   20 +-
 arch/arm/mach-pxa/devices.c                       |   30 ++
 arch/arm/mach-pxa/devices.h                       |    1 +
 arch/arm/mach-pxa/em-x270.c                       |    6 +-
 arch/arm/mach-pxa/eseries.c                       |    4 +-
 arch/arm/mach-pxa/hx4700.c                        |   18 +-
 arch/arm/mach-pxa/icontrol.c                      |    8 +-
 arch/arm/mach-pxa/idp.c                           |    4 +-
 arch/arm/mach-pxa/include/mach/balloon3.h         |    6 +-
 arch/arm/mach-pxa/include/mach/corgi.h            |   26 +-
 arch/arm/mach-pxa/include/mach/csb726.h           |    4 +-
 arch/arm/mach-pxa/include/mach/gpio-pxa.h         |  133 --------
 arch/arm/mach-pxa/include/mach/gpio.h             |   20 +-
 arch/arm/mach-pxa/include/mach/gumstix.h          |   20 +-
 arch/arm/mach-pxa/include/mach/hx4700.h           |    2 +-
 arch/arm/mach-pxa/include/mach/idp.h              |   16 +-
 arch/arm/mach-pxa/include/mach/irqs.h             |    8 +-
 arch/arm/mach-pxa/include/mach/littleton.h        |    4 +-
 arch/arm/mach-pxa/include/mach/magician.h         |    2 +-
 arch/arm/mach-pxa/include/mach/palmld.h           |    8 +-
 arch/arm/mach-pxa/include/mach/palmt5.h           |    8 +-
 arch/arm/mach-pxa/include/mach/palmtc.h           |    4 +-
 arch/arm/mach-pxa/include/mach/palmtx.h           |    8 +-
 arch/arm/mach-pxa/include/mach/pcm027.h           |    8 +-
 arch/arm/mach-pxa/include/mach/pcm990_baseboard.h |   14 +-
 arch/arm/mach-pxa/include/mach/poodle.h           |   26 +-
 arch/arm/mach-pxa/include/mach/spitz.h            |   40 ++--
 arch/arm/mach-pxa/include/mach/tosa.h             |   52 ++--
 arch/arm/mach-pxa/include/mach/trizeps4.h         |   16 +-
 arch/arm/mach-pxa/irq.c                           |   61 +----
 arch/arm/mach-pxa/littleton.c                     |    6 +-
 arch/arm/mach-pxa/lpd270.c                        |    4 +-
 arch/arm/mach-pxa/lubbock.c                       |    4 +-
 arch/arm/mach-pxa/magician.c                      |    8 +-
 arch/arm/mach-pxa/mainstone.c                     |    4 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c                    |    6 +-
 arch/arm/mach-pxa/mioa701.c                       |    8 +-
 arch/arm/mach-pxa/mxm8x10.c                       |    4 +-
 arch/arm/mach-pxa/pcm990-baseboard.c              |    6 +-
 arch/arm/mach-pxa/poodle.c                        |    6 +-
 arch/arm/mach-pxa/pxa25x.c                        |    6 +-
 arch/arm/mach-pxa/pxa27x.c                        |    6 +-
 arch/arm/mach-pxa/pxa3xx.c                        |    8 +-
 arch/arm/mach-pxa/pxa95x.c                        |    5 +-
 arch/arm/mach-pxa/raumfeld.c                      |    8 +-
 arch/arm/mach-pxa/saar.c                          |    6 +-
 arch/arm/mach-pxa/saarb.c                         |    2 +-
 arch/arm/mach-pxa/sharpsl_pm.c                    |   24 +-
 arch/arm/mach-pxa/spitz.c                         |    2 +-
 arch/arm/mach-pxa/spitz_pm.c                      |   10 +-
 arch/arm/mach-pxa/stargate2.c                     |   26 +-
 arch/arm/mach-pxa/tavorevb.c                      |    4 +-
 arch/arm/mach-pxa/tavorevb3.c                     |    2 +-
 arch/arm/mach-pxa/tosa.c                          |    4 +-
 arch/arm/mach-pxa/viper.c                         |   12 +-
 arch/arm/mach-pxa/vpac270.c                       |   10 +-
 arch/arm/mach-pxa/z2.c                            |    2 +-
 arch/arm/mach-pxa/zeus.c                          |   20 +-
 arch/arm/mach-pxa/zylonite.c                      |    4 +-
 arch/arm/mach-pxa/zylonite_pxa300.c               |    4 +-
 arch/arm/plat-pxa/include/plat/gpio-pxa.h         |   44 ---
 arch/arm/plat-pxa/include/plat/gpio.h             |   30 --
 drivers/gpio/Kconfig                              |    6 +
 drivers/gpio/Makefile                             |    2 +-
 drivers/gpio/gpio-pxa.c                           |  377 ++++++++++++++++++---
 drivers/pcmcia/pxa2xx_cm_x255.c                   |   16 +-
 drivers/pcmcia/pxa2xx_cm_x270.c                   |    9 +-
 96 files changed, 792 insertions(+), 715 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/include/mach/gpio-pxa.h
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio-pxa.h
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio.h
