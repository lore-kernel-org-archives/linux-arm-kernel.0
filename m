From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 4 Dec 2009 08:15:42 +0800
Subject: [GIT PULL] pxa: patches for this merge window
Message-ID: <f17812d70912031615q24fa7fc8gf01cac9ae83557b5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit 648f4e3e50c4793d9dbf9a09afa193631f76fa26:
  Linus Torvalds (1):
        Linux 2.6.32-rc8

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel

Antonio Ospite (5):
      [ARM] pxa/ezx: add camera support for A780 and A910 EZX phones
      [ARM] pxa/ezx: add leds-lp3944 support for A910 EZX phone
      [ARM] pxa/ezx: update ezx_defconfig now that ezx-pcap is in
      [ARM] pxa/em-x270: don't use pxa_camera init() callback
      [ARM] pxa/pcm990: don't use pxa_camera init() callback

Dmitry Artamonow (1):
      [ARM] pxa/hx4700: actually use platform_lcd driver

Eric Miao (5):
      [ARM] pxa: re-order platforms in Kconfig and Makefile
      [ARM] pxa: use platform_device_id table for SSP driver
      [ARM] pxa: introduce CONFIG_MACH_ZYLONITE{300,320} for CPU_PXA* removing
      [ARM] pxa: select CPU_PXA310 for MACH_COLIBRI300
      [ARM] pxa: make CPU_PXA* to be selectable hidden options

Haojian Zhuang (20):
      pxamci: introduce mmc_has_26mhz() and include pxa935
      backlight: da903x_bl: control WLED output current in da9034
      [ARM] pxa/saar: set default WLED output current
      pxa3xx_nand: fix memory out of bound
      pxa3xx_nand: reset read buffer before reading
      pxa3xx_nand: adjust timing of Micron NAND flash
      pxa3xx_nand: remove hardcode register address
      pxa3xx_nand: remove hardcode irq number
      pxa3xx_nand: disable nand irq in initialization
      pxa3xx_nand: add new nand chip support
      pxa3xx_nand: update dependancy to support ARCH_MMP
      pxa3xx_nand: move pxa3xx_nand.h common into plat directory
      [ARM] pxa: add nand device and clock for pxa168/pxa910
      [ARM] pxa: add nand support in aspensite board
      [ARM] pxa: add onenand support for TTC-DKB
      [ARM] pxa: add onenand support for SAAR
      [ARM] pxa: update flash structure in onenand info
      [ARM] pxa: add missing irq events for pxa168
      [ARM] pxa: add apmu clock support in mmp
      [ARM] pxa: rename macro from pxa9xx to pxa93x

Igor Grinberg (12):
      [ARM] pxa: register U2D clock for pxa3xx
      [ARM] pxa: add U2D registers and bits definitions
      [ARM] pxa/cm-x300: add revision difference handling
      [ARM] pxa/cm-x300: add TDO35S lcd support
      [ARM] pxa/cm-x300: add ac97 controller registration
      [ARM] pxa/cm-x300: add Wi2Wi chip (Bluetooth and WiFi) initialization
      [ARM] pxa/cm-x300: add support for PXA310 cpu
      [ARM] pxa/cm-x300: enable USB port 2 for PXA300
      [ARM] pxa/cm-x300: add da9030 support
      [ARM] pxa/cm-x300: update authors and copyright
      [ARM] pxa/cm-x300: update defconfig
      [ARM] pxa/cm-x300: add PWM backlight support

Jonathan Cameron (1):
      MAINTAINERS: Add entries for IMote 2 and Stargate 2

Jun Nie (2):
      pxa168fb: fix offset setting at initialization
      pxa168fb: remove useless vsync/hsync invert flag

Marc Zyngier (1):
      [ARM] pxa/viper: convert to use plat_serial8250_port irqflags field

Mike Rapoport (2):
      backlight: tdo24m: ensure chip select changes between transfers
      [ARM] pxa: add EXT_WAKEUP interrupts handling for pxa3xx

Pavel Machek (2):
      [ARM] pxa/zaurus: cleanup sharpsl_pm.c
      [ARM] pxa/zaurus: rename spitz_battery_levels_* to sharpsl_*

Pieter Grimmerink (1):
      pxafb: add transparency field to pxafb_mode_info struct

Russell King (1):
      [ARM] pxa: allow platforms to control which uarts are registered

Sven Neumann (1):
      pxafb: use passed fb_var_screeninfo struct in pxafb_pan_display()

