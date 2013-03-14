From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:28 +0800
Subject: [PATCH 00/14] Add vbus status to udc-core
Message-ID: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vbus event is a common event for gadget, this patchset
move vbus status from individual driver private data to
common struct usb_gadget, after that, the udc core
can know vbus status well.

The last patch uses this vbus_active to determine if
we can pullup dp when load gadget module.

CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
CC: Li Yang <leoli@freescale.com>
CC: Roland Stigge <stigge@antcom.de>
CC: Yu Xu <yuxu@marvell.com>
CC: Chao Xie <chao.xie@marvell.com>
CC: Eric Miao <eric.y.miao@gmail.com>
CC: Ben Dooks <ben-linux@fluff.org>
CC: Felipe Balbi <balbi@ti.com>

Peter Chen (14):
  usb: udc-core: introduce vbus_active for struct usb_gadget
  usb: chipidea: using common vbus_active
  usb: at91_udc: using common vbus_active
  usb: fsl_udc_core: using common vbus_active
  usb: lpc32xx_udc: using common vbus_active
  usb: mv_u3d_core: using common vbus_active
  usb: mv_udc: using common vbus_active
  usb: omap_udc: using common vbus_active
  usb: pch_udc: using common vbus_active
  usb: pxa25x_udc: using common vbus_active
  usb: pxa27x_udc: using common vbus_active
  usb: s3c2410_udc: using common vbus_active
  usb: udc-core: small cleanup for udc->gadget
  usb: udc-core: add judgement logic for usb_gadget_connect

 drivers/usb/chipidea/ci.h         |    2 --
 drivers/usb/chipidea/udc.c        |    6 +++---
 drivers/usb/gadget/at91_udc.c     |   16 ++++++++--------
 drivers/usb/gadget/at91_udc.h     |    1 -
 drivers/usb/gadget/fsl_udc_core.c |    4 ++--
 drivers/usb/gadget/fsl_usb2_udc.h |    1 -
 drivers/usb/gadget/lpc32xx_udc.c  |    1 +
 drivers/usb/gadget/mv_u3d.h       |    1 -
 drivers/usb/gadget/mv_u3d_core.c  |   14 +++++++-------
 drivers/usb/gadget/mv_udc.h       |    1 -
 drivers/usb/gadget/mv_udc_core.c  |   14 +++++++-------
 drivers/usb/gadget/omap_udc.c     |    4 ++--
 drivers/usb/gadget/omap_udc.h     |    1 -
 drivers/usb/gadget/pch_udc.c      |   10 ++++------
 drivers/usb/gadget/pxa25x_udc.c   |    6 +++---
 drivers/usb/gadget/pxa25x_udc.h   |    1 -
 drivers/usb/gadget/pxa27x_udc.c   |    8 ++++----
 drivers/usb/gadget/pxa27x_udc.h   |    1 -
 drivers/usb/gadget/s3c2410_udc.c  |    6 +++---
 drivers/usb/gadget/s3c2410_udc.h  |    1 -
 drivers/usb/gadget/udc-core.c     |   24 ++++++++++++++++--------
 include/linux/usb/gadget.h        |    1 +
 22 files changed, 61 insertions(+), 63 deletions(-)
