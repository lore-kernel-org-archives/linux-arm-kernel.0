From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 5 Oct 2018 20:00:02 +0530
Subject: [PATCH 0/4] firmware: ti_sci: Introduce RM support
Message-ID: <20181005143006.18284-1-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for:
- Resource management(RM) core apis to get the range of resources assigned to
  a device.
- RM IRQ management apis to configure/release the irq route between requested
  source and destination.

More information on RM APIs can be found here[1].

Based on tag: next-20181005
Boot Log: https://pastebin.ubuntu.com/p/FCvgrRMXtM/

[1] http://downloads.ti.com/tisci/esd/latest/

Grygorii Strashko (1):
  firmware: ti_sci: Add support to get TISCI handle using of_phandle

Lokesh Vutla (3):
  firmware: ti_sci: Add support for RM core ops
  firmware: ti_sci: Add support for IRQ management
  firmware: ti_sci: Add helper apis to mange resources

 drivers/firmware/ti_sci.c              | 759 +++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 102 ++++
 include/linux/soc/ti/ti_sci_protocol.h | 168 ++++++
 3 files changed, 1029 insertions(+)

-- 
2.19.0
