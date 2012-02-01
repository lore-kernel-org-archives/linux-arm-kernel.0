From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  1 Feb 2012 16:39:08 +0000
Subject: [PULL] Runtime registration for local timers
Message-ID: <1328114348-24279-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Could you please pull the below branch which contains the local timer
runtime registration rework? It contains Acks and Tested-bys from most
maintainers, except for the usual suspects (Samsung and shmobile).

Thanks,

	M.

The following changes since commit dcf81c1af839b77b44404453ecae6e5ac5a75f05:

  Merge branch 'amba' into for-armsoc (2012-01-26 19:59:44 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git local_timers-for-rmk

Marc Zyngier (15):
      ARM: smp_twd: make local_timer_stop a symbol instead of a #define
      ARM: local timers: introduce a new registration interface
      ARM: smp_twd: add runtime registration support
      ARM: smp_twd: add device tree support
      ARM: OMAP4: convert to twd_local_timer_register() interface
      ARM: plat-versatile: convert to twd_local_timer_register() interface
      ARM: tegra: convert to twd_local_timer_register() interface
      ARM: shmobile: convert to twd_local_timer_register() interface
      ARM: ux500: convert to twd_local_timer_register() interface
      ARM: highbank: convert to twd_local_timer_register() interface
      ARM: imx6q: convert to twd_local_timer_register() interface
      ARM: smp_twd: remove old local timer interface
      ARM: local timers: convert exynos to runtime registration interface
      ARM: local timers: convert MSM to runtime registration interface
      ARM: local timers: make the runtime registration interface mandatory

 Documentation/devicetree/bindings/arm/twd.txt |   48 ++++++++++
 arch/arm/boot/dts/highbank.dts                |    8 +-
 arch/arm/boot/dts/imx6q.dtsi                  |    6 +-
 arch/arm/include/asm/localtimer.h             |   37 ++------
 arch/arm/include/asm/smp_twd.h                |   25 ++++-
 arch/arm/kernel/smp.c                         |   22 ++++-
 arch/arm/kernel/smp_twd.c                     |  123 ++++++++++++++++++++-----
 arch/arm/mach-exynos/mct.c                    |   18 ++--
 arch/arm/mach-highbank/Makefile               |    1 -
 arch/arm/mach-highbank/highbank.c             |    3 +
 arch/arm/mach-highbank/localtimer.c           |   40 --------
 arch/arm/mach-imx/Makefile                    |    1 -
 arch/arm/mach-imx/localtimer.c                |   35 -------
 arch/arm/mach-imx/mach-imx6q.c                |    2 +
 arch/arm/mach-msm/timer.c                     |   79 +++++++++-------
 arch/arm/mach-omap2/Makefile                  |    1 -
 arch/arm/mach-omap2/timer-mpu.c               |   39 --------
 arch/arm/mach-omap2/timer.c                   |   22 ++++-
 arch/arm/mach-realview/realview_eb.c          |   27 ++++-
 arch/arm/mach-realview/realview_pb11mp.c      |   21 ++++-
 arch/arm/mach-realview/realview_pbx.c         |   20 +++-
 arch/arm/mach-shmobile/Makefile               |    1 -
 arch/arm/mach-shmobile/include/mach/common.h  |    2 +
 arch/arm/mach-shmobile/localtimer.c           |   26 -----
 arch/arm/mach-shmobile/platsmp.c              |    1 -
 arch/arm/mach-shmobile/smp-r8a7779.c          |    8 +-
 arch/arm/mach-shmobile/smp-sh73a0.c           |    8 +-
 arch/arm/mach-shmobile/timer.c                |   10 ++
 arch/arm/mach-tegra/Makefile                  |    2 +-
 arch/arm/mach-tegra/localtimer.c              |   26 -----
 arch/arm/mach-tegra/timer.c                   |   22 ++++-
 arch/arm/mach-ux500/Makefile                  |    1 -
 arch/arm/mach-ux500/cpu.c                     |    1 -
 arch/arm/mach-ux500/localtimer.c              |   29 ------
 arch/arm/mach-ux500/timer.c                   |   32 +++++--
 arch/arm/mach-vexpress/ct-ca9x4.c             |   17 +++-
 arch/arm/plat-versatile/Makefile              |    1 -
 arch/arm/plat-versatile/localtimer.c          |   27 ------
 38 files changed, 407 insertions(+), 385 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/twd.txt
 delete mode 100644 arch/arm/mach-highbank/localtimer.c
 delete mode 100644 arch/arm/mach-imx/localtimer.c
 delete mode 100644 arch/arm/mach-omap2/timer-mpu.c
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c
 delete mode 100644 arch/arm/mach-tegra/localtimer.c
 delete mode 100644 arch/arm/mach-ux500/localtimer.c
 delete mode 100644 arch/arm/plat-versatile/localtimer.c
