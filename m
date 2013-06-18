From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 11:07:24 -0700
Subject: [GIT PULL 1/7] omap soc fixes for v3.11 merge window
Message-ID: <pull-1371578847-800598>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4f288f081bb67813d35c10d1b2fa68e863c4b188:

  ARM: OMAP2+: AM43x: SRAM base and size (2013-06-12 08:07:23 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/soc-part2-signed

for you to fetch changes up to 7bcad170154f1302aeeced4f236588091a261fbf:

  ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature (2013-06-18 03:04:07 -0700)

----------------------------------------------------------------
Fix am43x minimal booting as I accidentally left out one
patch from the already merged omap-for-v3.11/soc-signed branch.
Also fixes for ti81x booting and  revision check updates.

These are based on omap-for-v3.11/soc-signed because of the
am43x dependency to earlier patches.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: OMAP2+: AM43x: basic dt support

Aida Mynzhasova (2):
      ARM: OMAP2: TI81XX: id: Add cpu id for TI816x ES2.0 and ES2.1
      ARM: OMAP: TI816X: add powerdomains for TI816x

Vaibhav Hiremath (1):
      ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature

 arch/arm/mach-omap2/board-generic.c         | 16 ++++++++
 arch/arm/mach-omap2/control.h               |  4 ++
 arch/arm/mach-omap2/id.c                    | 24 ++++++++++-
 arch/arm/mach-omap2/io.c                    |  2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c | 62 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h           | 11 +++++
 arch/arm/mach-omap2/soc.h                   |  3 ++
 arch/arm/mach-omap2/timer.c                 |  2 +-
 8 files changed, 120 insertions(+), 4 deletions(-)
