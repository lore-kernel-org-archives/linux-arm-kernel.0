From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Mar 2013 09:23:14 -0800
Subject: [GIT PULL] omap fixes for v3.9-rc1
Message-ID: <20130305172313.GB11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc1/fixes-signed

for you to fetch changes up to b0ad0995e92fdf6b25056da76c906c51bb06d6a5:

  ARM: OMAP: RX-51: add missing USB phy binding (2013-03-05 08:24:56 -0800)

----------------------------------------------------------------
Fix few regressions, omap3 pm init with device tree, and some
issues with the legacy mux code.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: RX-51: add missing USB phy binding

Felipe Balbi (1):
      ARM: OMAP2+: mux: fix debugfs file permission

Jon Hunter (1):
      ARM: OMAP2+: Fix broken gpmc support

Rajendra Nayak (1):
      ARM: OMAP3: board-generic: Add missing omap3_init_late

Ruslan Bilovol (1):
      ARM: OMAP2+: mux: correct wrong error messages

Santosh Shilimkar (1):
      ARM: OMAP2+: Remove duplicate omap4430_init_late() declaration

Tony Lindgren (2):
      ARM: OMAP1: Fix build related to kgdb.h no longer including serial_8250.h
      ARM: OMAP2+: Fix unmet direct dependencies for zoom for 8250 serial

 arch/arm/configs/omap2plus_defconfig | 2 ++
 arch/arm/mach-omap1/common.h         | 2 ++
 arch/arm/mach-omap2/Kconfig          | 6 ------
 arch/arm/mach-omap2/board-generic.c  | 2 ++
 arch/arm/mach-omap2/board-rx51.c     | 2 ++
 arch/arm/mach-omap2/common.h         | 1 -
 arch/arm/mach-omap2/gpmc.c           | 6 +++---
 arch/arm/mach-omap2/mux.c            | 9 +++++----
 drivers/video/omap/lcd_ams_delta.c   | 1 +
 drivers/video/omap/lcd_osk.c         | 3 +++
 10 files changed, 20 insertions(+), 14 deletions(-)
