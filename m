From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 14 Oct 2011 09:47:47 +0200
Subject: [GIT PULL] i.MX features
Message-ID: <20111014074747.GD13898@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following feature branch for i.MX.

Only trivial merge conflicts to your for-next branch, you won't need
a merge hint for this, I created a branch for you anyway just to
see if that's what you want for the next non trivial merge conflicts:

git://git.pengutronix.de/git/imx/linux-2.6.git hint

Sascha


The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-features-for-arnd

Richard Zhu (4):
      AHCI Add the AHCI SATA feature on the MX53 platforms
      MX53 Enable the AHCI SATA on MX53 ARD board
      MX53 Enable the AHCI SATA on MX53 LOCO board
      MX53 Enable the AHCI SATA on MX53 SMD board

Sascha Hauer (2):
      Merge branch 'features/ahci' into for-arnd-features
      Merge branch 'features/denx-mx28' into for-arnd-features

Stefano Babic (1):
      ARM: mxs: Add initial support for DENX MX28

 arch/arm/configs/mxs_defconfig                  |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c              |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c             |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c              |   16 +
 arch/arm/mach-mx5/clock-mx51-mx53.c             |   19 ++
 arch/arm/mach-mx5/devices-imx53.h               |    2 +
 arch/arm/mach-mxs/Kconfig                       |   17 +
 arch/arm/mach-mxs/Makefile                      |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |   16 +-
 arch/arm/mach-mxs/include/mach/mxs.h            |    1 +
 arch/arm/mach-mxs/include/mach/uncompress.h     |    1 +
 arch/arm/mach-mxs/mach-m28evk.c                 |  366 +++++++++++++++++++++++
 arch/arm/plat-mxc/devices/Kconfig               |    4 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-ahci-imx.c   |  156 ++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   10 +
 16 files changed, 608 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mach-m28evk.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-ahci-imx.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
