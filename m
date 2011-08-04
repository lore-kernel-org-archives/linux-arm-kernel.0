From: abhilash.kv@ti.com (Abhilash K V)
Date: Thu, 4 Aug 2011 21:29:07 +0530
Subject: [PATCH 0/2] AM3517: Booting up
Message-ID: <1312473547-1147-1-git-send-email-abhilash.kv@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set gets the kernel booting up on a AM3517 EVM.
The board is able to boot with ramdisk after this,but the MMC and Ethernet
drivers are not up yet. Lots of warnings remain which will be addressed in
subsequent patches.

The patches are tested on master of tmlind/linux-omap-2.6.git.
Kernel version is 3.0.0-rc7 and last commit on top of which these patches
were added is:

	885cf6ff7d3dad4cc44be74b0577d3a554d3ab71: Linux-omap rebuilt:
	Updated to -rc7, added new boards

Cc: Sanjeev Premi <premi@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---

Abhilash K V (1):
  AM35x: Using OMAP3 generic hwmods

Vaibhav Hiremath (1):
  omap_twl: Prevent SR to enable for am3517/am3505 devices

 arch/arm/mach-omap2/board-am3517evm.c        |   11 +++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   18 ++++++++++++++++++
 arch/arm/mach-omap2/omap_twl.c               |    8 ++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +++
 5 files changed, 42 insertions(+), 1 deletions(-)
