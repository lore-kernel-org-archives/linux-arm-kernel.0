From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 17 Jul 2015 10:40:54 +0530
Subject: [PULL] ARM: clockevents: Migrate to 'set-state' callbacks
Message-ID: <cover.1437101996.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

This series migrates ARM clockevent drivers (present in arch/arm/
directory), to the new set-state interface. This would enable these
drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
device (if required), as the set-mode interface is marked obsolete now
and wouldn't be expanded to handle new states.

--
viresh

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git ARM/clkevt/set-state-4.3

for you to fetch changes up to 10dca88a4be632678088f5cbc20b54c2113ecb91:

  ARM/orion/time: Migrate to new 'set-state' interface (2015-07-17 08:29:44 +0530)

----------------------------------------------------------------
Viresh Kumar (18):
      ARM/smp_twd: Migrate to new 'set-state' interface
      ARM/cns3xxx/timer: Migrate to new 'set-state' interface
      ARM/davinci/time: Migrate to new 'set-state' interface
      ARM/dc21285-timer: Migrate to new 'set-state' interface
      ARM/gemini/time: Migrate to new 'set-state' interface
      ARM/imx/epit: Migrate to new 'set-state' interface
      ARM/ixp4xx/timer: Migrate to new 'set-state' interface
      ARM/ks8695/time: Migrate to new 'set-state' interface
      ARM/lpc32xx/timer: Migrate to new 'set-state' interface
      ARM/mmp/time: Migrate to new 'set-state' interface
      ARM/netx/time: Migrate to new 'set-state' interface
      ARM/omap1/time: Migrate to new 'set-state' interface
      ARM/omap1/timer32: Migrate to new 'set-state' interface
      ARM/omap2/timer: Migrate to new 'set-state' interface
      ARM/SPEAr/time: Migrate to new 'set-state' interface
      ARM/w90x900/time: Migrate to new 'set-state' interface
      ARM/iop/time: Migrate to new 'set-state' interface
      ARM/orion/time: Migrate to new 'set-state' interface

 arch/arm/kernel/smp_twd.c                | 48 +++++++++--------
 arch/arm/mach-cns3xxx/core.c             | 55 ++++++++++---------
 arch/arm/mach-davinci/time.c             | 54 ++++++++++---------
 arch/arm/mach-footbridge/dc21285-timer.c | 48 ++++++++---------
 arch/arm/mach-gemini/time.c              | 69 ++++++++++++------------
 arch/arm/mach-imx/epit.c                 | 67 ++++++++++++-----------
 arch/arm/mach-ixp4xx/common.c            | 68 +++++++++++++----------
 arch/arm/mach-ks8695/time.c              | 43 ++++++++-------
 arch/arm/mach-lpc32xx/timer.c            | 40 +++++---------
 arch/arm/mach-mmp/time.c                 | 29 ++++------
 arch/arm/mach-netx/time.c                | 61 +++++++++++----------
 arch/arm/mach-omap1/time.c               | 35 ++++++------
 arch/arm/mach-omap1/timer32k.c           | 33 ++++++------
 arch/arm/mach-omap2/timer.c              | 48 ++++++++---------
 arch/arm/mach-spear/time.c               | 89 ++++++++++++++++--------------
 arch/arm/mach-w90x900/time.c             | 51 ++++++++++--------
 arch/arm/plat-iop/time.c                 | 70 ++++++++++++++----------
 arch/arm/plat-orion/time.c               | 93 ++++++++++++++++----------------
 18 files changed, 522 insertions(+), 479 deletions(-)

-- 
2.4.0
