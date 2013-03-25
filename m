From: chao.xie@marvell.com (Chao Xie)
Date: Mon, 25 Mar 2013 03:06:51 -0400
Subject: [PATCH V2 0/6] remove the clock name from pdata
Message-ID: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock is defined by device, so the driver knows how many
clocks needed by the device.
The orignal way that passing the clock name by pdata is not correct.
The following patches fix it.

V2->V1:
   typo fix
   rebased on latest usb-next

Chao Xie (6):
  usb: gadget: mv_udc_core: remove unused clock
  usb: otg: mv_otg: remove unused clock
  usb: ehci: mv_ehci: remove unused clock
  arm: mmp: remove clock from usb pdata for aspenite
  arm: mmp: remove clock name from usb pdata for ttc
  usb: mv_usb: remove clock name from pdata

 arch/arm/mach-mmp/aspenite.c         |    6 -----
 arch/arm/mach-mmp/ttc_dkb.c          |    6 -----
 drivers/usb/gadget/mv_udc.h          |    3 +-
 drivers/usb/gadget/mv_udc_core.c     |   27 ++++++-------------------
 drivers/usb/host/ehci-mv.c           |   35 +++++++++------------------------
 drivers/usb/phy/phy-mv-usb.c         |   28 ++++++--------------------
 drivers/usb/phy/phy-mv-usb.h         |    3 +-
 include/linux/platform_data/mv_usb.h |    2 -
 8 files changed, 26 insertions(+), 84 deletions(-)

-- 
1.7.4.1
