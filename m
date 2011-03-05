From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:40:18 +0800
Subject: [PATCH 0/4] Add framebuffer device for mx28evk and mx23evk boards
Message-ID: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to add framebuffer device for mx28evk and mx23evk
boards.  A couple notes here:

* The patch [PATCH 3/4] was cherry-picked from mxs-mmc-device patch
  set  (Sascha, it seems dma, mmc, flexcan platform patches are all
  waiting for your merging, please let me know if there are still
  something stopping your pick them up)

* The mxs-pwm driver is not merged yet, so the backlight is currently
  controlled in gpio mode, and will change to pwm mode when driver
  shows up on the tree.

 [PATCH 1/4] ARM: mxs: add helper macro for pad control
 [PATCH 2/4] ARM: mxs/mx28evk: add framebuffer device
 [PATCH 3/4] ARM: mxs: fix typo "GPO" in iomux-mx23.h
 [PATCH 4/4] ARM: mxs/mx23evk: add framebuffer device

 arch/arm/mach-mxs/Kconfig                   |    2 +
 arch/arm/mach-mxs/clock-mx28.c              |    2 +
 arch/arm/mach-mxs/include/mach/iomux-mx23.h |  190 +++++++++++++-------------
 arch/arm/mach-mxs/include/mach/iomux.h      |    3 +
 arch/arm/mach-mxs/mach-mx23evk.c            |   95 ++++++++++++--
 arch/arm/mach-mxs/mach-mx28evk.c            |  160 +++++++++++++++--------
 6 files changed, 293 insertions(+), 159 deletions(-)

Regards,
Shawn
