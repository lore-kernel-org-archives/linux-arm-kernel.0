From: w-kwok2@ti.com (WingMan Kwok)
Date: Wed, 4 Dec 2013 15:10:06 -0500
Subject: [PATCH v2 0/5] Kesytone II USB support
Message-ID: <1386187811-9596-1-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the updated version of the series which addresses comments from
earlier version [1].  The PHY register programming is moved to a separate
PHY driver.

Series adds USB host support for Keystone SOCs. Keystone SOCs uses dwc3
hardware IP implementation.  On Keystone II platforms, we use no-op phy driver.

All three patches are posted together just for completeness. Only first patch
is expected to go via usb tree and other two via linux-keystone tree.

Patchset are tested on Keystone II EVM with USB2.0 and USB3.0 flash drives.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

WingMan Kwok (5):
  usb: dwc3: Add Keystone specific glue layer
  usb: phy: Add keystone usb phy driver
  ARM: dts: keystone: Add usb phy devicetree bindings
  ARM: dts: keystone: Add usb devicetree bindings
  ARM: keystone: defconfig: enable USB support

 .../devicetree/bindings/usb/keystone-phy.txt       |   19 ++
 .../devicetree/bindings/usb/keystone-usb.txt       |   41 ++++
 arch/arm/boot/dts/keystone.dtsi                    |   25 +++
 arch/arm/configs/keystone_defconfig                |   20 +-
 drivers/usb/dwc3/Kconfig                           |    7 +
 drivers/usb/dwc3/Makefile                          |    1 +
 drivers/usb/dwc3/dwc3-keystone.c                   |  210 ++++++++++++++++++++
 drivers/usb/phy/Kconfig                            |   10 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/phy-keystone.c                     |  142 +++++++++++++
 10 files changed, 475 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
 create mode 100644 drivers/usb/dwc3/dwc3-keystone.c
 create mode 100644 drivers/usb/phy/phy-keystone.c

[1] http://www.spinics.net/lists/linux-usb/msg98166.html
-- 
1.7.9.5
