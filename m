From: agross@codeaurora.org (Andy Gross)
Date: Fri, 31 Jul 2015 16:47:55 -0500
Subject: [GIT PULL] qcom SoC changes for 4.3 *CORRECTED*
Message-ID: <1438379275-6314-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://codeaurora.org/quic/kernel/agross-msm.git tags/qcom-soc-for-4.3

for you to fetch changes up to ba68227e610cec8e0bef7da7e04af3f479d9797d:

  devicetree: soc: Add Qualcomm SMD based RPM DT binding (2015-07-29 14:13:48 -0500)

----------------------------------------------------------------
Qualcomm ARM Based SoC Updates for 4.3

* Add SMEM driver
* Add SMD driver
* Add RPM over SMD driver
* Select QCOM_SCM by default

----------------------------------------------------------------
Bjorn Andersson (5):
      soc: qcom: Add Shared Memory Manager driver
      soc: qcom: Add device tree binding for Shared Memory Device
      soc: qcom: Add Shared Memory Driver
      soc: qcom: Driver for the Qualcomm RPM over SMD
      devicetree: soc: Add Qualcomm SMD based RPM DT binding

Lina Iyer (1):
      drivers: qcom: Select QCOM_SCM unconditionally for QCOM_PM

 .../devicetree/bindings/soc/qcom,smd-rpm.txt       |  117 ++
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |   79 ++
 drivers/soc/qcom/Kconfig                           |   31 +
 drivers/soc/qcom/Makefile                          |    3 +
 drivers/soc/qcom/smd-rpm.c                         |  244 ++++
 drivers/soc/qcom/smd.c                             | 1319 ++++++++++++++++++++
 drivers/soc/qcom/smem.c                            |  775 ++++++++++++
 include/linux/soc/qcom/smd-rpm.h                   |   35 +
 include/linux/soc/qcom/smd.h                       |   46 +
 include/linux/soc/qcom/smem.h                      |   11 +
 10 files changed, 2660 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 drivers/soc/qcom/smd-rpm.c
 create mode 100644 drivers/soc/qcom/smd.c
 create mode 100644 drivers/soc/qcom/smem.c
 create mode 100644 include/linux/soc/qcom/smd-rpm.h
 create mode 100644 include/linux/soc/qcom/smd.h
 create mode 100644 include/linux/soc/qcom/smem.h
