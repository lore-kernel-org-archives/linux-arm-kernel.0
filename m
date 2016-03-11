From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Mar 2016 16:49:50 -0500
Subject: [PATCH V15 0/4] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1457732994-11175-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dma: add Qualcomm Technologies HIDMA driver

The Qualcomm Technologies HIDMA device has been designed
to support virtualization technology. The driver has been
divided into two to follow the hardware design.

1. HIDMA Management driver
2. HIDMA Channel driver

Each HIDMA HW consists of multiple channels. These channels
share some set of common parameters. These parameters are
initialized by the management driver during power up.
Same management driver is used for monitoring the execution
of the channels. Management driver can change the performance
behavior dynamically such as bandwidth allocation and
prioritization in the future.

The management driver is executed in host context and
is the main management entity for all channels provided by
the device.

------------------------
What's new
------------------------
- Coding style corrections.
- Correct OF node lookup.

------------------------
Git repos
------------------------
QEMU Support
https://www.codeaurora.org/cgit/quic/qemu/qemu/log/?h=v2.5.0-sriov

------------------------
History of Changes
------------------------
dma: qcom_hidma: add support for object hierarchy
Changes from V14: (https://lkml.org/lkml/2016/2/4/1089)
* use correct node (child) to read dma attribute.

dma: qcom_hidma: implement lower level hardware interface
Changes from V14: (https://lkml.org/lkml/2016/2/4/1086)
* renamed constants as HIDMA_xyz

dma: qcom_hidma: add support for object hierarchy
Changes from V14: (https://lkml.org/lkml/2016/2/4/1089)
* renamed constants as HIDMA_xyz

Sinan Kaya (4):
  dma: qcom_hidma: implement lower level hardware interface
  dma: qcom_hidma: add debugfs hooks
  dma: qcom_hidma: add support for object hierarchy
  dma: qcom_hidma: read the channel id from HW

 Documentation/ABI/testing/sysfs-platform-hidma     |   9 +
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |   3 -
 drivers/dma/qcom/*Backtrace*                       |   4 +
 drivers/dma/qcom/Makefile                          |   2 +
 drivers/dma/qcom/hidma.c                           |  81 +-
 drivers/dma/qcom/hidma.h                           |  20 +-
 drivers/dma/qcom/hidma_dbg.c                       | 219 +++++
 drivers/dma/qcom/hidma_ll.c                        | 918 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 111 ++-
 9 files changed, 1313 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma
 create mode 100644 drivers/dma/qcom/*Backtrace*
 create mode 100644 drivers/dma/qcom/hidma_dbg.c
 create mode 100644 drivers/dma/qcom/hidma_ll.c

-- 
1.8.2.1
