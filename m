From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 09 Apr 2013 16:19:59 -0700
Subject: [GIT PULL] CPUidle: OMAP cleanups for v3.10
Message-ID: <871uaj1ecg.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

Please pull the following OMAP CPUidle changes for v3.10.

Due to dependencies on other CPUidle changes that are already in your
linux-next branch, this branch is based on the commit where you merged
your pm-cpuidle-next branch into linux-next.

Kevin

The following changes since commit f69e44b2059f2238ac558b4a115ebcdefe20b9be:

  Merge branch 'pm-cpuidle-next' into linux-next (2013-04-08 12:32:07 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/cleanup/cpuidle-v2

for you to fetch changes up to db4f3dab629109882170a7b1b8fb655a34c52846:

  ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support (2013-04-09 09:48:21 -0700)

----------------------------------------------------------------
OMAP CPUidle cleanups for v3.10

----------------------------------------------------------------
Daniel Lezcano (1):
      ARM: omap3: cpuidle: enable time keeping

Santosh Shilimkar (5):
      ARM: OMAP4: CPUidle: Avoid double idle driver registration
      ARM: OMAP: CPUidle: Unregister drivere on device registration failure
      ARM: OMAP4: CPUidle: Make C-state description field more precise
      ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
      ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support

 arch/arm/mach-omap2/common.h              |  5 ----
 arch/arm/mach-omap2/cpuidle34xx.c         | 11 +++++--
 arch/arm/mach-omap2/cpuidle44xx.c         | 48 +++++++++++++++++--------------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 14 ---------
 4 files changed, 35 insertions(+), 43 deletions(-)
