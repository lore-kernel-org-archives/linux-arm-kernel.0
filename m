From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jul 2011 09:29:11 -0700
Subject: [GIT PULL] omap board updates for v3.1 merge window
Message-ID: <20110707162911.GL5783@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull omap board updates from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board

These are currently on top of the fixes you pulled earlier but
could be also rebased on the earlier cleanup if you prefer that.

Please note that the board-cm-t35.c change will need a minor fix
when merging with the atag_offset patch series. In MACHINE_START
the .boot_params needs to be replaced with .atag_offset = 0x100.

Also note that this series is missing the Nook Color board
support as that one is waiting on the machine_id patch.

Regards,

Tony


The following changes since commit fdcc205fb9ba006bcd37f72e1b1b904704257351:
  Tony Lindgren (1):
        Merge branch 'iommu-for-tony' of git://github.com/ohadbc/omap-iommu into devel-fixes

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git devel-board

Ameya Palande (1):
      omap: rx51: Platform support for lp5523 led chip

Igor Grinberg (1):
      arm: omap3: cm-t35: add support for cm-t3730

Joel A Fernandes (1):
      OMAP3: beagle: add support for beagleboard xM revision C

Kalle Jokiniemi (1):
      OMAP3: rx-51: Add full regulator definitions

Shubhrajyoti Datta (1):
      OMAP4: Keyboard: Mux changes in the board file

Silesh C V (1):
      omap: 4430SDP: Register the card detect GPIO properly

Vishal Mahaveer (1):
      omap: blaze: add mmc5/wl1283 device support

 arch/arm/mach-omap2/Kconfig                    |    6 +-
 arch/arm/mach-omap2/board-4430sdp.c            |  149 +++++++++++++++++++++++-
 arch/arm/mach-omap2/board-cm-t35.c             |   77 ++++++++++---
 arch/arm/mach-omap2/board-omap3beagle.c        |   78 ++++++++-----
 arch/arm/mach-omap2/board-rx51-peripherals.c   |  135 +++++++++++++++++++++
 arch/arm/mach-omap2/devices.c                  |    3 +-
 arch/arm/plat-omap/include/plat/omap4-keypad.h |    3 +-
 arch/arm/plat-omap/include/plat/uncompress.h   |    1 +
 8 files changed, 405 insertions(+), 47 deletions(-)
