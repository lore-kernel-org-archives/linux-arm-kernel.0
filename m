From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 25 Nov 2013 15:16:18 -0500
Subject: [PATCH 0/3] Kesytone II USB support
Message-ID: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series adds USB host support for Keystone SOCs. Keystone SOCs uses dwc3
hardware IP implementation.  On Keystone II platforms, we use no-op phy
driver.

All three patches are posted together just for completeness. Only first patch
is expected to go via usb tree and other two via linux-keystone tree.

Patchset are tested on Keystone II EVM with USB2.0 and USB3.0 flash drives.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

WingMan Kwok (3):
  usb: dwc3: Add Keystone specific glue layer
  ARM: dts: keystone: Add usb devicetree bindings
  ARM: keystone: defconfig: enable USB host mode support

 .../devicetree/bindings/usb/keystone-usb.txt       |   43 ++++
 arch/arm/boot/dts/keystone.dtsi                    |   27 ++
 arch/arm/configs/keystone_defconfig                |   20 +-
 drivers/usb/dwc3/Kconfig                           |    7 +
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/dwc3-keystone.c                   |  272 ++++++++++++++++++++
 6 files changed, 369 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
 create mode 100644 drivers/usb/dwc3/dwc3-keystone.c

-- 
1.7.9.5
