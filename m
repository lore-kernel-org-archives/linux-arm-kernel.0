From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 19 Apr 2018 15:30:51 +0200
Subject: [PATCH v2 0/2] Allow xhci-plat using a second clock
Message-ID: <20180419133053.11894-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The purpose of this series is to allow xhci-plat using a second
clock. It is needed on the Armada 7K/8K but could be used by other
SoCs.

The first patch is just an other fix found while I was working on this
feature.

Thanks,

Gregory

Changelog:
v1 -> v2:

 - Rebased on v4.17-rc1

Gregory CLEMENT (2):
  usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
  usb: host: xhci-plat: Fix clock resource by adding a register clock

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 +++-
 drivers/usb/host/xhci-plat.c                       | 31 ++++++++++++++++------
 drivers/usb/host/xhci.h                            |  3 ++-
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.16.3
