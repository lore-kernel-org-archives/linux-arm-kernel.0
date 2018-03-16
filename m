From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Mar 2018 08:37:35 -0700
Subject: [GIT PULL] two omap fixes for v4.16-rc cycle
Message-ID: <pull-1521214629-131951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit d39b6ea4f8c90e9e5f03a06b6a4fd4af11e2f617:

  bus: ti-sysc: Fix checking of no-reset-on-init quirk (2018-02-15 09:18:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/fixes-rc5-signed

for you to fetch changes up to 4e1e720009a78a7057a142de47def1e9f4bf41c7:

  ARM: OMAP: Fix SRAM W+X mapping (2018-03-08 10:28:46 -0800)

----------------------------------------------------------------
Two fixes for omap variants for v4.16-rc cycle

Fix insecure W+X mapping warning for SRAM for omaps that
don't yet use drivers/misc/*sram*.c code.

Also fix dmtimer probe for omap16xx devices that was noticed
with the pending dmtimer move to drivers. It seems this has
been broken for a while and is a non-critical for booting.
It is needed for PM on omap16xx though.

----------------------------------------------------------------
Tony Lindgren (3):
      ARM: OMAP: Fix dmtimer init for omap1
      Merge branch 'omap-for-v.16/dmtimer-fix' into omap-for-v4.16/fixes
      ARM: OMAP: Fix SRAM W+X mapping

 arch/arm/plat-omap/dmtimer.c |  7 ++-----
 arch/arm/plat-omap/sram.c    | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)
