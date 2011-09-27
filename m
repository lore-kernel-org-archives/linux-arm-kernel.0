From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 27 Sep 2011 19:18:00 +0200
Subject: [PATCH v3 0/6] OMAP: omap_device cleanup before device-tree
	integration
Message-ID: <1317143886-13285-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Here are a couple of cleanups on top of your for_3.2/omap_device branch.

patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/1_omap_device_cleanup

Regards,
Benoit


Changes since v1: http://www.spinics.net/lists/linux-omap/msg55801.html
 - Update the 2 patches from Nishanth based on Kevin's comment and merge
   them into one patch.
 - Fix the omap_device_pm_latency issue reported by Paul.

Changes since v2: http://www.spinics.net/lists/arm-kernel/msg138993.html
 - Change the API name from omap_hwmod_name_get_dev to 
   omap_device_get_by_hwmod_name per Kevin's suggestion.
 

Benoit Cousson (5):
  OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
  OMAP2+: pm: Use hwmod name instead of dev pointer
  OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
  OMAP: omap_device: Create a default omap_device_pm_latency
  OMAP2+: devices: Remove all omap_device_pm_latency structures

Nishanth Menon (1):
  OMAP: omap_device: Add omap_device_get_by_hwmod_name

 arch/arm/mach-omap2/board-omap3beagle.c       |    4 +-
 arch/arm/mach-omap2/devices.c                 |   46 ++---------------
 arch/arm/mach-omap2/display.c                 |   11 +----
 arch/arm/mach-omap2/dma.c                     |   11 +----
 arch/arm/mach-omap2/gpio.c                    |   12 +----
 arch/arm/mach-omap2/hsmmc.c                   |   18 +------
 arch/arm/mach-omap2/hwspinlock.c              |   12 +----
 arch/arm/mach-omap2/mcbsp.c                   |   11 +----
 arch/arm/mach-omap2/pm.c                      |   69 ++++++++-----------------
 arch/arm/mach-omap2/serial.c                  |   25 +---------
 arch/arm/mach-omap2/sr_device.c               |   11 +----
 arch/arm/mach-omap2/usb-musb.c                |   11 +----
 arch/arm/plat-omap/i2c.c                      |   10 +---
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   55 +++++++++++++++++++-
 15 files changed, 93 insertions(+), 214 deletions(-)
