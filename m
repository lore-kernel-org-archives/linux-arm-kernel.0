From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 9 Dec 2013 17:17:02 -0500
Subject: [PATCH v3 0/2] Kesytone II USB host and PHY drivers
Message-ID: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is the updated version of the series which addresses comments from
earlier version [1]. The lock in the isr is removed as per the discussion.

Series adds USB host support for Keystone SOCs. Keystone SOCs uses dwc3
hardware IP implementation.  On Keystone II platforms, we use no-op phy driver.

Patchset are tested on Keystone II EVM with USB2.0 and USB3.0 flash drives
along with dts changes.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

WingMan Kwok (2):
  usb: dwc3: Add Keystone specific glue layer
  usb: phy: Add keystone usb phy driver

 drivers/usb/dwc3/Kconfig         |    7 ++
 drivers/usb/dwc3/Makefile        |    1 +
 drivers/usb/dwc3/dwc3-keystone.c |  205 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/phy/Kconfig          |   10 ++
 drivers/usb/phy/Makefile         |    1 +
 drivers/usb/phy/phy-keystone.c   |  142 ++++++++++++++++++++++++++
 6 files changed, 366 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-keystone.c
 create mode 100644 drivers/usb/phy/phy-keystone.c

[1] http://www.spinics.net/lists/linux-usb/msg98861.html
-- 
1.7.9.5
