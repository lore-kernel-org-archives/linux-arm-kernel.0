From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 4 Dec 2015 22:10:45 +0800
Subject: [PATCH 0/7] usb: xhci-plat: support generic PHY and vbus regulator
Message-ID: <1449238252-5630-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell BG4CT has xhci controller. This controller has two phys:
one for usb2 and another for usb3. BG4CT boards have board level vbus
control through gpio.

I plan to add the xhci support in two steps: first of all, add generic
PHY and vbus regulator control support to the xhci-plat driver. Then
add the usb2 and usb3 phy drivers, after that, we add the phy and xhci
nodes in the dtsi.

This series takes the first step. The first three patches are bug fix.
Then two clean up patches. The last two patches add generic PHY and
vbus regulator control support.


Jisheng Zhang (7):
  usb: xhci: plat: Fix suspend/resume when the optional clk exists
  usb: xhci: plat: attach the usb_phy to the correct hcd
  usb: xhci: plat: Fix suspend/resume when the optional usb_phy exists
  usb: xhci: plat: sort the headers in alphabetic order
  usb: xhci: plat: Remove checks for optional clock in error/remove path
  usb: xhci: plat: add generic PHY support
  usb: xhci: plat: add vbus regulator control

 drivers/usb/host/xhci-plat.c | 159 +++++++++++++++++++++++++++++++++++++------
 drivers/usb/host/xhci.h      |   2 +
 2 files changed, 140 insertions(+), 21 deletions(-)

-- 
2.6.2
