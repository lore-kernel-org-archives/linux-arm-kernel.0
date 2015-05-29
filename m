From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 29 May 2015 20:03:35 +0200
Subject: [PATCH v3 0/2] USB OTG PHY driver for NXP LPC18xx family
Message-ID: <1432922617-11512-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the internal USB OTG PHY found
on NXP LPC18xx and LPC43xx devices. Driver takes care of
enabling the PHY and setting the clock rate which is need for
USB0 support on this platform.

This version address the comments from Kishon Vijay Abraham I.

Changes in v3:
 - depend on MFD_SYSCON

Changes in v2:
 - use PTR_ERR_OR_ZERO in phy driver
 - rename binding doc
 - update doc commit message

Base support for this platform can now be found in arm-soc next.

Joachim Eastwood (2):
  phy: add lpc18xx usb otg phy driver
  phy: dt bindings: add XP LPC18xx/43xx USB OTG PHY bindings

 .../bindings/phy/phy-lpc18xx-usb-otg.txt           |  19 +++
 drivers/phy/Kconfig                                |  11 ++
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lpc18xx-usb-otg.c                  | 143 +++++++++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-lpc18xx-usb-otg.txt
 create mode 100644 drivers/phy/phy-lpc18xx-usb-otg.c

-- 
1.8.0
