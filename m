From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 30 Apr 2012 16:16:27 -0500
Subject: [PATCH V3 0/2] of: Add generic device tree DMA helpers
Message-ID: <1335820587-28679-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Hunter <jon-hunter@ti.com>

This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
to add some basic helpers to retrieve a DMA controller device_node and the
DMA request/channel information.

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/12022
[2] http://article.gmane.org/gmane.linux.ports.arm.omap/73622

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Arnd Bergmann <arnd@arndb.de>

Jon Hunter (2):
  of: Add generic device tree DMA helpers
  of: selftest/dma: Add selftest for new DT DMA

 Documentation/devicetree/bindings/dma/dma.txt |   47 ++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts        |    2 +
 arch/arm/boot/dts/omap4-panda.dts             |    2 +
 arch/arm/boot/dts/testcases/tests-dma.dtsi    |   32 ++++
 arch/arm/boot/dts/testcases/tests.dtsi        |    1 +
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  203 +++++++++++++++++++++++++
 drivers/of/selftest.c                         |  118 ++++++++++++++
 include/linux/of_dma.h                        |   35 +++++
 9 files changed, 441 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 arch/arm/boot/dts/testcases/tests-dma.dtsi
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

-- 
1.7.5.4
