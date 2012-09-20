From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 20 Sep 2012 16:47:31 +0200
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via
 platform data
Message-ID: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
from the driver code and pass them instead via the platform
data.
This allows a clean separation of the driver code and the platform
code, as required by the recent re-org of the platform data header
files.

The patch also includes a fix of the error handling path in omap_sr_probe
to correctly de-allocate resources in case of problems. $SUBJECT requires
this change.

Jean Pihet (2):
  ARM: OMAP: SmartReflex: fix error path in init function
  ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/sr_device.c   |   14 +++++++++
 drivers/power/avs/smartreflex.c   |   57 +++++++++++++++---------------------
 include/linux/power/smartreflex.h |   17 ++++++++++-
 3 files changed, 53 insertions(+), 35 deletions(-)

-- 
1.7.7.6
