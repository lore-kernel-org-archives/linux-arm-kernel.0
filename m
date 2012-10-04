From: jean.pihet@newoldbits.com (jean.pihet at newoldbits.com)
Date: Thu,  4 Oct 2012 18:47:09 +0200
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via
 platform data
Message-ID: <1349369231-25204-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean Pihet <j-pihet@ti.com>

Remove the device dependent code (ex. cpu_is_xxx()) and settings
from the driver code and instead pass them via the platform
data. This allows a clean separation of the driver code and the platform
code, as required by the move of the platform header files to
include/linux/platform_data.

Note about the smartreflex functional clocks: the smartreflex fclks
are derived from sys_clk and have the same name as the main_clk from
the hwmod entry, in order for the SmartReflex driver to request the
fclk (using clk_get(dev, "fck")).

Based on mainline 3.6.0. Boot tested on OMAP3&4 platforms.

Jean Pihet (2):
  ARM: OMAP: hwmod: align the SmartReflex fck names
  ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/clock33xx_data.c       |   12 +++----
 arch/arm/mach-omap2/clock3xxx_data.c       |   12 +++----
 arch/arm/mach-omap2/clock44xx_data.c       |    6 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++---
 arch/arm/mach-omap2/sr_device.c            |   13 +++++++
 drivers/power/avs/smartreflex.c            |   54 +++++++++-------------------
 include/linux/power/smartreflex.h          |   14 ++++++--
 7 files changed, 61 insertions(+), 58 deletions(-)

-- 
1.7.10.4
