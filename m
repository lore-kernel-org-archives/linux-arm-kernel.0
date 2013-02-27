From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 15:11:12 +0100
Subject: [PATCH] otg-for-v3.9-v1: USB otg: fix usage of try_module_get() and
 module_put()
Message-ID: <1361974273-17087-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch is intended for v3.9 and applies to Greg's usb/master tree. If fixes
the use of try_module_get() and module_put() in all usb_get_phy functions.

regards,
Marc


The following changes since commit 74e1a2a39355b2d3ae8c60c78d8add162c6d7183:

  Merge tag 'usb-3.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2013-02-21 12:20:00 -0800)

are available in the git repository at:


  git://git.pengutronix.de/git/mkl/linux.git tags/otg-for-v3.9-v1

for you to fetch changes up to 6bef020b4aebd7886281fb7fb37c788d5a365eea:

  USB otg: use try_module_get in all usb_get_phy functions and add missing module_put (2013-02-27 12:53:15 +0100)

----------------------------------------------------------------
USB otg: add missing try_module_get and module_put

Add try_module_get() to usb_get_phy() and usb_get_phy_dev().  Further the
missing module_put() is added to usb_put_phy()

----------------------------------------------------------------
Marc Kleine-Budde (1):
      USB otg: use try_module_get in all usb_get_phy functions and add missing module_put

 drivers/usb/otg/otg.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)
