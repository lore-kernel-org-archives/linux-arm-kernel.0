From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 15:20:25 +0100
Subject: [PATCH 0/5] chipidea-for-v3.10-v1: USB chipidea: make use of DT
 helpers in chipidea driver improve driver
Message-ID: <1361974830-3853-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series depends on the series "[PATCH 0/3] otg-for-v3.10-v1: separate phy
code and add DT helper" (a.k.a. tags/otg-for-v3.10-v1) posted earlier and is
intended for v3.10. The chipidea driver is converted to make use of the DT
helper functions.

regards,
Marc


The following changes since commit 8a4c9f8489b2fce9e7bf0eb43fdb160ab51adc2c:

  USB mxs-phy: Register phy with framework (2013-02-27 13:48:21 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/mkl/linux.git tags/chipidea-for-v3.10-v1

for you to fetch changes up to 5d837224ea36da50f3e744a65fb23af1fa0a480d:

  USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy (2013-02-27 13:49:07 +0100)

----------------------------------------------------------------
USB chipidea: make use of DT helpers in chipidea driver

Make use of DT helper functions for handling the dr_mode and phy_type property.

----------------------------------------------------------------
Michael Grzeschik (2):
      USB chipidea: ci13xxx-imx: create dynamic platformdata
      USB chipidea: add PTW and PTS handling

Sascha Hauer (3):
      USB chipidea: introduce dual role mode pdata flags
      USB chipidea i.MX: introduce dr_mode property
      USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy

 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    6 ++
 drivers/usb/chipidea/bits.h                        |   14 +++-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   67 +++++++++++---------
 drivers/usb/chipidea/core.c                        |   61 ++++++++++++++++--
 include/linux/usb/chipidea.h                       |    3 +-
 5 files changed, 112 insertions(+), 39 deletions(-)
