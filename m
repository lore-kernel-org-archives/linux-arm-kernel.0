From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 27 May 2011 10:38:26 +0300
Subject: [PATCHv2 0/2] Some omap_device/hwmod/pwrdomain patches
Message-ID: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I came up with these patches while implementing pm runtime adaptation for DSS
driver. I'm not quite sure on who's turf they belong, or do they even belong
together, but here they are anyway.

get_context_loss_count patch was discussed on l-o with Kevin.

The omap_device_reset patch I made as some parts of DSS currently presume that
the HW module is reset when it is enabled, and the reset is better handled in
hwmod code.

Changes in v2
* Dropped can-ever-lose-context patch
* Use INT_MAX instead of ~(1 << 31) when masking the ctx loss count

 Tomi

Tomi Valkeinen (2):
  OMAP: change get_context_loss_count ret value to int
  OMAP: add omap_device_reset()

 arch/arm/mach-omap2/omap_hwmod.c              |    2 +-
 arch/arm/mach-omap2/powerdomain.c             |   14 ++++++++++----
 arch/arm/mach-omap2/powerdomain.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |    4 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |    3 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +-
 arch/arm/plat-omap/omap-pm-noop.c             |   24 +++++++++++++++++-------
 arch/arm/plat-omap/omap_device.c              |   25 ++++++++++++++++++++++++-
 8 files changed, 58 insertions(+), 18 deletions(-)

-- 
1.7.4.1
