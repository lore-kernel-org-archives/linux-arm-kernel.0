From: khilman@ti.com (Kevin Hilman)
Date: Tue,  8 May 2012 10:19:00 -0700
Subject: [PATCH 0/2] ARM: OMAP/TWL: remove unused pdata IRQ fields 
Message-ID: <1336497542-13629-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TWL driver has been converted to SPARSE_IRQ, and no longer needs
these fields.  Remove them.

Samuel, with your ack, we can keep the twl.h change with the OMAP
change that removes all the users so they merge together and avoid
potential build problems if they merge separately.

Kevin


Kevin Hilman (2):
  ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
  mfd: twl: remove pdata->irq_base/_end, no more users

 arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
 arch/arm/mach-omap2/board-omap3logic.c |    3 ---
 arch/arm/mach-omap2/twl-common.c       |   10 ----------
 include/linux/i2c/twl.h                |    1 -
 4 files changed, 17 deletions(-)

-- 
1.7.9.2
