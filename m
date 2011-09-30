From: khilman@ti.com (Kevin Hilman)
Date: Fri, 30 Sep 2011 13:55:00 -0700
Subject: [GIT PULL] OMAP: more omap_device preparations for DT
Message-ID: <87y5x5hhsr.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Please pull the following omap_device series that finishes up the
preparation the rest of the device tree work from Benoit.

Kevin


The following changes since commit 0f9b8dd0120cca55b73620c2a6e0dd8c1575f677:

  Merge branches 'cleanup', 'voltage' and 'dmtimer' into dt-base (2011-09-30 11:13:29 -0700)

are available in the git repository at:

  git://github.com/khilman/linux-omap-pm.git for_3.2/omap_device-2

Benoit Cousson (8):
      ARM: OMAP3: beagle-board: Use the omap_hwmod_name_get_dev API
      ARM: OMAP2+: pm: Use hwmod name instead of dev pointer
      ARM: OMAP2+: pm: Remove static devices variable for mpu, dsp, iva and l3 PM
      ARM: OMAP: omap_device: Create a default omap_device_pm_latency
      ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
      of: Add helpers to get one string in multiple strings property
      ARM: OMAP: omap_device: Add omap_device_[alloc|delete] for DT integration
      ARM: OMAP: omap_device: Add a method to build an omap_device from a DT node

Nishanth Menon (1):
      ARM: OMAP: omap_device: Add omap_device_get_by_hwmod_name

 .../devicetree/bindings/arm/omap/omap.txt          |   43 +++
 arch/arm/mach-omap2/board-omap3beagle.c            |    4 +-
 arch/arm/mach-omap2/devices.c                      |   46 +---
 arch/arm/mach-omap2/display.c                      |   11 +-
 arch/arm/mach-omap2/dma.c                          |   11 +-
 arch/arm/mach-omap2/gpio.c                         |   12 +-
 arch/arm/mach-omap2/hsmmc.c                        |   18 +-
 arch/arm/mach-omap2/hwspinlock.c                   |   12 +-
 arch/arm/mach-omap2/mcbsp.c                        |   11 +-
 arch/arm/mach-omap2/pm.c                           |   69 ++---
 arch/arm/mach-omap2/serial.c                       |   25 +--
 arch/arm/mach-omap2/sr_device.c                    |   11 +-
 arch/arm/mach-omap2/usb-musb.c                     |   11 +-
 arch/arm/plat-omap/i2c.c                           |   10 +-
 arch/arm/plat-omap/include/plat/omap_device.h      |    1 +
 arch/arm/plat-omap/omap_device.c                   |  313 +++++++++++++++++---
 drivers/of/base.c                                  |   84 ++++++
 include/linux/of.h                                 |   18 ++
 18 files changed, 448 insertions(+), 262 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/omap.txt
