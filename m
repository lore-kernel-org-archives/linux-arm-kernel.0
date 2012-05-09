From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 May 2012 16:43:42 +0530
Subject: [GIT PULL] SPEAr clk updates for v-3.5
Message-ID: <1336562022-24368-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,Olof,

This is rebased over a (merge of Mike's/clk-next & SPEAr's DT) + Russell's
patch: CLKDEV: provide helpers for common clock framework rebased over them.

Other pull requests will be rebased over this one.

The following changes since commit 82d8f4b7ea3ebaf7f6dfe2cd8a25045d9ff95d5b:

  CLKDEV: provide helpers for common clock framework (2012-05-09 14:43:39 +0530)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-clk

for you to fetch changes up to df8e37e5972dd4ea2a4a0e5dbfdab14b00e98b70:

  SPEAr: Switch to common clock framework (2012-05-09 14:44:57 +0530)

----------------------------------------------------------------
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
 drivers/clk/Makefile                            |    3 +
 drivers/clk/spear/Makefile                      |    8 +
 drivers/clk/spear/clk-aux-synth.c               |  198 +++++
 drivers/clk/spear/clk-frac-synth.c              |  165 ++++
 drivers/clk/spear/clk-gpt-synth.c               |  154 ++++
 drivers/clk/spear/clk-vco-pll.c                 |  363 ++++++++
 drivers/clk/spear/clk.c                         |   36 +
 drivers/clk/spear/clk.h                         |  134 +++
 drivers/clk/spear/spear3xx_clock.c              |  612 ++++++++++++++
 drivers/clk/spear/spear6xx_clock.c              |  342 ++++++++
 29 files changed, 2056 insertions(+), 2955 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/clock.c
 delete mode 100644 arch/arm/mach-spear6xx/clock.c
 delete mode 100644 arch/arm/plat-spear/clock.c
 delete mode 100644 arch/arm/plat-spear/include/plat/clock.h
 create mode 100644 drivers/clk/spear/Makefile
 create mode 100644 drivers/clk/spear/clk-aux-synth.c
 create mode 100644 drivers/clk/spear/clk-frac-synth.c
 create mode 100644 drivers/clk/spear/clk-gpt-synth.c
 create mode 100644 drivers/clk/spear/clk-vco-pll.c
 create mode 100644 drivers/clk/spear/clk.c
 create mode 100644 drivers/clk/spear/clk.h
 create mode 100644 drivers/clk/spear/spear3xx_clock.c
 create mode 100644 drivers/clk/spear/spear6xx_clock.c
