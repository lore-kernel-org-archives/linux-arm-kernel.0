From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Jun 2011 11:39:44 +0200
Subject: [GIT PULL] U300 and Ux500 patches for the arm-soc tree
Message-ID: <BANLkTik5HgtT5vFhxfODh3_G2zJ9c1YKmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

These are a number of trivial-and-simple patches that have been reviewed on
the LAKML mailing list. They are independent patches that are mostly
self-descriptive.

The clock added for TWD play with a patch that will be merged out-of-order
with this one, that makes the timer core reschedule events on the localtimer
when the CPU changes frequency. Marc Zyngier is carrying that patch as
part of the localtimer consolidation attempt.

There might be more coming, but this is good to pull in as a base for
the soc tree.

The following changes since commit 56299378726d5f2ba8d3c8cbbd13cb280ba45e4f:

  Linux 3.0-rc4 (2011-06-20 20:25:46 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
for-arnd

Linus Walleij (8):
      mach-ux500: add HREFv60 Kconfig option
      mach-ux500: fix HREFv60 regression
      mach-ux500: correct MMC/SDI parameters
      mach-ux500: activate USB in the U8500 defconfig
      mach-ux500: complete regulator constraints for MOP500 board
      mach-ux500: register a clock for the SMP TWD
      mach-u300: cleanup clockevent code
      mach-u300: set apropriate FIFO trigger levels

Mattias Wallin (1):
      mach-ux500: iomap PRCMU TCDM memory

 arch/arm/configs/u8500_defconfig              |    6 +++-
 arch/arm/mach-u300/spi.c                      |    4 +-
 arch/arm/mach-u300/timer.c                    |   33 ++++++-----------
 arch/arm/mach-ux500/Kconfig                   |    8 ++++-
 arch/arm/mach-ux500/board-mop500-regulators.c |    9 ++++-
 arch/arm/mach-ux500/board-mop500-sdi.c        |   42 +++++++++++++++------
 arch/arm/mach-ux500/board-mop500.c            |    3 ++
 arch/arm/mach-ux500/clock.c                   |   48 +++++++++++++++++++++++++
 arch/arm/mach-ux500/cpu-db5500.c              |    1 +
 9 files changed, 116 insertions(+), 38 deletions(-)
