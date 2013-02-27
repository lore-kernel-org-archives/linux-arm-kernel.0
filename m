From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 15:16:27 +0100
Subject: [PATCH 0/3] otg-for-v3.10-v1: separate phy code and add DT helper
Message-ID: <1361974590-21237-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series depends on the bugfix patch "USB otg: use try_module_get in all
usb_get_phy functions and add missing module_put" (a.k.a tags/otg-for-v3.9-v1)
posted earlier and is inteded for v3.10. It separates the phy from the otg code
and adds DT helper functions. Further mxs-phy uses the new usb_add_phy_dev()
function to register it's phy.

regards,
Marc


The following changes since commit 6bef020b4aebd7886281fb7fb37c788d5a365eea:

  USB otg: use try_module_get in all usb_get_phy functions and add missing module_put (2013-02-27 12:53:15 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/mkl/linux.git tags/otg-for-v3.10-v1

for you to fetch changes up to 8a4c9f8489b2fce9e7bf0eb43fdb160ab51adc2c:

  USB mxs-phy: Register phy with framework (2013-02-27 13:48:21 +0100)

----------------------------------------------------------------
USB otg, phy: separate phy and add DT helper

Move phy related code into separate file and add device tree helper functions.

----------------------------------------------------------------
Michael Grzeschik (1):
      USB: add devicetree helpers for determining dr_mode and phy_type

Sascha Hauer (2):
      USB: move bulk of otg/otg.c to phy/phy.c
      USB mxs-phy: Register phy with framework

 drivers/usb/otg/mxs-phy.c |    9 +
 drivers/usb/otg/otg.c     |  427 -------------------------------------------
 drivers/usb/phy/Makefile  |    2 +
 drivers/usb/phy/of.c      |   47 +++++
 drivers/usb/phy/phy.c     |  438 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/usb-common.c  |   37 ++++
 include/linux/usb/of.h    |   27 +++
 include/linux/usb/otg.h   |    8 +
 include/linux/usb/phy.h   |    9 +
 9 files changed, 577 insertions(+), 427 deletions(-)
 create mode 100644 drivers/usb/phy/of.c
 create mode 100644 drivers/usb/phy/phy.c
 create mode 100644 include/linux/usb/of.h
