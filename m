From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 8 Jan 2016 13:44:22 +0800
Subject: [RFC PATCH 0/2] USB: let the USB device know device node
Message-ID: <1452231864-11171-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

For some hard wired USB devices[1], we may need to use device tree to
describe them, the first patch is teach USB device to know device
node, the second patch is an example to show how to get properties
through device node at USB device (class) driver.

[1] http://marc.info/?l=linux-usb&m=142772952730243&w=2

Peter Chen (2):
  USB: core: let USB device know device node
  usb: Example for how to use device node at usb device driver

 .../devicetree/bindings/usb/usb-device.txt         |  8 ++++
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  9 ++++
 drivers/usb/core/Makefile                          |  2 +-
 drivers/usb/core/hub.c                             |  8 ++++
 drivers/usb/core/of.c                              | 48 ++++++++++++++++++++++
 drivers/usb/core/usb.c                             |  8 +++-
 include/linux/usb.h                                |  2 +
 include/linux/usb/of.h                             |  6 +++
 8 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
 create mode 100644 drivers/usb/core/of.c

-- 
1.9.1
