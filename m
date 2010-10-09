From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 9 Oct 2010 18:18:34 +0800
Subject: [GIT PULL] pxa patches for next
Message-ID: <AANLkTikAz-tazXLBia-e_eqt23kz74dCrcCkfO+ftU6f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cb655d0f3d57c23db51b981648e452988c0223f9:
  Linus Torvalds (1):
        Linux 2.6.36-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Haojian Zhuang (7):
      ARM: pxa: encode IRQ number into .nr_irqs
      ARM: pxa168fb: add .remove function
      ARM: pxa: append tavorevb3 support
      ARM: mmp: support sparse irq
      ARM: pxa: reduce the scope of get_clk_frequency_khz()
      ARM: pxa: reduce the scope of get_memclk_frequency_10khz()
      ARM: mmp: update cpuid of pxa168 and pxa910

Igor Grinberg (3):
      ARM: pxa: add U2D controller and ULPI driver for pxa3xx
      ARM: ohci-pxa27x: enable OHCI over U2DC for pxa3xx
      ARM: pxa/cm-x300: enable USB host port2

Marek Vasut (2):
      ARM: pxa: fix pxa3xx-u2d crash when ULPI not used
      ARM: pxa/balloon3: Disperse MFP config

Mark F. Brown (11):
      ARM: pxa168: added framebuffer support code
      ARM: pxa168/aspenite: added initial support for TPO TD043MTEA1 LCD
      ARM: pxa: moved pxa27x_keypad.h to platform pxa directory
      ARM: pxa168: added keypad support
      ARM: pxa168: added wake clear register support for APMU
      ARM: pxa27x_keypad: added wakeup event handler for keypad interrupts
      ARM: pxa168: added keypad wake clear event support for platform
      ARM: pxa168/aspenite: add board support for keypad
      ARM: pxa168: added support for Teton BGA platform
      ARM: pxa168/teton bga: added keypad support
      ARM: pxa168/teton bga: add board support for i2c and rtc-ds1337

 MAINTAINERS                                        |    5 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/mach-mmp/Kconfig                          |    7 +
 arch/arm/mach-mmp/Makefile                         |    1 +
 arch/arm/mach-mmp/aspenite.c                       |   90 +++++
 arch/arm/mach-mmp/common.c                         |   10 +
 arch/arm/mach-mmp/flint.c                          |    4 +
 arch/arm/mach-mmp/include/mach/cputype.h           |   49 ++-
 arch/arm/mach-mmp/include/mach/irqs.h              |    4 +-
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h        |    7 +
 arch/arm/mach-mmp/include/mach/pxa168.h            |   20 +
 arch/arm/mach-mmp/include/mach/regs-apmu.h         |   12 +
 arch/arm/mach-mmp/include/mach/teton_bga.h         |   27 ++
 arch/arm/mach-mmp/jasper.c                         |    5 +-
 arch/arm/mach-mmp/pxa168.c                         |   16 +
 arch/arm/mach-mmp/teton_bga.c                      |   91 +++++
 arch/arm/mach-mmp/ttc_dkb.c                        |    4 +
 arch/arm/mach-pxa/Kconfig                          |   27 +-
 arch/arm/mach-pxa/Makefile                         |    3 +-
 arch/arm/mach-pxa/balloon3.c                       |  105 ++++--
 arch/arm/mach-pxa/cm-x2xx.c                        |    4 +
 arch/arm/mach-pxa/cm-x300.c                        |   77 ++++
 arch/arm/mach-pxa/cpufreq-pxa3xx.c                 |    5 +-
 arch/arm/mach-pxa/devices.c                        |   30 ++-
 arch/arm/mach-pxa/devices.h                        |    1 +
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/eseries.c                        |    7 +
 arch/arm/mach-pxa/ezx.c                            |   10 +-
 arch/arm/mach-pxa/generic.c                        |    6 +-
 arch/arm/mach-pxa/generic.h                        |    2 -
 arch/arm/mach-pxa/hx4700.c                         |    1 +
 arch/arm/mach-pxa/include/mach/balloon3.h          |    2 +
 arch/arm/mach-pxa/include/mach/eseries-irq.h       |    1 +
 arch/arm/mach-pxa/include/mach/hx4700.h            |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h              |   42 +--
 arch/arm/mach-pxa/include/mach/littleton.h         |    2 +
 arch/arm/mach-pxa/include/mach/lpd270.h            |    1 +
 arch/arm/mach-pxa/include/mach/lubbock.h           |    3 +
 arch/arm/mach-pxa/include/mach/magician.h          |    2 +
 arch/arm/mach-pxa/include/mach/mainstone.h         |    2 +
 arch/arm/mach-pxa/include/mach/mfp-pxa930.h        |    7 +
 arch/arm/mach-pxa/include/mach/pcm027.h            |    2 +
 arch/arm/mach-pxa/include/mach/poodle.h            |    2 +
 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h        |   35 ++
 arch/arm/mach-pxa/include/mach/tosa.h              |    1 +
 arch/arm/mach-pxa/include/mach/zeus.h              |    2 +
 arch/arm/mach-pxa/include/mach/zylonite.h          |    2 +
 arch/arm/mach-pxa/littleton.c                      |    3 +-
 arch/arm/mach-pxa/lpd270.c                         |    1 +
 arch/arm/mach-pxa/lubbock.c                        |    3 +-
 arch/arm/mach-pxa/magician.c                       |    1 +
 arch/arm/mach-pxa/mainstone.c                      |    3 +-
 arch/arm/mach-pxa/mioa701.c                        |    2 +-
 arch/arm/mach-pxa/palmld.c                         |    2 +-
 arch/arm/mach-pxa/palmt5.c                         |    2 +-
 arch/arm/mach-pxa/palmtreo.c                       |    2 +-
 arch/arm/mach-pxa/palmtx.c                         |    2 +-
 arch/arm/mach-pxa/palmz72.c                        |    2 +-
 arch/arm/mach-pxa/pcm027.c                         |    1 +
 arch/arm/mach-pxa/poodle.c                         |    1 +
 arch/arm/mach-pxa/pxa3xx-ulpi.c                    |  400 ++++++++++++++++++++
 arch/arm/mach-pxa/pxa3xx.c                         |   19 +-
 arch/arm/mach-pxa/pxa930.c                         |    2 +-
 arch/arm/mach-pxa/stargate2.c                      |    3 +
 arch/arm/mach-pxa/tavorevb.c                       |    2 +-
 arch/arm/mach-pxa/tavorevb3.c                      |  136 +++++++
 arch/arm/mach-pxa/tosa.c                           |    1 +
 arch/arm/mach-pxa/z2.c                             |    2 +-
 arch/arm/mach-pxa/zeus.c                           |    1 +
 arch/arm/mach-pxa/zylonite.c                       |    3 +-
 .../mach => plat-pxa/include/plat}/pxa27x_keypad.h |   10 +
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/pxa27x_keypad.c             |   12 +-
 drivers/usb/host/ohci-pxa27x.c                     |    7 +
 drivers/video/pxa168fb.c                           |   47 +++
 75 files changed, 1252 insertions(+), 161 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/teton_bga.h
 create mode 100644 arch/arm/mach-mmp/teton_bga.c
 create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
 create mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c
 create mode 100644 arch/arm/mach-pxa/tavorevb3.c
 rename arch/arm/{mach-pxa/include/mach =>
plat-pxa/include/plat}/pxa27x_keypad.h (83%)
