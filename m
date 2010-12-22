From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 22 Dec 2010 17:09:38 +0800
Subject: [GIT PULL] pxa: patches for next merge window
Message-ID: <AANLkTinfEi_cYiHxqC=pKxqqdXYVHnZYKLX+OEiGJYNk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b0c3844d8af6b9f3f18f31e1b0502fbefa2166be:

  Linux 2.6.37-rc6 (2010-12-15 17:24:48 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Bjorn Forsman (1):
      ARM: pxa/colibri: setup pins for USB host port 3

Daniel Mack (2):
      video: add driver for PXA3xx 2D graphics accelerator
      ARM: pxa/raumfeld: enable PXA3XX_GCU driver

Eric Miao (9):
      ARM: pxa: remove un-used mapping of camera registers
      ARM: pxa: introduce addr-map.h for large bus addresses and ranges
      ARM: pxa: replace duplicated macro DEFINE_PXA3_CK() with DEFINE_CK()
      ARM: pxa: separate the clock support into clock-{pxa2xx,pxa3xx}.c
      ARM: pxa: remove get_memclk_frequency_10khz()
      ARM: pxa: introduce pxa2xx_clock_sysclass for clock suspend/resume
      ARM: pxa: introduce pxa3xx_clock_sysclass for clock suspend/resume
      ARM: pxa: add clock for static memory controller
      ARM: mmp: correct the naming of GPIOxx_GPIO definitions

Haojian Zhuang (9):
      ARM: mmp: append brownstone support
      ARM: mmp: fix the typo - MMP2 is compatible with ARMv7
      ARM: pxa: redefine the cpu_is_pxa3xx
      ARM: pxa: redefine irqs.h
      ARM: pxa: support pxa95x
      ARM: pxa: support saarb platform
      ARM: mmp: select CPU_PJ4
      ARM: pxa: sanitize IRQ registers access based on offset
      ARM: pxa: add iwmmx support for PJ4

Marek Vasut (13):
      ARM: pxa: Introduce pxa{25x,27x,3xx}_map_io()
      ARM: pxa: Access SMEMC via virtual addresses
      ARM: pxa: Add pxa320 PCMCIA check
      ARM: pxa: Toradex Colibri PXA270 CF support
      ARM: pxa: Push Colibri evalboard MFP into module files
      ARM: pxa: Add M41T00 RTC support into Colibri evalboard
      ARM: pxa: Rename Colibri evalboard
      ARM: pxa: Colibri PXA320 PCMCIA driver
      ARM: pxa: Modularize Palm Tungsten|C
      ARM: pxa: Add gpio-leds and vibrator support to PalmTC
      ARM: pxa: Fix number of IRQs on Balloon3
      ARM: pxa: Update Balloon3 for new FPGA firmware
      ARM: pxa: Add Balloon3 NAND ready check

Mark F. Brown (1):
      ARM: mmp: refactored 5V regulator support using fixed-regulator

Zhangfei Gao (2):
      ARM: mmp: add mmc resource
      ARM: mmp: add sd card to jasper

cxie4 (1):
      ARM: mmp: add usb clock for pxa168/pxa910

 arch/arm/Kconfig                                   |    4 +-
 arch/arm/kernel/Makefile                           |    1 +
 arch/arm/kernel/iwmmxt.S                           |   55 ++-
 arch/arm/kernel/pj4-cp0.c                          |   94 +++
 arch/arm/mach-mmp/Kconfig                          |   22 +-
 arch/arm/mach-mmp/Makefile                         |    1 +
 arch/arm/mach-mmp/brownstone.c                     |  204 ++++++
 arch/arm/mach-mmp/flint.c                          |    2 +-
 arch/arm/mach-mmp/include/mach/mfp-mmp2.h          |  338 +++++-----
 arch/arm/mach-mmp/include/mach/mmp2.h              |   22 +
 arch/arm/mach-mmp/include/mach/regs-apmu.h         |    2 +
 arch/arm/mach-mmp/jasper.c                         |   35 +
 arch/arm/mach-mmp/mmp2.c                           |   35 +
 arch/arm/mach-mmp/pxa910.c                         |    2 +
 arch/arm/mach-pxa/Kconfig                          |   24 +-
 arch/arm/mach-pxa/Makefile                         |   10 +-
 arch/arm/mach-pxa/balloon3.c                       |   59 +-
 arch/arm/mach-pxa/capc7117.c                       |    2 +-
 arch/arm/mach-pxa/clock-pxa2xx.c                   |   64 ++
 arch/arm/mach-pxa/clock-pxa3xx.c                   |  218 ++++++
 arch/arm/mach-pxa/clock.c                          |   26 +-
 arch/arm/mach-pxa/clock.h                          |   47 +-
 arch/arm/mach-pxa/cm-x2xx.c                        |   26 +-
 arch/arm/mach-pxa/cm-x300.c                        |    2 +-
 ...ibri-pxa270-evalboard.c => colibri-evalboard.c} |   96 ++--
 arch/arm/mach-pxa/colibri-pxa270-income.c          |   47 --
 arch/arm/mach-pxa/colibri-pxa270.c                 |  108 +++-
 arch/arm/mach-pxa/colibri-pxa300.c                 |   73 +-
 arch/arm/mach-pxa/colibri-pxa320.c                 |  139 ++--
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |   49 --
 arch/arm/mach-pxa/corgi.c                          |    6 +-
 arch/arm/mach-pxa/cpufreq-pxa2xx.c                 |   10 +-
 arch/arm/mach-pxa/csb726.c                         |    9 +-
 arch/arm/mach-pxa/devices.c                        |  247 ++++----
 arch/arm/mach-pxa/em-x270.c                        |    4 +-
 arch/arm/mach-pxa/eseries.c                        |   12 +-
 arch/arm/mach-pxa/ezx.c                            |   12 +-
 arch/arm/mach-pxa/generic.c                        |   48 +-
 arch/arm/mach-pxa/generic.h                        |   11 +-
 arch/arm/mach-pxa/gumstix.c                        |    2 +-
 arch/arm/mach-pxa/h5000.c                          |   11 +-
 arch/arm/mach-pxa/himalaya.c                       |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/icontrol.c                       |    2 +-
 arch/arm/mach-pxa/idp.c                            |    2 +-
 arch/arm/mach-pxa/include/mach/addr-map.h          |   48 ++
 arch/arm/mach-pxa/include/mach/balloon3.h          |    6 +-
 arch/arm/mach-pxa/include/mach/colibri.h           |   14 +-
 arch/arm/mach-pxa/include/mach/hardware.h          |   47 +-
 arch/arm/mach-pxa/include/mach/irqs.h              |   48 +-
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h       |   66 --
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h       |    9 -
 arch/arm/mach-pxa/include/mach/regs-intc.h         |    4 -
 arch/arm/mach-pxa/include/mach/smemc.h             |   74 ++
 arch/arm/mach-pxa/irq.c                            |  129 +++--
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/lpd270.c                         |    5 +-
 arch/arm/mach-pxa/lubbock.c                        |    5 +-
 arch/arm/mach-pxa/magician.c                       |    2 +-
 arch/arm/mach-pxa/mainstone.c                      |    5 +-
 arch/arm/mach-pxa/mioa701.c                        |    2 +-
 arch/arm/mach-pxa/mp900.c                          |    2 +-
 arch/arm/mach-pxa/palmld.c                         |    2 +-
 arch/arm/mach-pxa/palmt5.c                         |    2 +-
 arch/arm/mach-pxa/palmtc.c                         |  190 ++++-
 arch/arm/mach-pxa/palmte2.c                        |    2 +-
 arch/arm/mach-pxa/palmtreo.c                       |    4 +-
 arch/arm/mach-pxa/palmtx.c                         |    2 +-
 arch/arm/mach-pxa/palmz72.c                        |    2 +-
 arch/arm/mach-pxa/pcm027.c                         |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/pxa25x.c                         |   86 ++-
 arch/arm/mach-pxa/pxa27x.c                         |  102 ++-
 arch/arm/mach-pxa/pxa3xx.c                         |  234 +------
 arch/arm/mach-pxa/pxa930.c                         |    2 +-
 arch/arm/mach-pxa/pxa95x.c                         |  308 ++++++++
 arch/arm/mach-pxa/raumfeld.c                       |   11 +-
 arch/arm/mach-pxa/saar.c                           |    2 +-
 arch/arm/mach-pxa/saarb.c                          |  114 +++
 arch/arm/mach-pxa/sleep.S                          |    2 +-
 arch/arm/mach-pxa/smemc.c                          |   51 +-
 arch/arm/mach-pxa/spitz.c                          |   13 +-
 arch/arm/mach-pxa/stargate2.c                      |    7 +-
 arch/arm/mach-pxa/tavorevb.c                       |    2 +-
 arch/arm/mach-pxa/tavorevb3.c                      |    2 +-
 arch/arm/mach-pxa/tosa.c                           |    9 +-
 arch/arm/mach-pxa/trizeps4.c                       |    5 +-
 arch/arm/mach-pxa/viper.c                          |    2 +-
 arch/arm/mach-pxa/vpac270.c                        |    2 +-
 arch/arm/mach-pxa/xcep.c                           |    7 +-
 arch/arm/mach-pxa/z2.c                             |    2 +-
 arch/arm/mach-pxa/zeus.c                           |   10 +-
 arch/arm/mach-pxa/zylonite.c                       |    2 +-
 arch/arm/mm/Kconfig                                |    8 +-
 arch/arm/plat-pxa/Makefile                         |    1 +
 arch/arm/plat-pxa/include/plat/mfp.h               |    4 +-
 drivers/pcmcia/Kconfig                             |    3 +-
 drivers/pcmcia/Makefile                            |    2 +
 drivers/pcmcia/pxa2xx_balloon3.c                   |   11 +-
 drivers/pcmcia/pxa2xx_base.c                       |   64 ++-
 drivers/pcmcia/pxa2xx_colibri.c                    |  229 ++++++
 drivers/pcmcia/soc_common.h                        |    3 +
 drivers/video/Kconfig                              |   10 +
 drivers/video/Makefile                             |    1 +
 drivers/video/pxa3xx-gcu.c                         |  772 ++++++++++++++++++++
 drivers/video/pxa3xx-gcu.h                         |   38 +
 106 files changed, 3671 insertions(+), 1313 deletions(-)
 create mode 100644 arch/arm/kernel/pj4-cp0.c
 create mode 100644 arch/arm/mach-mmp/brownstone.c
 create mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
 create mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
 rename arch/arm/mach-pxa/{colibri-pxa270-evalboard.c =>
colibri-evalboard.c} (51%)
 create mode 100644 arch/arm/mach-pxa/include/mach/addr-map.h
 create mode 100644 arch/arm/mach-pxa/include/mach/smemc.h
 create mode 100644 arch/arm/mach-pxa/pxa95x.c
 create mode 100644 arch/arm/mach-pxa/saarb.c
 create mode 100644 drivers/pcmcia/pxa2xx_colibri.c
 create mode 100644 drivers/video/pxa3xx-gcu.c
 create mode 100644 drivers/video/pxa3xx-gcu.h
