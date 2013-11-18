From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Nov 2013 16:54:34 +0100
Subject: [RESEND PATCH v3 0/4] usb: musb bugfixes
Message-ID: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I rebased this series onto Felipe's next branch. There are no other changes.

The series contains two bugfixes and some debugfs file operations for dsps
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

-- 
1.8.4.2
