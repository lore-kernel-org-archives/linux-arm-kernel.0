From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jul 2011 00:09:00 +0800
Subject: [GIT PULL] pxa: patches for v3.1
Message-ID: <CAMPhdO-Xy69r5P-GZivUjsho81k1b_m_mAYM2hxtBt2X3W=42A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Daniel Mack (1):
      ARM: pxa/raumfeld: fix device name for codec ak4104

Dmitry Eremin-Solenikov (1):
      ARM: scoop: drop pcmcia_init callback

Eric Miao (7):
      ARM: pxa: enable AUTO_ZRELADDR
      ARM: pxa: add common header file for pxa3xx
      ARM: pxa: avoid accessing interrupt registers directly
      ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
      ARM: pxa: move declarations from generic.h to <soc>.h
      ARM: pxa: enable MULTI_IRQ_HANDLER for all boards
      ARM: pxa/saarb: make use of pxa3xx_map_io()

Haojian Zhuang (2):
      ARM: pxa: add clk_set_rate()
      ARM: mmp/dkb: enable max7312 gpio expander

Igor Grinberg (4):
      ARM: pxa/cm-x300: fix V3020 RTC functionality
      ARM: pxa/cm-x300: GPIO cleanup
      ARM: pxa/cm-x300: minor style cleanup
      ARM: pxa/cm-x300: update cm_x300_defconfig

Jonathan Cameron (2):
      pcmcia: pxa2xx/vpac270: free gpios on exist rather than requesting
      pcmcia: pxa2xx/trizeps4: remove unnecessary ifdefs

Linus Walleij (1):
      ARM: pxa: fix gpio_to_chip() clash with gpiolib namespace

Philipp Zabel (4):
      ARM: pxa/magician: fix MAGICIAN_EGPIO_BASE, align with NR_BUILTIN_GPIO
      ARM: pxa/magician: use gpio arrays for backlight and global gpios
      ARM: pxa/hx4700: use gpio arrays for global gpios
      ARM: pxa/mioa701: use gpio arrays for global and gsm gpios

Sven Neumann (2):
      ARM: pxa/raumfeld: adapt to upcoming hardware change
      ARM: pxa/raumfeld: display initialisation fixes

Tanmay Upadhyay (3):
      ARM: pxa168: Add support for UART3
      ARM: pxa168: Add support for Ethernet
      ARM: pxa168: Add board support for gplugD

