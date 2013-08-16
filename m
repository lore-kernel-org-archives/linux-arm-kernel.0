From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Aug 2013 00:30:05 -0700
Subject: [GIT PULL 1/2] usb phy nop rename for v3.12 merge window
Message-ID: <pull-1376638205-27268>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/usb-signed

for you to fetch changes up to 3fa4d7344be0afebd80382ffeea6b1787cccf971:

  usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv (2013-08-09 17:26:00 +0300)

----------------------------------------------------------------
USB nop phy rename via Felipe Balbi <balbi@ti.com>:

Here's a pull request of one patch to avoid conflicts during the merge
window.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      usb: phy: rename nop_usb_xceiv => usb_phy_gen_xceiv

 arch/arm/mach-omap2/board-omap3beagle.c            |  4 +-
 arch/arm/mach-omap2/board-omap3evm.c               |  4 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |  2 +-
 arch/arm/mach-omap2/usb-host.c                     | 10 ++---
 drivers/usb/dwc3/dwc3-exynos.c                     |  8 ++--
 drivers/usb/dwc3/dwc3-pci.c                        |  8 ++--
 drivers/usb/musb/am35x.c                           |  2 +-
 drivers/usb/musb/blackfin.c                        |  2 +-
 drivers/usb/musb/da8xx.c                           |  2 +-
 drivers/usb/musb/davinci.c                         |  2 +-
 drivers/usb/musb/musb_dsps.c                       |  2 +-
 drivers/usb/musb/tusb6010.c                        |  2 +-
 drivers/usb/phy/Makefile                           |  2 +-
 drivers/usb/phy/{phy-nop.c => phy-generic.c}       | 44 +++++++++++-----------
 .../usb/{nop-usb-xceiv.h => usb_phy_gen_xceiv.h}   |  4 +-
 15 files changed, 49 insertions(+), 49 deletions(-)
 rename drivers/usb/phy/{phy-nop.c => phy-generic.c} (83%)
 rename include/linux/usb/{nop-usb-xceiv.h => usb_phy_gen_xceiv.h} (81%)
