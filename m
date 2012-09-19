From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 19 Sep 2012 17:00:25 +0530
Subject: [PATCH 0/4] usb: phy: add usb3 phy driver
Message-ID: <1348054229-27362-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added a driver for usb3 phy that handles the interaction between usb phy
device and dwc3 controller. Currently writing to control module register
is taken care in this driver which will be removed once the control
module driver is in place.

Also included the patch from Moiz to fix gadget pullup in SS mode.

This patch series has been lying in my local tree for some time and it's
been tested in my tree.
git://gitorious.org/linux-usb/linux-usb.git dwc3

This patch series was rebased on
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
However the dependent modules are not yet upstreamed and hence only compile
tested in this tree

Kishon Vijay Abraham I (3):
  usb: phy: add a new driver for usb3 phy
  usb: phy: omap-usb3: Decrease the number of transitions to recovery
  usb: phy: omap-usb2: enable 960Mhz clock for omap5

Moiz Sonasath (1):
  usb: dwc3: Fix gadget pullup in SS mode

 Documentation/devicetree/bindings/usb/usb-phy.txt |   21 ++
 drivers/usb/dwc3/gadget.c                         |   21 +-
 drivers/usb/phy/Kconfig                           |    9 +
 drivers/usb/phy/Makefile                          |    1 +
 drivers/usb/phy/omap-usb2.c                       |   28 +-
 drivers/usb/phy/omap-usb3.c                       |  416 +++++++++++++++++++++
 include/linux/usb/omap_usb.h                      |   73 ++++
 include/linux/usb/phy.h                           |   10 +-
 8 files changed, 571 insertions(+), 8 deletions(-)
 create mode 100644 drivers/usb/phy/omap-usb3.c

-- 
1.7.9.5