Vasily Khoruzhick (1):
      ARM: pxa/z2: add poweroff function

 arch/arm/Kconfig                            |    2 +
 arch/arm/configs/cm_x300_defconfig          |   18 +--
 arch/arm/include/asm/hardware/scoop.h       |    1 -
 arch/arm/mach-mmp/Kconfig                   |    7 +
 arch/arm/mach-mmp/Makefile                  |    1 +
 arch/arm/mach-mmp/clock.c                   |   15 ++
 arch/arm/mach-mmp/clock.h                   |    1 +
 arch/arm/mach-mmp/gplugd.c                  |  189 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/mfp-gplugd.h |   52 ++++++++
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   19 +++
 arch/arm/mach-mmp/include/mach/pxa168.h     |    8 +
 arch/arm/mach-mmp/include/mach/regs-apmu.h  |    1 +
 arch/arm/mach-mmp/pxa168.c                  |    6 +
 arch/arm/mach-mmp/ttc_dkb.c                 |   31 +++++-
 arch/arm/mach-pxa/balloon3.c                |    1 +
 arch/arm/mach-pxa/capc7117.c                |    1 +
 arch/arm/mach-pxa/clock.c                   |   15 ++
 arch/arm/mach-pxa/clock.h                   |    1 +
 arch/arm/mach-pxa/cm-x2xx.c                 |    5 +-
 arch/arm/mach-pxa/cm-x300.c                 |   59 ++++-----
 arch/arm/mach-pxa/colibri-pxa270.c          |    2 +
 arch/arm/mach-pxa/colibri-pxa300.c          |    1 +
 arch/arm/mach-pxa/colibri-pxa320.c          |    4 +-
 arch/arm/mach-pxa/corgi.c                   |    3 +
 arch/arm/mach-pxa/csb726.c                  |    4 +-
 arch/arm/mach-pxa/em-x270.c                 |    2 +
 arch/arm/mach-pxa/eseries.c                 |    6 +
 arch/arm/mach-pxa/ezx.c                     |    6 +
 arch/arm/mach-pxa/generic.h                 |   13 --
 arch/arm/mach-pxa/gumstix.c                 |    1 +
 arch/arm/mach-pxa/h5000.c                   |    2 +
 arch/arm/mach-pxa/himalaya.c                |    4 +-
 arch/arm/mach-pxa/hx4700.c                  |   71 +++-------
 arch/arm/mach-pxa/icontrol.c                |    1 +
 arch/arm/mach-pxa/idp.c                     |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h       |   12 ++
 arch/arm/mach-pxa/include/mach/magician.h   |    3 +-
 arch/arm/mach-pxa/include/mach/pxa25x.h     |    9 ++
 arch/arm/mach-pxa/include/mach/pxa27x.h     |    5 +
 arch/arm/mach-pxa/include/mach/pxa300.h     |    3 +-
 arch/arm/mach-pxa/include/mach/pxa320.h     |    3 +-
 arch/arm/mach-pxa/include/mach/pxa3xx.h     |   14 ++
 arch/arm/mach-pxa/include/mach/pxa930.h     |    3 +-
 arch/arm/mach-pxa/include/mach/regs-intc.h  |   30 -----
 arch/arm/mach-pxa/irq.c                     |   36 +++++-
 arch/arm/mach-pxa/littleton.c               |    1 +
 arch/arm/mach-pxa/lpd270.c                  |    1 +
 arch/arm/mach-pxa/lubbock.c                 |    1 +
 arch/arm/mach-pxa/magician.c                |   58 ++++-----
 arch/arm/mach-pxa/mainstone.c               |    1 +
 arch/arm/mach-pxa/mioa701.c                 |   71 +++--------
 arch/arm/mach-pxa/mp900.c                   |    1 +
 arch/arm/mach-pxa/palmld.c                  |    1 +
 arch/arm/mach-pxa/palmt5.c                  |    1 +
 arch/arm/mach-pxa/palmtc.c                  |    4 +-
 arch/arm/mach-pxa/palmte2.c                 |    3 +-
 arch/arm/mach-pxa/palmtreo.c                |    2 +
 arch/arm/mach-pxa/palmtx.c                  |    1 +
 arch/arm/mach-pxa/palmz72.c                 |    1 +
 arch/arm/mach-pxa/pcm027.c                  |    1 +
 arch/arm/mach-pxa/poodle.c                  |    1 +
 arch/arm/mach-pxa/pxa3xx.c                  |    5 +-
 arch/arm/mach-pxa/pxa95x.c                  |    1 -
 arch/arm/mach-pxa/raumfeld.c                |   44 ++++---
 arch/arm/mach-pxa/saar.c                    |    1 +
 arch/arm/mach-pxa/saarb.c                   |    3 +-
 arch/arm/mach-pxa/spitz.c                   |    3 +
 arch/arm/mach-pxa/stargate2.c               |    2 +
 arch/arm/mach-pxa/tavorevb.c                |    1 +
 arch/arm/mach-pxa/tavorevb3.c               |    1 +
 arch/arm/mach-pxa/tosa.c                    |    1 +
 arch/arm/mach-pxa/trizeps4.c                |    2 +
 arch/arm/mach-pxa/viper.c                   |    1 +
 arch/arm/mach-pxa/vpac270.c                 |    1 +
 arch/arm/mach-pxa/xcep.c                    |    4 +-
 arch/arm/mach-pxa/z2.c                      |   18 +++
 arch/arm/mach-pxa/zeus.c                    |    4 +-
 arch/arm/mach-pxa/zylonite.c                |    3 +-
 arch/arm/plat-pxa/gpio.c                    |   10 +-
 drivers/pcmcia/pxa2xx_sharpsl.c             |    3 -
 drivers/pcmcia/pxa2xx_trizeps4.c            |    4 -
 drivers/pcmcia/pxa2xx_vpac270.c             |    4 +-
 82 files changed, 643 insertions(+), 294 deletions(-)
 create mode 100644 arch/arm/mach-mmp/gplugd.c
 create mode 100644 arch/arm/mach-mmp/include/mach/mfp-gplugd.h
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/regs-intc.h
