From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 07:02:35 +0000
Subject: [GIT PULL] arm-soc: bug fixes for v3.6-rc3
Message-ID: <201208200702.35629.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the latest fixes from the arm-soc tree. Since most patches
came in after I sent out the previous pull request but before -rc2, the
branch is based on the last commit you pulled from me, in case you are
wondering.

	Arnd

The following changes since commit de9234306bb28fe6c8c3bb908e3f9956f5276a02:

  ARM: davinci: remove broken ntosd2_init_i2c (2012-08-10 13:14:36 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 8a211d362cc94df2bb42323ab13d258650529bec:

  Merge branch 'fixes' of git://github.com/hzhuang1/linux into fixes (2012-08-16 10:10:15 +0200)

----------------------------------------------------------------

arm-soc: bug fixes for v3.6-rc3

The bug fixes this time are mostly for the TI omap platforms, but there
are also a couple for the various Marvell platforms.

----------------------------------------------------------------
Afzal Mohammed (1):
      arm/dts: Fix am33xx wdt node

Arnaud Patard (3):
      ARM: Orion: Set eth packet size csum offload limit
      ARM: Kirkwood: Fix iconnect leds
      ARM: Kirkwood: fix Makefile.boot

Arnd Bergmann (4):
      ARM: mv78xx0: fix win_cfg_base prototype
      Merge tag 'omap-fixes-for-v3.6-rc1' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge branch 'fixes-for-v3.6' of git://git.infradead.org/users/jcooper/linux into fixes
      Merge branch 'fixes' of git://github.com/hzhuang1/linux into fixes

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

Yuanhan Liu (1):
      ARM: mmp: fix potential NULL dereference

 arch/arm/boot/dts/am33xx.dtsi                |    5 +++++
 arch/arm/boot/dts/kirkwood-iconnect.dts      |    6 +++++-
 arch/arm/boot/dts/twl6030.dtsi               |    3 +++
 arch/arm/mach-dove/common.c                  |    3 ++-
 arch/arm/mach-kirkwood/Makefile.boot         |    3 ++-
 arch/arm/mach-kirkwood/common.c              |    4 ++--
 arch/arm/mach-mmp/sram.c                     |    2 +-
 arch/arm/mach-mv78xx0/addr-map.c             |    2 +-
 arch/arm/mach-mv78xx0/common.c               |    6 ++++--
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
 arch/arm/mach-orion5x/common.c               |    3 ++-
 arch/arm/plat-omap/dmtimer.c                 |    6 +++---
 arch/arm/plat-omap/include/plat/cpu.h        |    3 ++-
 arch/arm/plat-omap/include/plat/multi.h      |    9 +++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    4 +---
 arch/arm/plat-orion/common.c                 |    8 ++++++--
 arch/arm/plat-orion/include/plat/common.h    |    6 ++++--
 drivers/cpufreq/omap-cpufreq.c               |    4 +++-
 include/linux/mv643xx_eth.h                  |    2 ++
 28 files changed, 73 insertions(+), 53 deletions(-)
