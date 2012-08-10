From: khilman@ti.com (Kevin Hilman)
Date: Fri, 10 Aug 2012 11:39:10 -0700
Subject: [PATCH v2 0/3] ARM: OMAP: omap_device: track driver bound status
Message-ID: <1344623953-26434-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the omap_device layer to keep track of driver bound status.

This will be used to track whether or not a driver is bound in order
to make intelligent omap_device enable/idle decisions (e.g. ensuring
omap_devices are idled when no driver is present, or driver probe
fails.)

Also, the omap_device layer implements PM domains for all
omap_devices, and knowing whether or not a driver is bound is needed
to know whether or not a drivers callbacks are valid, especially in
cases of failed driver probe.

Kevin Hilman (3):
  ARM: OMAP: omap_device: keep track of driver bound status
  ARM: OMAP: omap_device: don't attempt late suspend if no driver bound
  ARM: OMAP: omap_device: idle devices with no driver bound

 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/omap_device.c              |   56 ++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

-- 
1.7.9.2
