From: khilman@ti.com (Kevin Hilman)
Date: Fri, 10 Aug 2012 10:44:42 -0700
Subject: [GIT PULL] ARM: OMAP: PM fixes for v3.6-rc
Message-ID: <878vdmfxpx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following PM related fixes for v3.6-rc.

One of them is a fix for drivers/cpufreq/omap-cpufreq.c, but it needs to
go along with the arch/arm change.  I'm listed in MAINTAINERS for the
OMAP CPUfreq driver now, so this should be OK.

Kevin

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/fixes/pm

for you to fetch changes up to 196449de0c886e64b48d01bd7ee153656db92884:

  ARM: OMAP4: Register the OPP table only for 4430 device (2012-08-09 08:07:54 -0700)

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP3: TWL4030: ensure sys_nirq1 is mux'd and wakeup enabled
      Revert "ARM: OMAP3: PM: call pre/post transition per powerdomain"

Rajendra Nayak (2):
      cpufreq: OMAP: Handle missing frequency table on SMP systems
      ARM: OMAP4: Register the OPP table only for 4430 device

Santosh Shilimkar (1):
      ARM: OMAP4: sleep: Save the complete used register stack frame

 arch/arm/mach-omap2/opp4xxx_data.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c       |   19 ++++---------------
 arch/arm/mach-omap2/sleep44xx.S    |    8 ++++++--
 arch/arm/mach-omap2/twl-common.c   |    1 +
 drivers/cpufreq/omap-cpufreq.c     |    4 +++-
 5 files changed, 15 insertions(+), 19 deletions(-)
