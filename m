From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 30 Mar 2012 18:57:25 +0530
Subject: [PATCH 0/3] OMAP4: CPUidle: Add coupled idle support
Message-ID: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds the coupled cpuidle support for OMAP4 based on the v2
series posted [1]. This makes OMAP4 to support SMP cpuidle and also
removes the hard dependency of off-lining CPU1 to trigger deeper
C-states.

I have put together a branch which is based on 3.3 kernel with
Len Browns next branch [2] which has time keeping and other cpuidle
patches which will mostly get merged by 3.4-rc1 and rebased coupled
idle series from [1].

git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
for_3.5/omap4_coupled_cpuidle-rebase

Special thanks to Kevin Hilman and Colin Cross on their help on this
series.

Kevin Hilman (1):
  ARM: OMAP4: CPUidle: add synchronization for coupled idle states

Santosh Shilimkar (2):
  ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
  ARM: OMAP4: cpuidle: Use coupled cpuidle states to implement SMP
    cpuidle.

 arch/arm/mach-omap2/Kconfig       |    1 +
 arch/arm/mach-omap2/cpuidle44xx.c |  187 ++++++++++++++++++++++++-------------
 arch/arm/mach-omap2/timer.c       |    4 +-
 3 files changed, 124 insertions(+), 68 deletions(-)


Regards
Santosh
[1] http://lwn.net/Articles/486484/

[2] Power Management
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
