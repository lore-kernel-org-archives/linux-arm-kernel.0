From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 24 Nov 2012 05:11:06 +0000
Subject: [GIT PULL 2/5] ARM: orion: cleanup for v3.8
In-Reply-To: <pull-1353733874-990435>
Message-ID: <mailman.8.1353733893.1035.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f4a75d2eb7b1e2206094b901be09adb31ba63681:

  Linux 3.7-rc6 (2012-11-16 17:42:40 -0800)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/orion_cleanup_for_3.8

for you to fetch changes up to 4a9329a04ceec56fc1ec155b6ea4d8b50f350a7b:

  ARM: Kirkwood: Use hw_pci.ops instead of hw_pci.scan (2012-11-21 20:09:11 +0000)

----------------------------------------------------------------
orion cleanup for v3.8

 - remove unused includes in kirkwood
 - fix sparse warnings in kirkwood
 - checkpatch cleanup in kirkwood
 - use common code in pcie on kirkwood

----------------------------------------------------------------
Andrew Lunn (3):
      ARM: Kirkwood: Remove unused includes
      ARM: Kirkwood: Fix sparse warnings.
      ARM: Kirkwood: checkpatch cleanups

Jason Gunthorpe (1):
      ARM: Kirkwood: Use hw_pci.ops instead of hw_pci.scan

Michael Walle (1):
      ARM: kirkwood: cleanup lsxl board includes

 arch/arm/mach-kirkwood/board-dockstar.c       | 13 -----------
 arch/arm/mach-kirkwood/board-dreamplug.c      | 15 -------------
 arch/arm/mach-kirkwood/board-dt.c             |  4 ++--
 arch/arm/mach-kirkwood/board-goflexnet.c      | 13 -----------
 arch/arm/mach-kirkwood/board-ib62x0.c         |  6 ------
 arch/arm/mach-kirkwood/board-iconnect.c       |  8 -------
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |  2 --
 arch/arm/mach-kirkwood/board-lsxl.c           |  8 -------
 arch/arm/mach-kirkwood/board-ts219.c          |  3 ---
 arch/arm/mach-kirkwood/common.c               | 11 +++++-----
 arch/arm/mach-kirkwood/common.h               |  3 ++-
 arch/arm/mach-kirkwood/cpuidle.c              |  2 +-
 arch/arm/mach-kirkwood/dockstar-setup.c       |  2 +-
 arch/arm/mach-kirkwood/irq.c                  |  1 +
 arch/arm/mach-kirkwood/lacie_v2-common.c      |  1 +
 arch/arm/mach-kirkwood/mpp.c                  |  4 ++--
 arch/arm/mach-kirkwood/netspace_v2-setup.c    |  4 ++--
 arch/arm/mach-kirkwood/openrd-setup.c         | 14 +++++-------
 arch/arm/mach-kirkwood/pcie.c                 | 31 +++++++--------------------
 arch/arm/mach-kirkwood/sheevaplug-setup.c     |  2 +-
 arch/arm/mach-kirkwood/t5325-setup.c          |  6 +++---
 arch/arm/mach-kirkwood/ts41x-setup.c          |  3 +--
 arch/arm/mach-kirkwood/tsx1x-common.c         |  7 +++---
 23 files changed, 39 insertions(+), 124 deletions(-)
