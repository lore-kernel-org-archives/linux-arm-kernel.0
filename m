From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 27 Sep 2012 19:34:06 +0530
Subject: [PATCH v2 0/2] usb: phy: add usb3 phy driver
Message-ID: <1348754648-8315-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a driver for usb3 phy that handles the interaction between usb phy
device and dwc3 controller. Currently writing to control module register
is taken care in this driver which will be removed once the control
module driver is in place.

Changes from v1:
* Added missing clk_put()
* Remove the patches usb: dwc3: Fix gadget pullup in SS mode and
usb: phy: omap-usb3: Decrease the number of transitions to recovery. Those
are actually WA for hw issues which will be fixed in ES2.
* Removed the *has960mhzclk* property

This patch series was rebased on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
However the dependent modules are not yet upstreamed and hence only compile
tested in this tree

Kishon Vijay Abraham I (2):
  usb: phy: add a new driver for usb3 phy
  usb: phy: omap-usb2: enable 960Mhz clock for omap5

 Documentation/devicetree/bindings/usb/usb-phy.txt |   18 +
 drivers/usb/phy/Kconfig                           |    9 +
 drivers/usb/phy/Makefile                          |    1 +
 drivers/usb/phy/omap-usb2.c                       |   18 +-
 drivers/usb/phy/omap-usb3.c                       |  412 +++++++++++++++++++++
 include/linux/usb/omap_usb.h                      |   33 ++
 6 files changed, 489 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/phy/omap-usb3.c

-- 
1.7.9.5
