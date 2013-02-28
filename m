From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Feb 2013 11:56:59 +0100
Subject: [PATCH 0/5] chipidea-for-v3.10-v2: USB chipidea: make use of DT
 helpers in chipidea driver improve driver
Message-ID: <1362049024-11383-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series depends on the series "[PATCH 0/3] otg-for-v3.10-v2: separate phy
code and add DT helper" (a.k.a. tags/otg-for-v3.10-v2) posted earlier and is
intended for v3.10. The chipidea driver is converted to make use of the DT
helper functions.

No changes since v1, just rebased to otg-for-v3.10-v2, in case someone wants to
pull it.

regards,
Marc

---

The following changes since commit f5678b135967ea98256ee5df9a360b5769861d23:

  USB mxs-phy: Register phy with framework (2013-02-28 11:36:45 +0100)

are available in the git repository at:

  git://git.pengutronix.de/git/mkl/linux.git tags/chipidea-for-v3.10-v2

for you to fetch changes up to 11e56207b94d65f92acdee17c795753378c581c6:

  USB chipidea i.MX: use devm_usb_get_phy_by_phandle to get phy (2013-02-28 11:36:48 +0100)

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
