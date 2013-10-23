From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Oct 2013 07:36:43 -0700
Subject: [GIT PULL 3/4] omap late cpufreq changes for v3.13 merge window
In-Reply-To: <pull-1382539003-174282>
Message-ID: <mailman.10.1382539048.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 06ff74fd197aa8205443cf64b94383802602e320:

  ARM: OMAP2+: remove legacy support for IGEP boards (2013-10-18 10:25:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/cpufreq-late

for you to fetch changes up to 60c5fc86d01154e2a005bf701f495426ebc81f73:

  ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot (2013-10-22 08:10:09 -0700)

----------------------------------------------------------------
Few patches to make cpufreq work for omap3 with device tree.

Note that this branch has a dependency to the patches merged
with omap-for-v3.13/board-removal-signed-take2.

----------------------------------------------------------------
Nishanth Menon (3):
      ARM: OMAP3+: do not register non-dt OPP tables for device tree boot
      ARM: OMAP2+: add missing lateinit hook for calling pm late init
      ARM: OMAP3+: use cpu0-cpufreq driver in device tree supported boot

 arch/arm/mach-omap2/board-generic.c |  4 ++++
 arch/arm/mach-omap2/common.h        |  4 ++++
 arch/arm/mach-omap2/io.c            | 20 ++++++++++++++++++++
 arch/arm/mach-omap2/opp.c           |  4 ++++
 arch/arm/mach-omap2/pm.c            | 12 +++++++++---
 5 files changed, 41 insertions(+), 3 deletions(-)
