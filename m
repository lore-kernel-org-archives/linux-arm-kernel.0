From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Jan 2013 16:29:36 +0100
Subject: [PATCH] Add USB of helpers and use them in the chipidea driver
Message-ID: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 2nd version of the USB of helper patch, this time with
adding support for the chipidea driver for the new properties.

Kishon, I decided against adding an extra Kconfig option for the
OF helpers since I found out the USB stuff already has enough options ;)

The helpers are now in usb-common.c which seems an appropriate place
for them. For the phy_type helpers I had a look again and saw that
it is not really phy specific, the PORTSC registers in the chipidea
driver have to be configured even without phy support compiled in.

Sascha

----------------------------------------------------------------
Michael Grzeschik (3):
      usb: add devicetree helpers for determining dr_mode and phy_type
      usb: chipidea: ci13xxx-imx: create dynamic platformdata
      usb: chipidea: add PTW and PTS handling

Sascha Hauer (2):
      USB chipidea: introduce dual role mode pdata flags
      USB chipidea i.MX: introduce dr_mode property

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 ++
 drivers/usb/chipidea/bits.h                        |    7 ++
 drivers/usb/chipidea/ci13xxx_imx.c                 |   29 +++++---
 drivers/usb/chipidea/core.c                        |   61 +++++++++++++++--
 drivers/usb/usb-common.c                           |   69 ++++++++++++++++++++
 include/linux/usb/chipidea.h                       |    3 +-
 include/linux/usb/of.h                             |   27 ++++++++
 include/linux/usb/otg.h                            |    7 ++
 include/linux/usb/phy.h                            |    9 +++
 9 files changed, 201 insertions(+), 17 deletions(-)
 create mode 100644 include/linux/usb/of.h
