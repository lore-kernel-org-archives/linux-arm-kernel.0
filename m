From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 31 Jan 2013 10:01:07 +0100
Subject: [PATCH v2] Add USB of helpers and use them in the chipidea driver
Message-ID: <1359622873-23345-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


changes since v1:

- move phy specific of helper to drivers/usb/phy/of.c
- use strcmp instead of strcasecmp for matching property values
- change usb_phy_dr_mode to usb_dr_mode
- change USBPHY_INTERFACE_MODE_NA to USBPHY_INTERFACE_MODE_UNKNOWN
- add copyright header to new files
- chipidea: drop mdelay at end of PTS/PTW setup
- chipidea: implement lpm core type handling for PTS/PTW

Sascha

----------------------------------------------------------------
Michael Grzeschik (3):
      USB: add devicetree helpers for determining dr_mode and phy_type
      USB: chipidea: ci13xxx-imx: create dynamic platformdata
      USB: chipidea: add PTW and PTS handling

Sascha Hauer (3):
      USB: move bulk of otg/otg.c to phy/phy.c
      USB chipidea: introduce dual role mode pdata flags
      USB chipidea i.MX: introduce dr_mode property

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 +
 drivers/usb/chipidea/bits.h                        |   14 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   29 +-
 drivers/usb/chipidea/core.c                        |   60 ++-
 drivers/usb/otg/otg.c                              |  423 -------------------
 drivers/usb/phy/Makefile                           |    2 +
 drivers/usb/phy/phy.c                              |  434 ++++++++++++++++++++
 drivers/usb/usb-common.c                           |   36 ++
 include/linux/usb/chipidea.h                       |    3 +-
 include/linux/usb/of.h                             |   27 ++
 include/linux/usb/otg.h                            |    7 +
 include/linux/usb/phy.h                            |    9 +
 12 files changed, 609 insertions(+), 441 deletions(-)
 create mode 100644 drivers/usb/phy/phy.c
 create mode 100644 include/linux/usb/of.h
