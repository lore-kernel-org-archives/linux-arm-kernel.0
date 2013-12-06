From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri,  6 Dec 2013 16:13:03 +0200
Subject: [PATCH v4 0/4] USB: OMAP1: Tahvo USB support for 770
Message-ID: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for Tahvo USB transceiver and allow using both
host and peripheral modes on Nokia 770.

Tested (peripheral mode, host mode, vbus detection) with 3.12-rc7.

History:
	v4: Register sysfs files with sysfs_create_group().
	    Rename "vbus_state" to "vbus".
	    Document the sysfs ABI.
	    Add missing clk disable to extcon registration error path.
	    Add missing extcon unregistration to probe error paths.
	    Move IRQ registration after PHY registration.
	v3: http://marc.info/?l=linux-omap&m=137157527930908&w=2
	    Delete accidental #include <mach/usb.h> from patch 3.
	    Drop board file changes, already queued to linux-omap.
	v2: http://marc.info/?l=linux-omap&m=137138976406242&w=2
	    Use extcon framework to trigger OTG driver mode changes.
	v1: http://marc.info/?l=linux-omap&m=137081763029385&w=2

Earlier RFC versions:
	http://marc.info/?l=linux-omap&m=136553710000679&w=2
	http://marc.info/?l=linux-omap&m=136266725827698&w=2

Aaro Koskinen (4):
  ARM: OMAP1: USB: move omap_usb_config to platform data
  USB: OMAP1: add extcon to platform data
  USB: OMAP1: OTG controller driver
  USB: OMAP1: Tahvo USB transceiver driver

 Documentation/ABI/testing/sysfs-platform-tahvo-usb |  16 +
 arch/arm/mach-omap1/include/mach/usb.h             |  38 +-
 drivers/usb/phy/Kconfig                            |  25 ++
 drivers/usb/phy/Makefile                           |   2 +
 drivers/usb/phy/phy-omap-otg.c                     | 169 ++++++++
 drivers/usb/phy/phy-tahvo.c                        | 461 +++++++++++++++++++++
 include/linux/platform_data/usb-omap1.h            |  53 +++
 7 files changed, 727 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-tahvo-usb
 create mode 100644 drivers/usb/phy/phy-omap-otg.c
 create mode 100644 drivers/usb/phy/phy-tahvo.c
 create mode 100644 include/linux/platform_data/usb-omap1.h

-- 
1.8.4.4
