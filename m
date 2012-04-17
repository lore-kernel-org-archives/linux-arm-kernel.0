From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:32 +0530
Subject: [PATCH 00/13] SPEAr: Move to common clock framework
Message-ID: <cover.1334660431.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

SPEAr now supports common clock framework. This patchset contains changes
related to this. It also contain few dependency commits for clock framework that
are earlier sent separately.

@Mike: It would be easiest to get these through ARM-SoC tree. So, would need
your Acked-by on these patches. But firstly they must get reivewed :)

This patchset is rebased over:
- clk: add a fixed factor clock - by Sascha Hauer
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/090680.html

- common clk framework misc fixes - by Mike Turquette
https://lkml.org/lkml/2012/4/11/780

- V4: pinctrl: Add SPEAr pinctrl support
http://www.spinics.net/lists/arm-kernel/msg169387.html

- V3: SPEAr DT support updates
http://comments.gmane.org/gmane.linux.drivers.devicetree/14197

Russell King (1):
  CLKDEV: Add helper routines to allocate and add clkdevs for given
    struct clk *

Viresh Kumar (12):
  clk: Fix typo in comment
  clk: Fix typo in comment
  clk: clk-private: Add DEFINE_CLK macro
  clk: clk-gate: Create clk_gate_endisable()
  clk: Don't set clk->new_rate twice
  clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is set and clk is
    enabled
  SPEAr: clk: Add VCO-PLL Synthesizer clock
  SPEAr: clk: Add Auxiliary Synthesizer clock
  SPEAr: clk: Add Fractional Synthesizer clock
  SPEAr: clk: Add General Purpose Timer Synthesizer clock
  SPEAr: Switch to common clock framework
  SPEAr: Call clk_prepare() before calling clk_enable

 MAINTAINERS                                     |    4 +-
 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-spear3xx/clock.c                  | 1354 +++++++++--------------
 arch/arm/mach-spear3xx/include/mach/generic.h   |    4 +-
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |    2 +
 arch/arm/mach-spear3xx/include/mach/spear.h     |   13 +
 arch/arm/mach-spear3xx/spear300.c               |    1 -
 arch/arm/mach-spear3xx/spear310.c               |    1 -
 arch/arm/mach-spear3xx/spear320.c               |   12 +-
 arch/arm/mach-spear3xx/spear3xx.c               |    2 +
 arch/arm/mach-spear6xx/clock.c                  | 1015 +++++------------
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |    2 +
 arch/arm/mach-spear6xx/spear6xx.c               |    5 +-
 arch/arm/plat-spear/Makefile                    |    3 +-
 arch/arm/plat-spear/clk-aux-synth.c             |  195 ++++
 arch/arm/plat-spear/clk-frac-synth.c            |  156 +++
 arch/arm/plat-spear/clk-gpt-synth.c             |  145 +++
 arch/arm/plat-spear/clk-vco-pll.c               |  346 ++++++
 arch/arm/plat-spear/clock.c                     | 1005 -----------------
 arch/arm/plat-spear/include/plat/clk.h          |  143 +++
 arch/arm/plat-spear/include/plat/clock.h        |  249 -----
 arch/arm/plat-spear/time.c                      |    8 +-
 drivers/clk/clk-gate.c                          |   54 +-
 drivers/clk/clk.c                               |    7 +-
 drivers/clk/clkdev.c                            |   64 +-
 include/linux/clk-private.h                     |   59 +-
 include/linux/clk-provider.h                    |    4 +-
 include/linux/clkdev.h                          |    3 +
 28 files changed, 1963 insertions(+), 2894 deletions(-)
 create mode 100644 arch/arm/plat-spear/clk-aux-synth.c
 create mode 100644 arch/arm/plat-spear/clk-frac-synth.c
 create mode 100644 arch/arm/plat-spear/clk-gpt-synth.c
 create mode 100644 arch/arm/plat-spear/clk-vco-pll.c
 delete mode 100644 arch/arm/plat-spear/clock.c
 create mode 100644 arch/arm/plat-spear/include/plat/clk.h
 delete mode 100644 arch/arm/plat-spear/include/plat/clock.h

-- 
1.7.9
