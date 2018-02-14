From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Feb 2018 17:16:18 +0100
Subject: [PATCH 0/2] Allow xhci-plat using a second clock
Message-ID: <20180214161620.4401-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The purpose of this series is to allow xhci-plat using a second
clock. It is needed on the Armada 7K/8K but could be used by other
SoCs.

The first patch is just a fix found while I was working on this
feature.

Thanks,

Gregory


Gregory CLEMENT (2):
  usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
  usb: host: xhci-plat: Fix clock resource by adding a register clock

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 ++-
 drivers/usb/host/xhci-plat.c                       | 39 ++++++++++++++++------
 drivers/usb/host/xhci.h                            |  3 +-
 3 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.15.1
