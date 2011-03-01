From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:06 +0530
Subject: [PATCH V6 0/8] SPEAr3xx & SPEAr6xx Fixes
Message-ID: <cover.1298977691.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains minor fixes, renames, & reordering of code of #include
files.

Note: These patches were earlier sent as part of a larger patchset:
"Updating SPEAr Support"

Now it is divided into smaller patchsets. In order to apply these patches
cleanly following order of patchsets must be maintained.
- SPEAr3xx & SPEAr6xx Fixes
- SPEAr3xx & SPEAr6xx: Single Image solution and padmux updates
- Adding SPEAr13xx support
- Adding devices support for all spear machines
- Clock Framework & CPU Freq Updates

Shiraz Hashim (1):
  ST SPEAr: Append UL to device address macros.

Viresh Kumar (7):
  ST SPEAr: Reordering #includes in .h & .c files.
  ST SPEAr: Include mach/hardware.h instead of mach/spear.h
  ST SPEAr3xx: Rename sdio to sdhci
  ST SPEAr Clock Framework: Rename usbd clock and align apb_clk entry
  ST SPEAr3xx: Declare device structures after shirq code
  ST SPEAr: Replacing SIZE macro's with SZ_4K macros
  ST SPEAr: Remove unused *_SIZE macros from spear*.h files

 arch/arm/mach-spear3xx/clock.c                    |    6 +-
 arch/arm/mach-spear3xx/include/mach/entry-macro.S |    3 +-
 arch/arm/mach-spear3xx/include/mach/generic.h     |   12 +-
 arch/arm/mach-spear3xx/include/mach/hardware.h    |    1 +
 arch/arm/mach-spear3xx/include/mach/irqs.h        |    4 +-
 arch/arm/mach-spear3xx/include/mach/misc_regs.h   |    2 +-
 arch/arm/mach-spear3xx/include/mach/spear.h       |  135 +++++------------
 arch/arm/mach-spear3xx/include/mach/spear300.h    |   59 ++-----
 arch/arm/mach-spear3xx/include/mach/spear310.h    |   34 ++---
 arch/arm/mach-spear3xx/include/mach/spear320.h    |   67 +++------
 arch/arm/mach-spear3xx/spear300.c                 |   70 ++++-----
 arch/arm/mach-spear3xx/spear300_evb.c             |    4 +-
 arch/arm/mach-spear3xx/spear310.c                 |   10 +-
 arch/arm/mach-spear3xx/spear310_evb.c             |    2 +-
 arch/arm/mach-spear3xx/spear320.c                 |   30 ++--
 arch/arm/mach-spear3xx/spear320_evb.c             |    4 +-
 arch/arm/mach-spear3xx/spear3xx.c                 |   14 +-
 arch/arm/mach-spear6xx/clock.c                    |    6 +-
 arch/arm/mach-spear6xx/include/mach/entry-macro.S |    3 +-
 arch/arm/mach-spear6xx/include/mach/generic.h     |    4 +-
 arch/arm/mach-spear6xx/include/mach/hardware.h    |    1 +
 arch/arm/mach-spear6xx/include/mach/misc_regs.h   |    2 +-
 arch/arm/mach-spear6xx/include/mach/spear.h       |  175 ++++++---------------
 arch/arm/mach-spear6xx/spear600.c                 |    2 +-
 arch/arm/mach-spear6xx/spear600_evb.c             |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c                 |   29 ++--
 arch/arm/plat-spear/include/plat/debug-macro.S    |    2 +-
 arch/arm/plat-spear/include/plat/system.h         |    4 +-
 arch/arm/plat-spear/include/plat/uncompress.h     |    2 +-
 arch/arm/plat-spear/time.c                        |    5 +-
 30 files changed, 235 insertions(+), 459 deletions(-)

-- 
1.7.2.2
