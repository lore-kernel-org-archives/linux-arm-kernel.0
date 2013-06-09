From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 10 Jun 2013 01:40:03 +0300
Subject: [PATCH 0/3] USB: OMAP: Tahvo USB support for 770
Message-ID: <1370817606-1008-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for Tahvo USB transceiver and allow using both
host and peripheral modes on Nokia 770.

Tested (peripheral mode, host mode, vbus detection) with 3.10-rc4.

Aaro Koskinen (3):
  ARM: OMAP1: nokia770: enable Tahvo
  USB: OMAP: add omap-otg
  USB: OMAP: Tahvo USB transceiver driver

 arch/arm/mach-omap1/board-nokia770.c |   10 +
 drivers/usb/phy/Kconfig              |   24 ++
 drivers/usb/phy/Makefile             |    2 +
 drivers/usb/phy/phy-omap-otg.c       |  126 ++++++++++
 drivers/usb/phy/phy-tahvo.c          |  429 ++++++++++++++++++++++++++++++++++
 include/linux/usb/omap-otg.h         |   19 ++
 6 files changed, 610 insertions(+)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/usb/omap-otg.h

-- 
1.7.10.4
