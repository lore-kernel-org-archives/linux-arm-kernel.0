From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jul 2011 15:27:15 +0800
Subject: [GIT PULL] pxa: features for next
Message-ID: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Eric Miao (6):
      ARM: pxa: enable AUTO_ZRELADDR
      ARM: pxa: add common header file for pxa3xx
      ARM: pxa: avoid accessing interrupt registers directly
      ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
      ARM: pxa: move declarations from generic.h to <soc>.h
      ARM: pxa: enable MULTI_IRQ_HANDLER for all boards

Haojian Zhuang (2):
      ARM: pxa: add clk_set_rate()
      ARM: mmp/dkb: enable max7312 gpio expander

Tanmay Upadhyay (3):
      ARM: pxa168: Add support for UART3
      ARM: pxa168: Add support for Ethernet
      ARM: pxa168: Add board support for gplugD

Vasily Khoruzhick (1):
      ARM: pxa/z2: add poweroff function

 arch/arm/Kconfig                            |    2 +
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
 arch/arm/mach-pxa/cm-x300.c                 |    1 +
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
 arch/arm/mach-pxa/hx4700.c                  |    1 +
 arch/arm/mach-pxa/icontrol.c                |    1 +
 arch/arm/mach-pxa/idp.c                     |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h       |   12 ++
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
 arch/arm/mach-pxa/magician.c                |    1 +
 arch/arm/mach-pxa/mainstone.c               |    1 +
 arch/arm/mach-pxa/mioa701.c                 |    1 +
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
 arch/arm/mach-pxa/raumfeld.c                |    8 +-
 arch/arm/mach-pxa/saar.c                    |    1 +
 arch/arm/mach-pxa/saarb.c                   |    1 +
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
 75 files changed, 526 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-mmp/gplugd.c
 create mode 100644 arch/arm/mach-mmp/include/mach/mfp-gplugd.h
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/regs-intc.h
