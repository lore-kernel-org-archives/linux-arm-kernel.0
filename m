From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 27 Oct 2012 19:05:53 +0530
Subject: [PATCH v3 0/3] ocp2scp: add non-dt support
Message-ID: <1351344956-22868-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series allows ocp2scp driver to create its child devices
from the platform data.

In omap platforms, usb phy is connected to ocp2scp and usb phy is needed
for MUSB to be functional. When ocp2scp driver was added, it had only dt
support which means it wont create usb phy devices for non-dt boot.

This patch series adds non-dt support to ocp2scp and this series is needed
for getting MUSB functional in non-dt boot.

Changes from v2:
*if cpu is not 44xx, dont create ocp2scp device in mach-omap2/devices.c

Changes from v1:
* Fixed Sergei's comments on memory leaks

This patch series is rebased on linux-next. 
commit: 8243aafc4f54244984d7ea707265e98810a3a066
Let me know if it had to be based on some other tree/commit.

Kishon Vijay Abraham I (3):
  drivers: bus: ocp2scp: add pdata support
  ARM: OMAP4: add _dev_attr_ to ocp2scp for representing usb_phy
  ARM: OMAP: ocp2scp: create omap device for ocp2scp

 arch/arm/mach-omap2/devices.c              |   79 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   28 ++++++++++
 drivers/bus/omap-ocp2scp.c                 |   67 +++++++++++++++++++++--
 include/linux/platform_data/omap_ocp2scp.h |   31 +++++++++++
 4 files changed, 202 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/platform_data/omap_ocp2scp.h

-- 
1.7.9.5
