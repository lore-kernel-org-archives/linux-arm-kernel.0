From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 22 Nov 2015 21:28:22 -0500
Subject: [PATCH V7 0/3] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1448245707-27499-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

The management driver is executed in hypervisor context and
is the main management entity for all channels provided by
the device.

Changes from V6: (https://lkml.org/lkml/2015/11/22/111)
* none

Changes from V6: (https://lkml.org/lkml/2015/11/22/112)
* remove extra _ in documentation
* remove extra parenthesis in assignments
* create subdirectories for channels in sysfs

Changes from V6: (https://lkml.org/lkml/2015/11/22/113)
* remove extra parenthesis

Sinan Kaya (3):
  dma: qcom_bam_dma: move to qcom directory
  dma: add Qualcomm Technologies HIDMA management driver
  dma: add Qualcomm Technologies HIDMA channel driver

 .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++
 .../devicetree/bindings/dma/qcom_hidma.txt         |  18 +
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++
 drivers/dma/Kconfig                                |  11 +-
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/qcom/Kconfig                           |  29 +
 drivers/dma/qcom/Makefile                          |   4 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c}     |   4 +-
 drivers/dma/qcom/hidma.c                           | 706 ++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 157 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 217 +++++
 drivers/dma/qcom/hidma_ll.c                        | 924 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 308 +++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  39 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 299 +++++++
 15 files changed, 2864 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma-mgmt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
 create mode 100644 drivers/dma/qcom/Kconfig
 create mode 100644 drivers/dma/qcom/Makefile
 rename drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c} (99%)
 create mode 100644 drivers/dma/qcom/hidma.c
 create mode 100644 drivers/dma/qcom/hidma.h
 create mode 100644 drivers/dma/qcom/hidma_dbg.c
 create mode 100644 drivers/dma/qcom/hidma_ll.c
 create mode 100644 drivers/dma/qcom/hidma_mgmt.c
 create mode 100644 drivers/dma/qcom/hidma_mgmt.h
 create mode 100644 drivers/dma/qcom/hidma_mgmt_sys.c

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
