From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:56:33 +0530
Subject: [PATCH V6 00/11] SPEAr3xx & SPEAr6xx: Single Image solution and
	padmux updates
Message-ID: <cover.1298977709.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains following updates for SPEAr3xx & SPEAr6xx:
- Pad multiplexing updates
- Single Image solution

Note: These patches were earlier sent as part of a larger patchset:
"Updating SPEAr Support"

Now it is divided into smaller patchsets. In order to apply these patches
cleanly following order of patchsets must be maintained.
- SPEAr3xx & SPEAr6xx Fixes
- SPEAr3xx & SPEAr6xx: Single Image solution and padmux updates
- Adding SPEAr13xx support
- Adding devices support for all spear machines
- Clock Framework & CPU Freq Updates

Ryan Mallon (5):
  ST SPEAr3xx: Make local shirq structures static
  ST SPEAR3xx: Rename register/irq defines to remove naming conflicts
  ST SPEAr3xx: Rework pmx_dev code to remove conflicts
  ST SPEAr3xx: Rework KConfig to allow all boards to be compiled in
  ST SPEAr3xx: Replace defconfigs with single unified defconfig

Vipin Kumar (1):
  ST SPEAr: Pad multiplexing handling modified

Viresh Kumar (5):
  ST SPEAr clock: Define common clk_init routine in plat/clock.c
  ST SPEAr Clock: Updating for single image solution
  ST SPEAr3xx: Appending spear3** with global device structures
  ST SPEAr6xx: Rework Kconfig for single image solution
  ST SPEAR6xx: renaming spear600_defconfig as spear6xx_defconfig

 arch/arm/configs/spear310_defconfig                |   52 --
 arch/arm/configs/spear320_defconfig                |   52 --
 .../{spear300_defconfig => spear3xx_defconfig}     |    4 +-
 .../{spear600_defconfig => spear6xx_defconfig}     |    2 +-
 arch/arm/mach-spear3xx/Kconfig                     |   30 +-
 arch/arm/mach-spear3xx/Kconfig300                  |   17 -
 arch/arm/mach-spear3xx/Kconfig310                  |   17 -
 arch/arm/mach-spear3xx/Kconfig320                  |   17 -
 arch/arm/mach-spear3xx/clock.c                     |   74 ++-
 arch/arm/mach-spear3xx/include/mach/generic.h      |  215 ++++----
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  206 ++++----
 arch/arm/mach-spear3xx/include/mach/spear300.h     |   27 +-
 arch/arm/mach-spear3xx/include/mach/spear310.h     |   44 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h     |   48 +-
 arch/arm/mach-spear3xx/spear300.c                  |  449 ++++++++++-----
 arch/arm/mach-spear3xx/spear300_evb.c              |   32 +-
 arch/arm/mach-spear3xx/spear310.c                  |  247 +++++----
 arch/arm/mach-spear3xx/spear310_evb.c              |   45 +-
 arch/arm/mach-spear3xx/spear320.c                  |  579 +++++++++++++-------
 arch/arm/mach-spear3xx/spear320_evb.c              |   40 +-
 arch/arm/mach-spear3xx/spear3xx.c                  |  513 +++++++++++++-----
 arch/arm/mach-spear6xx/Kconfig                     |   15 +-
 arch/arm/mach-spear6xx/Kconfig600                  |   17 -
 arch/arm/mach-spear6xx/clock.c                     |    4 +-
 arch/arm/mach-spear6xx/include/mach/generic.h      |    2 +-
 arch/arm/mach-spear6xx/spear6xx.c                  |    2 +-
 arch/arm/plat-spear/clock.c                        |    5 +
 arch/arm/plat-spear/include/plat/clock.h           |    1 +
 arch/arm/plat-spear/include/plat/padmux.h          |   34 +-
 arch/arm/plat-spear/padmux.c                       |   54 +-
 30 files changed, 1698 insertions(+), 1146 deletions(-)
 delete mode 100644 arch/arm/configs/spear310_defconfig
 delete mode 100644 arch/arm/configs/spear320_defconfig
 rename arch/arm/configs/{spear300_defconfig => spear3xx_defconfig} (93%)
 rename arch/arm/configs/{spear600_defconfig => spear6xx_defconfig} (97%)
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig300
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig310
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig320
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig600

-- 
1.7.2.2
