From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Sep 2011 09:53:42 +0200
Subject: [GIT PULL] ux500-core for 3.2
Message-ID: <CACRpkdZofKjOrPFWNR-2D0LWx3NGMiLwyhf7gAVdvBGvQHqJLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

could you please pull:

git://git.linaro.org/people/triad/linux-stericsson.git for-arnd

to the ARM SoC tree (ux500 branch or however you prefer to handle it)?
They have all been reviewed on the ARM list recently and are mostly
minor fixes and Lee Jones nice cleanup patch.

I might be stacking up more but this is a good start.

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://git.linaro.org/people/triad/linux-stericsson.git for-arnd

Barry Song (1):
      ARM: mach-ux500: add explicit cpu_relax() for busy wait loop

Fredrik Svensson (1):
      mach-ux500: remove pull-pinconfig and add SPI2

Lee Jones (1):
      mach-ux500: remove most of the ugly machine_is_*() calls

Linus Walleij (2):
      mach-ux500: factor out l2x0 handling code
      mach-ux500: unlock I&D l2x0 caches before init

srinidhi kasagar (1):
      mach-ux500: enable fix for ARM errata 754322

 arch/arm/mach-ux500/Kconfig                   |    1 +
 arch/arm/mach-ux500/Makefile                  |    1 +
 arch/arm/mach-ux500/board-mop500-pins.c       |   34 ++++--
 arch/arm/mach-ux500/board-mop500-sdi.c        |   52 ++++++---
 arch/arm/mach-ux500/board-mop500.c            |   78 +++++++++++---
 arch/arm/mach-ux500/board-mop500.h            |    3 +
 arch/arm/mach-ux500/cache-l2x0.c              |   95 +++++++++++++++++
 arch/arm/mach-ux500/cpu.c                     |   69 ------------
 arch/arm/mach-ux500/include/mach/uncompress.h |   10 +--
 arch/arm/mach-ux500/pins-db8500.h             |  142 +++++++++++++------------
 arch/arm/plat-nomadik/include/plat/pincfg.h   |    5 -
 11 files changed, 294 insertions(+), 196 deletions(-)
 create mode 100644 arch/arm/mach-ux500/cache-l2x0.c
