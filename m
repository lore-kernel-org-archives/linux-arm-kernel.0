From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 14 Sep 2012 10:18:41 -0500
Subject: [PATCH V5 0/2] of: Add generic device tree DMA helpers
Message-ID: <1347635923-30166-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2] to add
some basic device-tree helpers to retrieve a DMA controller device_node and the
DMA request/channel information.

v5: - minor update to binding documentation
    - added loop to exhaustively search for a slave channel in the case where
      there could be alternative channels available
v4: - revert the removal of xlate function from v3
    - update the proposed binding format and APIs based upon discussions [3]
v3: - avoid passing an xlate function and instead pass DMA engine parameters
    - define number of dma channels and requests in dma-controller node
v2: - remove of_dma_to_resource API
    - make property #dma-cells required (no fallback anymore)
    - another check in of_dma_xlate_onenumbercell() function

[1] http://article.gmane.org/gmane.linux.drivers.devicetree/12022
[2] http://article.gmane.org/gmane.linux.ports.arm.omap/73622
[3] http://marc.info/?l=linux-omap&m=133582085008539&w=2

Jon Hunter (2):
  of: Add generic device tree DMA helpers
  dmaengine: add helper function to request a slave DMA channel

 Documentation/devicetree/bindings/dma/dma.txt |   80 +++++++++
 drivers/dma/dmaengine.c                       |   16 ++
 drivers/of/Makefile                           |    2 +-
 drivers/of/dma.c                              |  219 +++++++++++++++++++++++++
 include/linux/dmaengine.h                     |    6 +
 include/linux/of_dma.h                        |   45 +++++
 6 files changed, 367 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma.txt
 create mode 100644 drivers/of/dma.c
 create mode 100644 include/linux/of_dma.h

-- 
1.7.9.5
