From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 16 Jun 2013 16:35:07 +0300
Subject: [PATCH v2 0/5] USB: OMAP1: Tahvo USB support for 770
Message-ID: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for Tahvo USB transceiver and allow using both
host and peripheral modes on Nokia 770.

Tested (peripheral mode, host mode, vbus detection) with 3.10-rc6.

History:
	v2: Use extcon framework to trigger OTG driver mode changes.
	v1: http://marc.info/?l=linux-omap&m=137081763029385&w=2

Earlier RFC versions:
	http://marc.info/?l=linux-omap&m=136553710000679&w=2
	http://marc.info/?l=linux-omap&m=136266725827698&w=2

Aaro Koskinen (5):
  ARM: OMAP1: USB: move omap_usb_config to platform data
  USB: OMAP1: add extcon to platform data
  USB: OMAP1: OTG controller driver
  USB: OMAP1: Tahvo USB transceiver driver
  ARM: OMAP1: nokia770: enable Tahvo

 arch/arm/mach-omap1/board-nokia770.c    |  11 +
 arch/arm/mach-omap1/include/mach/usb.h  |  38 +--
 drivers/usb/phy/Kconfig                 |  24 ++
 drivers/usb/phy/Makefile                |   2 +
 drivers/usb/phy/phy-omap-otg.c          | 171 ++++++++++++
 drivers/usb/phy/phy-tahvo.c             | 448 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/usb-omap1.h |  53 ++++
 7 files changed, 710 insertions(+), 37 deletions(-)
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/platform_data/usb-omap1.h

-- 
1.8.3.1

A.
