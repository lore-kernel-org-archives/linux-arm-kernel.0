From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 11 Jan 2016 09:45:40 -0500
Subject: [PATCH v12 0/7] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
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

Creating a QCOM directory for all QCOM DMA source files.
Changes from V11: (https://lkml.org/lkml/2016/1/3/249)
* none

dma: hidma: Add Device Tree support
Changes from V11: (https://lkml.org/lkml/2016/1/3/243)
* none

dma: add Qualcomm Technologies HIDMA management driver
Changes from V11: (https://lkml.org/lkml/2016/1/3/248)
* Correct range check in the sysfs.
* increase the print array in sysfs.

dma: add Qualcomm Technologies HIDMA channel driver
Changes from V11: (https://lkml.org/lkml/2016/1/3/244)
* none

dma: qcom_hidma: implement lower level hardware interface
Changes from V11: (https://lkml.org/lkml/2016/1/3/247)
* introduce HIDMA_CH_STATE macro to simplify testing conditions.
* introduce HIDMA_INCREMENT_ITERATOR macro to simplify code
* replace devm_kzalloc with devm_kcalloc in certain places.

dma: qcom_hidma: add debugfs hooks
Changes from V11: (https://lkml.org/lkml/2016/1/3/245)
* none

dma: qcom_hidma: add support for object hierarchy
Changes from V11: (https://lkml.org/lkml/2016/1/3/246)
* none

Sinan Kaya (7):
  dma: qcom_bam_dma: move to qcom directory
  dma: hidma: Add Device Tree support
  dma: add Qualcomm Technologies HIDMA management driver
  dma: add Qualcomm Technologies HIDMA channel driver
  dma: qcom_hidma: implement lower level hardware interface
  dma: qcom_hidma: add debugfs hooks
  dma: qcom_hidma: add support for object hierarchy

 Documentation/ABI/testing/sysfs-platform-hidma     |   9 +
 .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  79 ++
 drivers/dma/Kconfig                                |  11 +-
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/qcom/Kconfig                           |  29 +
 drivers/dma/qcom/Makefile                          |   5 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c}     |   4 +-
 drivers/dma/qcom/hidma.c                           | 784 +++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 162 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 219 +++++
 drivers/dma/qcom/hidma_ll.c                        | 927 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 400 +++++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  39 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 295 +++++++
 15 files changed, 3050 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma-mgmt
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
