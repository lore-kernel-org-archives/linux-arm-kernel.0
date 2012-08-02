From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Aug 2012 10:45:48 -0700
Subject: [GIT PULL 2/3] ARM: arm-soc: cpuidle enablement for OMAP
Message-ID: <CAOesGMjpnTU=1PBT2PNJOVjNbFhGrwFB0ZskUqRs0TGdHbJ41A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coupled cpuidle was meant to merge for 3.5 through Len Brown's tree, but
didn't go in because the pull request ended up rejected. So it just got
merged, and we got this staged branch that enables the coupled cpuidle
code on OMAP.

With a stable git workflow from the other maintainer we could have staged
this earlier, but that wasn't the case so we have had to merge it late.

The alternative is to hold it off until 3.7 but given that the code is
well-isolated to OMAP and they are eager to see it go in, I didn't push
back hard in that direction.

----------------------------------------------------------------

The following changes since commit 516b7ab0b42b6dfe765f04a397e499d519e93825:

  Merge branch 'fixes' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/pm2

for you to fetch changes up to 5c62202968d4aaf3bd50e19c421d66aec2e508e0:

  Merge branch 'for_3.6/pm/coupled-cpuidle' of
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm
into late2/pm

----------------------------------------------------------------

Kevin Hilman (1):
      ARM: OMAP4: CPUidle: add synchronization for coupled idle states

Olof Johansson (1):
      Merge branch 'for_3.6/pm/coupled-cpuidle' of
git://git.kernel.org/.../khilman/linux-omap-pm into late2/pm

Santosh Shilimkar (3):
      ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
      ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
      ARM: OMAP4: CPUidle: Open broadcast clock-event device.


 arch/arm/mach-omap2/Kconfig       |   1 +
 arch/arm/mach-omap2/cpuidle44xx.c | 145 ++++++++++++++++++++++-----------
 arch/arm/mach-omap2/timer.c       |   4 +-
 3 files changed, 103 insertions(+), 47 deletions(-)
