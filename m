From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Feb 2013 10:11:02 -0800
Subject: [GIT PULL 5/5] omap4 pm late changes for v3.9 merge window
In-Reply-To: <pull-1360692662-889112>
Message-ID: <mailman.36.1360692701.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/pm-omap4-signed

for you to fetch changes up to 93b23711b7132400d4d76f31c660d27a2bb0afdb:

  Merge tag 'omap-devel-d2-for-3.9' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.9/pm-omap4 (2013-02-11 09:40:45 -0800)

----------------------------------------------------------------

omap4 pm changes via Paul Walmsley <paul@pwsan.com>:

Some OMAP4 power management fixes and audio device integration
patches.  This pull request contains a fix for an issue discovered during
branch integration.

Basic test logs are available at:

    http://www.pwsan.com/omap/testlogs/omap4_prcm_devel_a_3.9/20130210112717/

----------------------------------------------------------------
Paul Walmsley (4):
      ARM: OMAP2+: hwmod: add enable_preprogram hook
      ASoC: TI AESS: add autogating-enable function, callable from architecture code
      ARM: OMAP4+: AESS: enable internal auto-gating during initial setup
      Merge branches 'sg_aess_reset_devel_3.9' and 'omap4_pm_fixes_a_3.9' into omap4_prcm_devel_a_3.9

Rajendra Nayak (1):
      ARM: OMAP4: PM: Warn users about usage of older bootloaders

Santosh Shilimkar (1):
      ARM: OMAP2+: PM: Fix the dt return condition in pm_late_init()

Sebastien Guiriec (2):
      ARM: OMAP4: hwmod data: Update AESS data with memory bank area
      ARM: OMAP4: hwmod data: Enable AESS hwmod device

Tony Lindgren (1):
      Merge tag 'omap-devel-d2-for-3.9' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.9/pm-omap4

 arch/arm/mach-omap2/Makefile               |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c           | 18 ++++++++++
 arch/arm/mach-omap2/omap_hwmod.h           |  8 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 51 +++++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_reset.c     | 52 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.c                   | 20 +++++------
 arch/arm/mach-omap2/pm44xx.c               | 21 ++++++++++--
 include/sound/aess.h                       | 53 ++++++++++++++++++++++++++++++
 8 files changed, 208 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_reset.c
 create mode 100644 include/sound/aess.h
