From: viresh.linux@gmail.com (Viresh Kumar)
Date: Thu, 19 Apr 2012 21:58:15 +0530
Subject: [PATCH V2 0/6] SPEAr: Move to common clock framework
Message-ID: <cover.1334852393.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

SPEAr now supports common clock framework. This patchset contains changes
related to this.

V1->V2:
- Removed first seven commits as they are directly picked by Mike into his next.
- Moved SPEAr clock support to drivers/clk/spear/ from arch/arm/
- Fixed error handling issues in spear clk drivers
- Rearranged patches to get git bisect working

This patchset is rebased over:
- clk: add a fixed factor clock - by Sascha Hauer
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/090680.html

- common clk framework misc fixes - by Mike Turquette
https://lkml.org/lkml/2012/4/11/780

- V4: pinctrl: Add SPEAr pinctrl support
http://www.spinics.net/lists/arm-kernel/msg169387.html

- V3: SPEAr DT support updates
http://comments.gmane.org/gmane.linux.drivers.devicetree/14197


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
 drivers/clk/spear/clk-aux-synth.c               |  187 +++++
 drivers/clk/spear/clk-frac-synth.c              |  156 ++++
 drivers/clk/spear/clk-gpt-synth.c               |  145 ++++
 drivers/clk/spear/clk-vco-pll.c                 |  346 ++++++++
 drivers/clk/spear/clk.h                         |  152 ++++
 drivers/clk/spear/spear3xx_clock.c              |  612 ++++++++++++++
 drivers/clk/spear/spear6xx_clock.c              |  342 ++++++++
 28 files changed, 1992 insertions(+), 2955 deletions(-)
 delete mode 100644 arch/arm/mach-spear3xx/clock.c
 delete mode 100644 arch/arm/mach-spear6xx/clock.c
 delete mode 100644 arch/arm/plat-spear/clock.c
 delete mode 100644 arch/arm/plat-spear/include/plat/clock.h
 create mode 100644 drivers/clk/spear/Makefile
 create mode 100644 drivers/clk/spear/clk-aux-synth.c
 create mode 100644 drivers/clk/spear/clk-frac-synth.c
 create mode 100644 drivers/clk/spear/clk-gpt-synth.c
 create mode 100644 drivers/clk/spear/clk-vco-pll.c
 create mode 100644 drivers/clk/spear/clk.h
 create mode 100644 drivers/clk/spear/spear3xx_clock.c
 create mode 100644 drivers/clk/spear/spear6xx_clock.c

-- 
1.7.9
