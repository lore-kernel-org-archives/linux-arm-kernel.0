From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Aug 2012 01:43:14 -0700
Subject: [GIT PULL] omap fixes for v3.6-rc1
Message-ID: <20120814084314.GH11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Here are some omap fixes, these are probably too late for -rc1,
we're fine getting them in for -rc2 as well.

Regards,

Tony


The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.6-rc1

for you to fetch changes up to c5491d1ae1946d394389b83b31b87708e86dc4cf:

  ARM: OMAP: dmtimers: Fix locking issue in omap_dm_timer_request*() (2012-08-13 06:23:16 -0700)

----------------------------------------------------------------
Omap fixes for issues noted during the merge window, mostly
PM related.

----------------------------------------------------------------
Afzal Mohammed (1):
      arm/dts: Fix am33xx wdt node

Domenico Andreoli (1):
      OMAP: remove unused parameter arch_id from uncompress.h

Igor Grinberg (1):
      Revert "ARM: OMAP3530evm: set pendown_state and debounce time for ads7846"

Jan Luebbe (1):
      omap: Fix multi.h when only ARCH_OMAP3 and SOC_AM33XX are selected

Javier Martinez Canillas (1):
      ARM: OMAP3: igep0020: set GPIO mode for mux mcspi1_cs2 pin

Jon Hunter (1):
      ARM: OMAP2+: Fix dmtimer set source clock failure

Kevin Hilman (2):
      ARM: OMAP3: TWL4030: ensure sys_nirq1 is mux'd and wakeup enabled
      Revert "ARM: OMAP3: PM: call pre/post transition per powerdomain"

Michael Jones (1):
      omap2: mux: remove comment for nonexistent member

Rajendra Nayak (3):
      arm/dts: Mark vcxio, v2v1 and v1v8 regulators as always on
      cpufreq: OMAP: Handle missing frequency table on SMP systems
      ARM: OMAP4: Register the OPP table only for 4430 device

Santosh Shilimkar (2):
      OMAP2+: Fix random config build break with !ARM_CPU_SUSPEND
      ARM: OMAP4: sleep: Save the complete used register stack frame

Timo Kokkonen (1):
      ARM: OMAP: dmtimers: Fix locking issue in omap_dm_timer_request*()

Tony Lindgren (2):
      Merge branch 'for_3.6/fixes/ads7846-2' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes
      Merge branch 'for_3.6/fixes/pm' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes

Vaibhav Hiremath (1):
      ARM: OMAP2+: cpu: Add am33xx device under cpu_class_is_omap2

 arch/arm/boot/dts/am33xx.dtsi                |    5 +++++
 arch/arm/boot/dts/twl6030.dtsi               |    3 +++
 arch/arm/mach-omap2/Kconfig                  |    1 +
 arch/arm/mach-omap2/board-igep0020.c         |    2 ++
 arch/arm/mach-omap2/board-omap3evm.c         |    1 +
 arch/arm/mach-omap2/common-board-devices.c   |   11 -----------
 arch/arm/mach-omap2/common-board-devices.h   |    1 -
 arch/arm/mach-omap2/mux.h                    |    1 -
 arch/arm/mach-omap2/opp4xxx_data.c           |    2 +-
 arch/arm/mach-omap2/pm34xx.c                 |   19 ++++---------------
 arch/arm/mach-omap2/sleep44xx.S              |    8 ++++++--
 arch/arm/mach-omap2/twl-common.c             |    1 +
 arch/arm/plat-omap/dmtimer.c                 |    6 +++---
 arch/arm/plat-omap/include/plat/cpu.h        |    3 ++-
 arch/arm/plat-omap/include/plat/multi.h      |    9 +++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    4 +---
 drivers/cpufreq/omap-cpufreq.c               |    4 +++-
 17 files changed, 42 insertions(+), 39 deletions(-)
