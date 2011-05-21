From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 21 May 2011 13:17:59 +0800
Subject: [GIT PULL] pxa: for next merge
Message-ID: <BANLkTin8tX_kfG_R6To+ktNbOW+B93LiqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 693d92a1bbc9e42681c42ed190bd42b636ca876f:

  Linux 2.6.39-rc7 (2011-05-09 19:33:54 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Dmitry Eremin-Solenikov (6):
      ARM: pxa/balloon3: drop udc_is_connected
      ARM: pxa/mioa701: drop udc_is_connected
      ARM: pxa/stargate2: drop udc_is_connected
      ARM: pxa25x_udc: separate lubbock handling to lubbock-usb transceiver
      ARM: pxa/lubbock: switch to using lubbock_usb_xceiv transceiver
      ARM: pxa: drop handling of udc_is_connected

Eric Miao (7):
      ARM: pxa/saarb: make use of pxa3xx_map_io()
      ARM: pxa: enable AUTO_ZRELADDR
      ARM: pxa: add common header file for pxa3xx
      ARM: pxa: avoid accessing interrupt registers directly
      ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
      ARM: pxa: move declarations from generic.h to <soc>.h
      ARM: pxa: enable MULTI_IRQ_HANDLER for all boards

Haojian Zhuang (1):
      ARM: pxa: add clk_set_rate()

Igor Grinberg (4):
      ARM: pxa/cm-x300: fix V3020 RTC functionality
      ARM: pxa/cm-x300: GPIO cleanup
      ARM: pxa/cm-x300: minor style cleanup
      ARM: pxa/cm-x300: update cm_x300_defconfig

 arch/arm/Kconfig                           |    2 +
 arch/arm/configs/cm_x300_defconfig         |   18 +--
 arch/arm/include/asm/mach/udc_pxa2xx.h     |    1 -
 arch/arm/mach-mmp/clock.c                  |   15 +++
 arch/arm/mach-mmp/clock.h                  |    1 +
 arch/arm/mach-pxa/balloon3.c               |    7 +-
 arch/arm/mach-pxa/capc7117.c               |    1 +
 arch/arm/mach-pxa/clock.c                  |   15 +++
 arch/arm/mach-pxa/clock.h                  |    1 +
 arch/arm/mach-pxa/cm-x2xx.c                |    5 +-
 arch/arm/mach-pxa/cm-x300.c                |   59 +++++-----
 arch/arm/mach-pxa/colibri-pxa270.c         |    2 +
 arch/arm/mach-pxa/colibri-pxa300.c         |    1 +
 arch/arm/mach-pxa/colibri-pxa320.c         |    4 +-
 arch/arm/mach-pxa/corgi.c                  |    3 +
 arch/arm/mach-pxa/csb726.c                 |    4 +-
 arch/arm/mach-pxa/em-x270.c                |    2 +
 arch/arm/mach-pxa/eseries.c                |    6 +
 arch/arm/mach-pxa/ezx.c                    |    6 +
 arch/arm/mach-pxa/generic.h                |   13 --
 arch/arm/mach-pxa/gumstix.c                |    1 +
 arch/arm/mach-pxa/h5000.c                  |    2 +
 arch/arm/mach-pxa/himalaya.c               |    4 +-
 arch/arm/mach-pxa/hx4700.c                 |    1 +
 arch/arm/mach-pxa/icontrol.c               |    1 +
 arch/arm/mach-pxa/idp.c                    |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h      |   12 ++
 arch/arm/mach-pxa/include/mach/pxa25x.h    |    9 ++
 arch/arm/mach-pxa/include/mach/pxa27x.h    |    5 +
 arch/arm/mach-pxa/include/mach/pxa300.h    |    3 +-
 arch/arm/mach-pxa/include/mach/pxa320.h    |    3 +-
 arch/arm/mach-pxa/include/mach/pxa3xx.h    |   14 ++
 arch/arm/mach-pxa/include/mach/pxa930.h    |    3 +-
 arch/arm/mach-pxa/include/mach/regs-intc.h |   30 -----
 arch/arm/mach-pxa/irq.c                    |   36 ++++++-
 arch/arm/mach-pxa/littleton.c              |    1 +
 arch/arm/mach-pxa/lpd270.c                 |    1 +
 arch/arm/mach-pxa/lubbock.c                |   18 +--
 arch/arm/mach-pxa/magician.c               |    1 +
 arch/arm/mach-pxa/mainstone.c              |    1 +
 arch/arm/mach-pxa/mioa701.c                |   12 +-
 arch/arm/mach-pxa/mp900.c                  |    1 +
 arch/arm/mach-pxa/palmld.c                 |    1 +
 arch/arm/mach-pxa/palmt5.c                 |    1 +
 arch/arm/mach-pxa/palmtc.c                 |    4 +-
 arch/arm/mach-pxa/palmte2.c                |    3 +-
 arch/arm/mach-pxa/palmtreo.c               |    2 +
 arch/arm/mach-pxa/palmtx.c                 |    1 +
 arch/arm/mach-pxa/palmz72.c                |    1 +
 arch/arm/mach-pxa/pcm027.c                 |    1 +
 arch/arm/mach-pxa/poodle.c                 |    1 +
 arch/arm/mach-pxa/pxa3xx.c                 |    5 +-
 arch/arm/mach-pxa/pxa95x.c                 |    1 -
 arch/arm/mach-pxa/raumfeld.c               |    8 +-
 arch/arm/mach-pxa/saar.c                   |    1 +
 arch/arm/mach-pxa/saarb.c                  |    3 +-
 arch/arm/mach-pxa/spitz.c                  |    3 +
 arch/arm/mach-pxa/stargate2.c              |    8 +-
 arch/arm/mach-pxa/tavorevb.c               |    1 +
 arch/arm/mach-pxa/tavorevb3.c              |    1 +
 arch/arm/mach-pxa/tosa.c                   |    1 +
 arch/arm/mach-pxa/trizeps4.c               |    2 +
 arch/arm/mach-pxa/viper.c                  |    1 +
 arch/arm/mach-pxa/vpac270.c                |    1 +
 arch/arm/mach-pxa/xcep.c                   |    4 +-
 arch/arm/mach-pxa/z2.c                     |    1 +
 arch/arm/mach-pxa/zeus.c                   |    4 +-
 arch/arm/mach-pxa/zylonite.c               |    3 +-
 drivers/usb/gadget/pxa25x_udc.c            |   87 ++------------
 drivers/usb/otg/Kconfig                    |    8 ++
 drivers/usb/otg/Makefile                   |    1 +
 drivers/usb/otg/lubbock-usb.c              |  178 ++++++++++++++++++++++++++++
 72 files changed, 435 insertions(+), 228 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/regs-intc.h
 create mode 100644 drivers/usb/otg/lubbock-usb.c
