From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Mar 2018 09:42:24 -0700
Subject: [GIT PULL] v2 of two omap fixes for v4.16-rc cycle
Message-ID: <pull-1521736922-590596@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/sram-fix-signed

for you to fetch changes up to eb85a355c3afd9379f5953cfe2df73632d14c884:

  ARM: OMAP: Fix SRAM W+X mapping (2018-03-21 08:16:29 -0700)

----------------------------------------------------------------
Two fixes for omap variants for v4.16-rc cycle

Fix insecure W+X mapping warning for SRAM for omaps that
don't yet use drivers/misc/*sram*.c code. An earlier attempt
at fixing this turned out to cause problems with PM on omap3,
this version works with PM on omap3.

Also fix dmtimer probe for omap16xx devices that was noticed
with the pending dmtimer move to drivers. It seems this has
been broken for a while and is a non-critical for booting.
It is needed for PM on omap16xx though.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP: Fix dmtimer init for omap1
      ARM: OMAP: Fix SRAM W+X mapping

 arch/arm/plat-omap/dmtimer.c           |  7 ++-----
 arch/arm/plat-omap/include/plat/sram.h | 11 +----------
 arch/arm/plat-omap/sram.c              | 36 +++++++++++++++++++++++++++++++++-
 3 files changed, 38 insertions(+), 16 deletions(-)