Tom?? ?ech (2):
      [ARM] pxa/treo: generalisation of Treo680 code
      [ARM] pxa/treo: add Palm Centro 685 support

 MAINTAINERS                                        |   13 +
 arch/arm/configs/cm_x300_defconfig                 |  351 +++++---
 arch/arm/configs/ezx_defconfig                     |  947 ++++++++++++++------
 arch/arm/mach-mmp/aspenite.c                       |   39 +
 arch/arm/mach-mmp/clock.c                          |   15 +
 arch/arm/mach-mmp/clock.h                          |    1 +
 arch/arm/mach-mmp/include/mach/irqs.h              |    4 +-
 arch/arm/mach-mmp/include/mach/pxa168.h            |    7 +
 arch/arm/mach-mmp/include/mach/pxa910.h            |    7 +
 arch/arm/mach-mmp/pxa168.c                         |    5 +
 arch/arm/mach-mmp/pxa910.c                         |    4 +
 arch/arm/mach-mmp/ttc_dkb.c                        |   87 ++
 arch/arm/mach-pxa/Kconfig                          |  638 +++++++------
 arch/arm/mach-pxa/Makefile                         |   90 +-
 arch/arm/mach-pxa/balloon3.c                       |    4 +
 arch/arm/mach-pxa/cm-x2xx.c                        |    4 +
 arch/arm/mach-pxa/cm-x300.c                        |  260 +++++-
 arch/arm/mach-pxa/colibri-pxa270.c                 |    3 +
 arch/arm/mach-pxa/colibri-pxa300.c                 |    4 +
 arch/arm/mach-pxa/colibri-pxa320.c                 |    4 +
 arch/arm/mach-pxa/colibri-pxa3xx.c                 |    2 +-
 arch/arm/mach-pxa/corgi.c                          |    4 +
 arch/arm/mach-pxa/corgi_pm.c                       |    4 +-
 arch/arm/mach-pxa/csb726.c                         |    3 +
 arch/arm/mach-pxa/devices.c                        |   30 +-
 arch/arm/mach-pxa/e330.c                           |    3 +
 arch/arm/mach-pxa/e350.c                           |    3 +
 arch/arm/mach-pxa/e400.c                           |    3 +
 arch/arm/mach-pxa/e740.c                           |    3 +
 arch/arm/mach-pxa/e750.c                           |    3 +
 arch/arm/mach-pxa/e800.c                           |    3 +
 arch/arm/mach-pxa/em-x270.c                        |   13 +-
 arch/arm/mach-pxa/ezx.c                            |  251 +++++-
 arch/arm/mach-pxa/generic.h                        |    5 +
 arch/arm/mach-pxa/gumstix.c                        |    5 +
 arch/arm/mach-pxa/h5000.c                          |    3 +
 arch/arm/mach-pxa/himalaya.c                       |    3 +
 arch/arm/mach-pxa/hx4700.c                         |    5 +
 arch/arm/mach-pxa/idp.c                            |    3 +
 arch/arm/mach-pxa/imote2.c                         |    6 +-
 arch/arm/mach-pxa/include/mach/hardware.h          |    7 +-
 arch/arm/mach-pxa/include/mach/palmtreo.h          |   67 ++
 arch/arm/mach-pxa/include/mach/pxafb.h             |    3 +-
 arch/arm/mach-pxa/include/mach/regs-u2d.h          |  199 ++++
 arch/arm/mach-pxa/include/mach/treo680.h           |   49 -
 arch/arm/mach-pxa/littleton.c                      |    8 +-
 arch/arm/mach-pxa/lpd270.c                         |    4 +
 arch/arm/mach-pxa/lubbock.c                        |    4 +
 arch/arm/mach-pxa/magician.c                       |    4 +
 arch/arm/mach-pxa/mainstone.c                      |    4 +
 arch/arm/mach-pxa/mioa701.c                        |    3 +
 arch/arm/mach-pxa/mp900.c                          |    3 +
 arch/arm/mach-pxa/palmld.c                         |    4 +
 arch/arm/mach-pxa/palmt5.c                         |    4 +
 arch/arm/mach-pxa/palmtc.c                         |    5 +
 arch/arm/mach-pxa/palmte2.c                        |    4 +
 arch/arm/mach-pxa/{treo680.c => palmtreo.c}        |  365 ++++++--
 arch/arm/mach-pxa/palmtx.c                         |    4 +
 arch/arm/mach-pxa/palmz72.c                        |    4 +
 arch/arm/mach-pxa/pcm027.c                         |    4 +
 arch/arm/mach-pxa/pcm990-baseboard.c               |    8 +-
 arch/arm/mach-pxa/poodle.c                         |    4 +
 arch/arm/mach-pxa/pxa25x.c                         |    7 +-
 arch/arm/mach-pxa/pxa27x.c                         |    3 -
 arch/arm/mach-pxa/pxa3xx.c                         |   47 +-
 arch/arm/mach-pxa/saar.c                           |  105 +++-
 arch/arm/mach-pxa/sharpsl.h                        |    4 +-
 arch/arm/mach-pxa/sharpsl_pm.c                     |  112 ++--
 arch/arm/mach-pxa/spitz.c                          |    4 +
 arch/arm/mach-pxa/spitz_pm.c                       |   14 +-
 arch/arm/mach-pxa/ssp.c                            |   73 +--
 arch/arm/mach-pxa/stargate2.c                      |    4 +
 arch/arm/mach-pxa/tavorevb.c                       |    4 +
 arch/arm/mach-pxa/tosa.c                           |    5 +
 arch/arm/mach-pxa/trizeps4.c                       |    4 +
 arch/arm/mach-pxa/viper.c                          |   15 +-
 arch/arm/mach-pxa/xcep.c                           |    5 +
 arch/arm/mach-pxa/zylonite.c                       |    6 +-
 arch/arm/mm/mmu.c                                  |    2 +-
 .../mach => plat-pxa/include/plat}/pxa3xx_nand.h   |    0
 drivers/mmc/host/pxamci.c                          |   10 +-
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/mtd/nand/pxa3xx_nand.c                     |   82 ++-
 drivers/video/backlight/da903x_bl.c                |    7 +
 drivers/video/backlight/tdo24m.c                   |    1 +
 drivers/video/pxa168fb.c                           |    1 +
 drivers/video/pxafb.c                              |   23 +-
 include/linux/mfd/da903x.h                         |    4 +
 include/video/pxa168fb.h                           |    2 -
 89 files changed, 3068 insertions(+), 1081 deletions(-)
 create mode 100644 arch/arm/mach-pxa/include/mach/palmtreo.h
 create mode 100644 arch/arm/mach-pxa/include/mach/regs-u2d.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/treo680.h
 rename arch/arm/mach-pxa/{treo680.c => palmtreo.c} (53%)
 rename arch/arm/{mach-pxa/include/mach =>
plat-pxa/include/plat}/pxa3xx_nand.h (100%)
