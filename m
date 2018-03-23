From: rishabhb@codeaurora.org (Rishabh Bhatnagar)
Date: Fri, 23 Mar 2018 16:36:00 -0700
Subject: [PATCH v1 0/2] SDM845 System Cache Driver
Message-ID: <1521848162-11338-1-git-send-email-rishabhb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series implements system cache or LLCC(Last Level Cache Controller) driver
for SDM845 SOC. The purpose of the driver is to partition the system cache and
program the settings such as priortiy, lines to probe while doing a look up
in the system cache, low power related settings etc. The partitions are called
cache slices. Each cache slice is associated with size and SCID(System Cache ID)
The driver also provides API for clients to query the cache slice details,
activate and deactivate them.

The driver can be broadly classified into:
* SOC specific driver: llcc-sdm845.c: Cache partitioning and cache slice
properties for usecases on sdm845 that need to use system cache.

* API : llcc-slice.c: Exports APIs to clients to query cache slice details,
activate and deactivate cache slices. Register the child devices using platform 
APIs.

Changes since v0:
* Removed the syscon and simple-mfd approach
* Updated the device tree nodes to mention LLCC as a single HW block
* Moved llcc bank offsets from device tree and handled the offset
  in the driver.


ckadabi at codeaurora.org (2):
  Documentation: Documentaion for qcom, llcc
  drivers: soc: Add LLCC driver

 .../devicetree/bindings/arm/msm/qcom,llcc.txt      |  78 ++++
 drivers/soc/qcom/llcc-sdm845.c                     | 120 ++++++
 drivers/soc/qcom/llcc-slice.c                      | 460 +++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h                 | 178 ++++++++
 4 files changed, 836 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
 create mode 100644 drivers/soc/qcom/llcc-sdm845.c
 create mode 100644 drivers/soc/qcom/llcc-slice.c
 create mode 100644 include/linux/soc/qcom/llcc-qcom.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
