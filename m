From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 16 Oct 2013 14:51:08 +0200
Subject: [PATCH v3 0/0] usb: musb bugfixes
Message-ID: <1381927872-8181-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the series contains two bugfixes and some debugfs file operations for dsps
similar to the musb core regdump debugfs file.

Regards,

Markus Pargmann

Changes in v3:
- Using debugfs_reg32 for regdump debug file
- Added a patch to replace kzalloc with devm_kzalloc
- otg->gadget_driver NULL pointer handling was replaced by a musb_g_reset
  patch to force IDLE states when no gadget driver is loaded.


Markus Pargmann (4):
      usb: musb: gadget, stay IDLE without gadget driver
      usb: musb: Bugfix of_node assignment
      usb: musb: dsps, debugfs files
      usb: musb: dsps, use devm_kzalloc

 drivers/usb/musb/musb_core.c   | 15 ++++++++---
 drivers/usb/musb/musb_dsps.c   | 60 +++++++++++++++++++++++++++++++++++++++---
 drivers/usb/musb/musb_gadget.c | 14 ++++++++--
 3 files changed, 79 insertions(+), 10 deletions(-)
