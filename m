From: zumeng.chen@gmail.com (Zumeng Chen)
Date: Wed, 13 Jun 2012 09:44:05 +0800
Subject: [PATCH v2 0/5] ARM OMAP3530evm misc fixes for linux-omap
In-Reply-To: <zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
Message-ID: <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix misc problems when reflash ti-omap3530evm for
master branch on Linux-omap.

The series is based upon the latest linux-omap master branch from
Tony (3.5-rc1).

Changes vs V1:

 1. NAND flash definition changes as Jon's comments.
 2. Add more shortlog for VBUS switch from a kind people.
 3. Jon's cosmetic fix seems more fit.
 4. Debounce time I still leave a ugly hardcode in driver level
    with bracketing by ARCH_OMAP3. Anyway, Igor's comments are
    more sense.

 If you guy don't like patch 4 or 5, feel free to drop them :-)
 I'm OK for that, thanks all of your kind RR from Jon, Igor, and
 Tony.

 Zumeng Chen (5):
      ARM: OMAP3EVM: Add NAND flash definition
      ARM: OMAP3EVM: Adding USB internal LDOs board file
      ARM: omap3evm: enable VBUS switch for EHCI tranceiver
      ARM: OMAP3EVM: cosmetic fixes for parent clk set
      Input: ads7846: set proper debounce time in driver level

 arch/arm/mach-omap2/board-omap3evm.c |   75 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/clock.c           |    4 ++
 drivers/input/touchscreen/ads7846.c  |    4 ++
 drivers/mfd/omap-usb-host.c          |    2 +-
 4 files changed, 84 insertions(+), 1 deletions(-)
 
