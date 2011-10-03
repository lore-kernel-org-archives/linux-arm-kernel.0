From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Oct 2011 09:41:21 +0200
Subject: [GIT PULL] ux500-timers
In-Reply-To: <CACRpkdbCZwSdXzqvPCrGagaikc53xLyDTQaZMRtuyqo9vw=Yng@mail.gmail.com>
References: <CACRpkdbCZwSdXzqvPCrGagaikc53xLyDTQaZMRtuyqo9vw=Yng@mail.gmail.com>
Message-ID: <CACRpkdZDUeP6pJt7W2ntGGdUgeGGwEG9we-Jmc9bvP40Oy+JQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

could you please pull the updated ux500 timer branch into the arm-soc
tree?

The following changes since commit d93dc5c4478c1fd5de85a3e8aece9aad7bbae044:

  Linux 3.1-rc7 (2011-09-21 16:58:15 -0700)

are available in the git repository at:
   git://git.linaro.org/people/triad/linux-stericsson.git ux500-nomadik-timers

Jonas Aaberg (4):
      ARM: ux500: Move timer code to separate file
      ARM: plat-nomadik: timer: Add support for periodic timers
      ARM: plat-nomadik: timer: Export reset functions
      ARM: ux500: Reprogram timers upon resume

Linus Walleij (1):
      clocksource: fixup ux500 build problems

Mattias Wallin (3):
      ARM: plat-nomadik: MTU sched_clock as an option
      clocksource: add DBX500 PRCMU Timer support
      ARM: ux500: add support for clocksource DBX500 PRCMU

 arch/arm/mach-ux500/Makefile                   |    2 +-
 arch/arm/mach-ux500/cpu.c                      |   29 +-----
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    2 +
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    3 +
 arch/arm/mach-ux500/timer.c                    |   68 ++++++++++++
 arch/arm/plat-nomadik/Kconfig                  |    8 ++-
 arch/arm/plat-nomadik/include/plat/mtu.h       |   47 +--------
 arch/arm/plat-nomadik/timer.c                  |  138 ++++++++++++++++++------
 drivers/clocksource/Kconfig                    |   15 +++
 drivers/clocksource/Makefile                   |    1 +
 drivers/clocksource/clksrc-dbx500-prcmu.c      |  106 ++++++++++++++++++
 include/linux/clksrc-dbx500-prcmu.h            |   20 ++++
 12 files changed, 333 insertions(+), 106 deletions(-)
 create mode 100644 arch/arm/mach-ux500/timer.c
 create mode 100644 drivers/clocksource/clksrc-dbx500-prcmu.c
 create mode 100644 include/linux/clksrc-dbx500-prcmu.h
