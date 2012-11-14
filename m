From: p.paneri@samsung.com (Praveen Paneri)
Date: Wed, 14 Nov 2012 15:57:14 +0530
Subject: [PATCH v8 0/2] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
Message-ID: <1352888836-17192-1-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v7:
Rebased to the latest usb-next branch.
Separating arch patches from these driver patches.

Changes from v6:
Modified register definitions according to the existing ones.
Changed default PHY clk selection for SoCs.
Improved binding text and rebased to the latest usb-next.

Changes from v5:
Moved clk_get() to driver's probe function. Now reference clock frequency
selection value is stored in samsung_usbphy structure for later use. Used
IS_ENABLED() instead of #ifdef in samsung_usbphy_get_driver_data().

Changes from v4:
Moved header file contents to driver's source file
Removed unnecessary print message from driver's probe function
Dropped the Free Software Foundation address from the header

Changes from v3:
Replaced susbsys_initcall()/module_exit() by module_platform_driver().
Accordingly in the hsotg driver returned -EPROBE_DEFER until phy driver
is registered
Removed unnecessary devm_usb_put_phy() call from the hsotg driver remove.

Changes from v2:
Changed the driver filenames to samsung-usbphy
Rectified coding style related errors

Changes from v1:
Rebased patches to latest usb-next branch
Changed the name 'sec_usbphy' to 'samsung_usbphy'

This patch set introduces a phy driver for samsung SoCs. It uses the existing
transceiver infrastructure to provide phy control functions. Use of this driver
can be extended for usb host phy as well. Over the period of time all the phy
related code for most of the samsung SoCs can be integrated here.
Removing the existing phy code from mach-s3c64xx. Same can be done for other SoCs
when they start supporting this phy driver. 
This driver is tested with smdk6410 and Exynos4210(with DT).

Praveen Paneri (2):
  usb: phy: samsung: Introducing usb phy driver for hsotg
  usb: s3c-hsotg: Adding phy driver support

 .../devicetree/bindings/usb/samsung-usbphy.txt     |   11 +
 drivers/usb/gadget/s3c-hsotg.c                     |   37 ++-
 drivers/usb/phy/Kconfig                            |    8 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/samsung-usbphy.c                   |  360 ++++++++++++++++++++
 include/linux/platform_data/samsung-usbphy.h       |   27 ++
 6 files changed, 434 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-usbphy.txt
 create mode 100644 drivers/usb/phy/samsung-usbphy.c
 create mode 100644 include/linux/platform_data/samsung-usbphy.h
