From: rmallon@gmail.com (Ryan Mallon)
Date: Wed, 14 Mar 2012 17:04:06 +1100
Subject: [GIT PULL] ep93xx for v3.4
Message-ID: <4F6034D6.1030208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

This my first attempt at doing at git pull request, so hopefully I
haven't messed it up :-).

Thanks,
~Ryan

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:
  Linus Torvalds (1):
        Linux 3.3-rc7

are available in the git repository at:

  git://github.com/RyanMallon/linux-2.6.git ep93xx-for-arm-soc

H Hartley Sweeten (1):
      ep93xx: Convert the watchdog driver into a platform device.

Ryan Mallon (10):
      ep93xx: Move PHYS_BASE defines to local SoC header file
      ep93xx: Don't use system controller defines in audio drivers
      ep93xx: Move GPIO defines to gpio-ep93xx.h
      ep93xx: Use ioremap for backlight driver
      ep93xx: Move peripheral defines to local SoC header
      ep93xx: Configure GPIO ports in core code
      ep93xx: Make syscon access functions private to SoC
      ep93xx: Move crunch code to mach-ep93xx directory
      ep93xx: Move EP93XX_SYSCON defines to SoC private header
      ep93xx: Remove unnecessary includes of ep93xx-regs.h

 arch/arm/kernel/Makefile                        |    3 -
 arch/arm/mach-ep93xx/Makefile                   |    3 +
 arch/arm/mach-ep93xx/adssphere.c                |    1 +
 arch/arm/mach-ep93xx/clock.c                    |    1 +
 arch/arm/mach-ep93xx/core.c                     |   54 ++++--
 arch/arm/{kernel => mach-ep93xx}/crunch-bits.S  |    0
 arch/arm/{kernel => mach-ep93xx}/crunch.c       |    4 +-
 arch/arm/mach-ep93xx/dma.c                      |    2 +
 arch/arm/mach-ep93xx/edb93xx.c                  |    1 +
 arch/arm/mach-ep93xx/gesbc9312.c                |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |  191 +--------------------
 arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |   10 +
 arch/arm/mach-ep93xx/include/mach/hardware.h    |    1 -
 arch/arm/mach-ep93xx/include/mach/platform.h    |   16 +--
 arch/arm/mach-ep93xx/micro9.c                   |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    2 +
 arch/arm/mach-ep93xx/snappercl15.c              |    2 +
 arch/arm/mach-ep93xx/soc.h                      |  213 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.c                   |    1 +
 arch/arm/mach-ep93xx/vision_ep9307.c            |    2 +
 drivers/gpio/gpio-ep93xx.c                      |    7 -
 drivers/video/backlight/ep93xx_bl.c             |   25 ++--
 drivers/video/ep93xx-fb.c                       |   18 +-
 drivers/watchdog/ep93xx_wdt.c                   |   51 ++++--
 sound/soc/ep93xx/edb93xx.c                      |    4 +-
 sound/soc/ep93xx/snappercl15.c                  |    4 +-
 26 files changed, 344 insertions(+), 274 deletions(-)
 rename arch/arm/{kernel => mach-ep93xx}/crunch-bits.S (100%)
 rename arch/arm/{kernel => mach-ep93xx}/crunch.c (98%)
 create mode 100644 arch/arm/mach-ep93xx/soc.h
