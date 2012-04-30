From: viresh.linux@gmail.com (viresh kumar)
Date: Mon, 30 Apr 2012 21:38:43 +0530
Subject: [GIT PULL] ARM: spear-soc clock updates for 3.5
Message-ID: <CAOh2x=n11TXfKp3HkEPFTeFi2qO7tKmedSL7zPeU842-+tu47w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

This is pull request for SPEAr common clk framework updates. It had dependency
on spear/dt and spear/pinctrl for applying patches, and so i created a merge
of v3.4-rc5 with those branches.

Also, it has compilation dependencies with:
- Mike's clk-next branch
- Russell's: CLKDEV: Add helper routines to allocate and add clkdevs for ...

I have added Reviewed-by from Mike on these patches.

The following changes since commit 507f3bb673bf25ff0345986c72609debacdcee60:

  Merge branch 'spear/dt'; branch 'spear/pinctrl' into v3.4-rc5
(2012-04-30 13:30:19 +0530)

are available in the git repository at:


  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-clk

for you to fetch changes up to 9e1a2a12e55a9d8da21810cab91b91eb8f27be35:

  SPEAr: Switch to common clock framework (2012-04-30 13:36:13 +0530)

----------------------------------------------------------------
Sascha Hauer (1):
      clk: add a fixed factor clock

Viresh Kumar (6):
      SPEAr: clk: Add VCO-PLL Synthesizer clock
      SPEAr: clk: Add Auxiliary Synthesizer clock
      SPEAr: clk: Add Fractional Synthesizer clock
      SPEAr: clk: Add General Purpose Timer Synthesizer clock
      SPEAr: Call clk_prepare() before calling clk_enable
      SPEAr: Switch to common clock framework

 MAINTAINERS                                     |    4 +-
 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-spear3xx/Makefile                 |    2 +-
 arch/arm/mach-spear3xx/clock.c                  |  892 --------------------
 arch/arm/mach-spear3xx/include/mach/generic.h   |    4 +-
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |    2 +
 arch/arm/mach-spear3xx/include/mach/spear.h     |   13 +
 arch/arm/mach-spear3xx/spear300.c               |    1 -
 arch/arm/mach-spear3xx/spear310.c               |    1 -
 arch/arm/mach-spear3xx/spear320.c               |   12 +-
 arch/arm/mach-spear3xx/spear3xx.c               |    2 +
 arch/arm/mach-spear6xx/Makefile                 |    2 +-
 arch/arm/mach-spear6xx/clock.c                  |  789 ------------------
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |    2 +
 arch/arm/mach-spear6xx/spear6xx.c               |    5 +-
 arch/arm/plat-spear/Makefile                    |    2 +-
 arch/arm/plat-spear/clock.c                     | 1005 -----------------------
 arch/arm/plat-spear/include/plat/clock.h        |  249 ------
 arch/arm/plat-spear/time.c                      |    8 +-
 drivers/clk/Makefile                            |    5 +-
 drivers/clk/clk-fixed-factor.c                  |   95 +++
 drivers/clk/spear/Makefile                      |    8 +
 drivers/clk/spear/clk-aux-synth.c               |  192 +++++
 drivers/clk/spear/clk-frac-synth.c              |  159 ++++
 drivers/clk/spear/clk-gpt-synth.c               |  148 ++++
 drivers/clk/spear/clk-vco-pll.c                 |  350 ++++++++
 drivers/clk/spear/clk.c                         |   36 +
 drivers/clk/spear/clk.h                         |  134 +++
 drivers/clk/spear/spear3xx_clock.c              |  612 ++++++++++++++
 drivers/clk/spear/spear6xx_clock.c              |  342 ++++++++
 include/linux/clk-private.h                     |   20 +
 include/linux/clk-provider.h                    |   23 +
 32 files changed, 2164 insertions(+), 2956 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/clock.c
 delete mode 100644 arch/arm/mach-spear6xx/clock.c
 delete mode 100644 arch/arm/plat-spear/clock.c
 delete mode 100644 arch/arm/plat-spear/include/plat/clock.h
 create mode 100644 drivers/clk/clk-fixed-factor.c
 create mode 100644 drivers/clk/spear/Makefile
 create mode 100644 drivers/clk/spear/clk-aux-synth.c
 create mode 100644 drivers/clk/spear/clk-frac-synth.c
 create mode 100644 drivers/clk/spear/clk-gpt-synth.c
 create mode 100644 drivers/clk/spear/clk-vco-pll.c
 create mode 100644 drivers/clk/spear/clk.c
 create mode 100644 drivers/clk/spear/clk.h
 create mode 100644 drivers/clk/spear/spear3xx_clock.c
 create mode 100644 drivers/clk/spear/spear6xx_clock.c

-- 
viresh
