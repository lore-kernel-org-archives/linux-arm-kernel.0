From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Wed, 20 Jun 2012 17:14:48 +0800
Subject: [PATCH v3 0/5] ARM OMAP3530evm misc fixes
Message-ID: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series is based upon the latest linux-omap master branch from
Tony (3.5-rc2).

V3 Changes :

 1. [patch 5/5] Leave driver/input/touchscreen as-is. some changes
    on arch/arm/mach-omap2/common-board-devices.c, please see the
    shortlog for more information.
 2. For the first patch, I noticed GPMC driver conversion v5, so
    this is decided by Tony, we can drop it, and I'll create a new
    one if needed, but obviously I'm not very proper candidate for
    it.

 Thanks all comments :-)

Zumeng Chen (5):
      ARM: OMAP3EVM: Add NAND flash definition
      ARM: OMAP3EVM: Adding USB internal LDOs board file
      ARM: omap3evm: enable VBUS switch for EHCI tranceiver
      ARM: OMAP3EVM: cosmetic fixes for parent clk set
      ARM: OMAP3530evm: set pendown_state and debounce time for ads7846

 arch/arm/mach-omap2/board-omap3evm.c       |   74 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/common-board-devices.c |   18 ++++++-
 arch/arm/mach-omap2/common-board-devices.h |    1 +
 arch/arm/plat-omap/clock.c                 |    4 ++
 drivers/mfd/omap-usb-host.c                |    2 +-
 5 files changed, 95 insertions(+), 4 deletions(-)
