From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 10 May 2012 16:56:36 +0530
Subject: [GIT PULL] SPEAr clk updates for v-3.5
In-Reply-To: <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
References: <1336562022-24368-1-git-send-email-viresh.kumar@st.com>
 <CAOesGMj5ubYcjXWRM2z9ZYOfHGn11sXKgDx8dgXy_bDYLH3HLg@mail.gmail.com>
Message-ID: <4FABA5EC.9050708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/10/2012 12:44 PM, Olof Johansson wrote:
> Russell has published a clkdev branch that you pull instead of
> applying his patch manually, that way there will be no surprises with
> respect to conflicts, etc:
> 
> git://ftp.arm.linux.org.uk/~rmk/linux-next.git clkdev

Sure, Please check below pull request. I will reply on other pull requests too.

The following changes since commit 31947e6af9150f93f3df5544550504ae8ce3a052:

  Merge branch 'spear/dt'; branch 'spear/pinctrl'; rmk/clkdev into mike/clk-next (2012-05-10 16:11:11 +0530)

are available in the git repository at:


  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear-clk

for you to fetch changes up to 6723741b37f5463593c6d5338c5dbffe311c877c:

  SPEAr: Switch to common clock framework (2012-05-10 16:15:05 +0530)

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

-- 
viresh
