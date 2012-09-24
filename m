From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 24 Sep 2012 16:16:39 +0200
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via
 platform data
In-Reply-To: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
References: <1348152453-30532-1-git-send-email-j-pihet@ti.com>
Message-ID: <1348496201-6378-1-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the device dependent settings (cpu_is_xxx(), IP fck etc.)
from the driver code and pass them instead via the platform
data.
This allows a clean separation of the driver code and the platform
code, as required by the move of the platform header files to
include/linux/platform_data.

The patch also includes a fix of the error handling path in omap_sr_probe
to correctly de-allocate resources in case of problems. $SUBJECT requires
this change.

Jean Pihet (2):
  ARM: OMAP: SmartReflex: fix error path in init function
  ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/sr_device.c   |   13 ++++++++++
 drivers/power/avs/smartreflex.c   |   48 +++++++++++-------------------------
 include/linux/power/smartreflex.h |   14 +++++++++-
 3 files changed, 40 insertions(+), 35 deletions(-)

-- 
1.7.7.6
