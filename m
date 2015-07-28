From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 27 Jul 2015 20:20:28 -0700
Subject: [PATCH v3 0/5] Qualcomm Shared Memory & RPM drivers
Message-ID: <1438053633-6659-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third iteration of the patches to add support for the regulators provided
by the RPM on family B Qualcomm devices.

This depends on the SMEM implementation that Andy already picked up.

Changes since v2:
- Made smd copy functions work on words for the word access channels
- Corrected access of smem items from secure heap
- Updated error handling path in RPM driver
- Moved init of smd to postcore and rpm to arch
- Minor nits from Georgi on the SMD code
- Moved rpm driver from mfd to soc

Bjorn Andersson (5):
  soc: qcom: Add device tree binding for Shared Memory Device
  soc: qcom: Add Shared Memory Driver
  devicetree: soc: Add Qualcomm SMD based RPM DT binding
  soc: qcom: Driver for the Qualcomm RPM over SMD
  regulator: Regulator driver for the Qualcomm RPM

 .../devicetree/bindings/soc/qcom,smd-rpm.txt       |  117 ++
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |   79 ++
 drivers/regulator/Kconfig                          |   12 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/qcom_smd-regulator.c             |  349 ++++++
 drivers/soc/qcom/Kconfig                           |   22 +
 drivers/soc/qcom/Makefile                          |    2 +
 drivers/soc/qcom/smd-rpm.c                         |  244 ++++
 drivers/soc/qcom/smd.c                             | 1319 ++++++++++++++++++++
 include/linux/soc/qcom/smd-rpm.h                   |   35 +
 include/linux/soc/qcom/smd.h                       |   46 +
 11 files changed, 2226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 drivers/regulator/qcom_smd-regulator.c
 create mode 100644 drivers/soc/qcom/smd-rpm.c
 create mode 100644 drivers/soc/qcom/smd.c
 create mode 100644 include/linux/soc/qcom/smd-rpm.h
 create mode 100644 include/linux/soc/qcom/smd.h

-- 
1.8.2.2
