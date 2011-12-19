From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 11:51:08 -0800
Subject: [GIT PULL] omap ehci related changes for v3.3 merge window
Message-ID: <20111219195107.GR6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please pull omap echi changes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ehci

These are needed for runtime PM support for the usb *hci controllers
on omap. These depend on the fixes-non-critical-part2 + hwmod branches
posted earlier.

Regards,

Tony


The following changes since commit 986b0c256b3b7920502969641a1cb6d2c525b750:
  Tony Lindgren (1):
        Merge branch 'hwmod_data_devel_3.3' of git://git.pwsan.com/linux-2.6 into hwmod

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ehci

Keshava Munegowda (4):
      ARM: OMAP: USB: register hwmods of usbhs
      ARM: OMAP: USB: device name change for the clk names of usbhs
      ARM: OMAP: USBHOST: Replace usbhs core driver APIs by Runtime pm APIs
      MFD: OMAP: USB: Runtime PM support

Tony Lindgren (1):
      Merge branch 'usbhost_runtime_pm_14_devel_3.3' of git://git.pwsan.com/linux-2.6 into ehci

 arch/arm/mach-omap2/clock3xxx_data.c  |   26 +-
 arch/arm/mach-omap2/clock44xx_data.c  |   10 +-
 arch/arm/mach-omap2/usb-host.c        |  100 ++---
 arch/arm/plat-omap/include/plat/usb.h |    3 -
 drivers/mfd/omap-usb-host.c           |  755 +++++++++++++--------------------
 drivers/usb/host/ehci-omap.c          |   17 +-
 drivers/usb/host/ohci-omap3.c         |   18 +-
 7 files changed, 369 insertions(+), 560 deletions(-)
