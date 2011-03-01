From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:58:00 +0530
Subject: [PATCH V6 0/3] Clock Framework & CPU Freq Updates
Message-ID: <cover.1298977735.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains following updates:
- Adding support for DDR
- Adding support for PLL frequency change
- Adding support for CPU Freq framework

Note: These patches were earlier sent as part of a larger patchset:
"Updating SPEAr Support"

Now it is divided into smaller patchsets. In order to apply these patches
cleanly following order of patchsets must be maintained.
- SPEAr3xx & SPEAr6xx Fixes
- SPEAr3xx & SPEAr6xx: Single Image solution and padmux updates
- Adding SPEAr13xx support
- Adding devices support for all spear machines
- Clock Framework & CPU Freq Updates

Deepak Sikri (2):
  ST SPEAr Clock Framework: Adding support for PLL frequency change
  ST SPEAr CPU freq: Adding support for CPU Freq framework

Viresh Kumar (1):
  ST SPEAr Clock Framework: Adding support for DDR

 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-spear13xx/clock.c                 |   68 +++++++--
 arch/arm/mach-spear3xx/clock.c                  |  100 ++++++++++--
 arch/arm/mach-spear3xx/include/mach/misc_regs.h |    7 +
 arch/arm/mach-spear3xx/spear3xx.c               |    5 +
 arch/arm/mach-spear6xx/clock.c                  |  100 ++++++++++--
 arch/arm/mach-spear6xx/include/mach/misc_regs.h |    7 +
 arch/arm/mach-spear6xx/spear6xx.c               |    5 +
 arch/arm/plat-spear/Makefile                    |    4 +-
 arch/arm/plat-spear/clock.c                     |  124 +++++++++++++---
 arch/arm/plat-spear/cpufreq.c                   |  164 ++++++++++++++++++++
 arch/arm/plat-spear/include/plat/clock.h        |   44 ++++--
 arch/arm/plat-spear/pll_clk.S                   |  187 +++++++++++++++++++++++
 13 files changed, 731 insertions(+), 85 deletions(-)
 create mode 100644 arch/arm/plat-spear/cpufreq.c
 create mode 100644 arch/arm/plat-spear/pll_clk.S

-- 
1.7.2.2
