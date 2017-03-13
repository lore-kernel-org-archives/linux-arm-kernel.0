From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 13 Mar 2017 10:18:40 +0800
Subject: [PATCH 0/5] usb: introduce sysdev 
Message-ID: <1489371525-18928-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

This series adds supporting USB gets correct DMA configuration from firmware
eg, Device Tree, and the patches are well discussed at mail list, since it
changes a lot, I think it should be a new feature than a bug-fix.

The series is based on the latest usb-next branch.

Thanks.

Arnd Bergmann (4):
  usb: separate out sysdev pointer from usb_bus
  usb: chipidea: use bus->sysdev for DMA configuration
  usb: ehci: fsl: use bus->sysdev for DMA configuration
  usb: xhci: use bus->sysdev for DMA configuration

Peter Chen (1):
  usb: ehci: use bus->sysdev for DMA configuration

 drivers/usb/chipidea/core.c  |  3 --
 drivers/usb/chipidea/host.c  |  3 +-
 drivers/usb/chipidea/udc.c   | 10 +++---
 drivers/usb/core/buffer.c    | 12 +++----
 drivers/usb/core/hcd.c       | 80 +++++++++++++++++++++++++-------------------
 drivers/usb/core/usb.c       | 18 +++++-----
 drivers/usb/host/ehci-fsl.c  |  4 +--
 drivers/usb/host/ehci-mem.c  | 12 +++----
 drivers/usb/host/xhci-mem.c  | 12 +++----
 drivers/usb/host/xhci-plat.c | 35 ++++++++++++++-----
 drivers/usb/host/xhci.c      | 15 ++++++---
 include/linux/usb.h          |  1 +
 include/linux/usb/hcd.h      |  3 ++
 13 files changed, 124 insertions(+), 84 deletions(-)

-- 
2.7.4
