From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Jul 2012 19:34:35 +0000
Subject: [GIT PULL] arm-soc fixes for 3.5-rc6
Message-ID: <201207111934.35953.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Another set of fixes, this time with a proper URL. For some reason the last
time I sent the pull request it would use the "fixes" branch when I gave
it the regular git URL and the signed tag when I gave it the ra.kernel.org
URL, and I forgot that this would not be a world-readable URL. This time
it worked either way, so here is the normal one.
The branch is based on top of the previous changeset that you already
pulled, not based on an -rc this time.

	Arnd

The following changes since commit e15ebe05cce44c5164dbf8489841c18a887bcfc2:

  Merge tag 'omap-fixes-for-v3.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2012-07-05 12:16:13 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 9861e9551f443bb2e8dacd4b9572cb8dab0f3ad7:

  Merge tag 'omap-fixes-for-v3.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2012-07-10 16:12:39 +0200)

----------------------------------------------------------------

ARM: SoC fixes for 3.5-rc

* multiple omap2+ bug fixes
* a regression on ux500 dt support
* a build failure on shmobile

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge branch 'ux500/fixes-3.5' into fixes
      Merge tag 'omap-fixes-for-v3.5-rc6' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Kevin Hilman (1):
      ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not stable, disable it

Lee Jones (3):
      of: address: Don't fail a lookup just because a node has no reg property
      ARM: ux500: Fix build errors/warnings when MACH_UX500_DT is not set
      ARM: ux500: Over-ride the DT device naming scheme for pinctrl

Magnus Damm (1):
      ARM: shmobile: fix platsmp.c build when ARCH_SH73A0=n

Paul Walmsley (1):
      ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer

Tony Lindgren (1):
      Merge branch 'for_3.5/fixes/pm-3' of git://git.kernel.org/.../khilman/linux-omap-pm into fixes

 arch/arm/configs/omap2plus_defconfig             |    1 -
 arch/arm/mach-omap2/clockdomain.h                |    4 +++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    1 +
 arch/arm/mach-omap2/clockdomains44xx_data.c      |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c                 |   32 ++++++++++++++++------
 arch/arm/mach-shmobile/platsmp.c                 |    5 ++++
 arch/arm/mach-ux500/board-mop500.c               |   12 ++++----
 arch/arm/mach-ux500/timer.c                      |    2 ++
 drivers/of/platform.c                            |    7 ++---
 9 files changed, 47 insertions(+), 19 deletions(-)
