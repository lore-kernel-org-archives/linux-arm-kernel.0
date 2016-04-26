From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 26 Apr 2016 20:57:33 +0800
Subject: [RESEND PATCH v2 0/7] usb: xhci-plat: support generic PHY and vbus
 regulator
Message-ID: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
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

Since v1:
 - fix NULL pointer dereference in [PATCH 7/7]

Jisheng Zhang (7):
  usb: xhci: plat: Fix suspend/resume when the optional clk exists
  usb: xhci: plat: attach the usb_phy to the correct hcd
  usb: xhci: plat: Fix suspend/resume when the optional usb_phy exists
  usb: xhci: plat: sort the headers in alphabetic order
  usb: xhci: plat: Remove checks for optional clock in error/remove path
  usb: xhci: plat: add generic PHY support
  usb: xhci: plat: add vbus regulator control

 drivers/usb/host/xhci-plat.c | 162 +++++++++++++++++++++++++++++++++++++------
 drivers/usb/host/xhci.h      |   2 +
 2 files changed, 142 insertions(+), 22 deletions(-)

-- 
2.8.1
