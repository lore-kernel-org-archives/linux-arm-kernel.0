From: khilman@ti.com (Kevin Hilman)
Date: Thu, 05 Jul 2012 17:30:41 -0700
Subject: [GIT PULL] OMAP: PM: one more fix for 3.5-rc
Message-ID: <877guhenny.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Hopefully this is the last one.

This one fixes a problem where the CORE power domain does not hit
retention during suspend.  This has been known since v3.5 came out, but
there has been some discussion about the proper fix.  The solution has
now been agreed upon, so I'd like to see this make it for v3.5-rc.

Thanks,

Kevin



The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:

  Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/pm-3

for you to fetch changes up to 006c7f18449a06027b0165e938c67b3a029813c9:

  ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer (2012-07-05 17:25:38 -0700)

----------------------------------------------------------------
Paul Walmsley (1):
      ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer

 arch/arm/mach-omap2/clockdomain.h                |    4 +++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    1 +
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |   32 ++++++++++++++++------
 4 files changed, 30 insertions(+), 9 deletions(-)
