From: bjorn@kryo.se (bjorn at kryo.se)
Date: Fri, 26 Jun 2015 14:50:08 -0700
Subject: [PATCH v2 00/11] Qualcomm Shared Memory & RPM drivers
Message-ID: <1435355419-23602-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

This second incarnation of the SMEM, SMD, RPM and pm8x41 regulator series fixes
the review comments received on v1 and adds the dts patches at the end.

Bjorn Andersson (11):
  soc: qcom: Add device tree binding for SMEM
  soc: qcom: Add Shared Memory Manager driver
  soc: qcom: Add device tree binding for Shared Memory Device
  soc: qcom: Add Shared Memory Driver
  mfd: devicetree: bindings: Add Qualcomm SMD based RPM DT binding
  mfd: qcom-smd-rpm: Driver for the Qualcomm RPM over SMD
  regulator: qcom: smd: Regulator driver for the Qualcomm RPM
  ARM: dts: msm8974: Add tcsr mutex node
  ARM: dts: msm8974: Add smem reservation and node
  ARM: dts: msm8974: Add smd, rpm and regulator nodes
  ARM: dts: xperia-honami: Add regulator nodes for Honami

 .../devicetree/bindings/mfd/qcom-rpm-smd.txt       |  117 ++
 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |   79 ++
 .../devicetree/bindings/soc/qcom/qcom,smem.txt     |   51 +
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |  199 +++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  106 ++
 drivers/mfd/Kconfig                                |   14 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/qcom-smd-rpm.c                         |  236 ++++
 drivers/regulator/Kconfig                          |   12 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/qcom_smd-regulator.c             |  350 ++++++
 drivers/soc/qcom/Kconfig                           |   16 +
 drivers/soc/qcom/Makefile                          |    2 +
 drivers/soc/qcom/smd.c                             | 1324 ++++++++++++++++++++
 drivers/soc/qcom/smem.c                            |  775 ++++++++++++
 include/dt-bindings/mfd/qcom-smd-rpm.h             |   28 +
 include/linux/mfd/qcom-smd-rpm.h                   |   35 +
 include/linux/soc/qcom/smd.h                       |   46 +
 include/linux/soc/qcom/smem.h                      |   11 +
 19 files changed, 3403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom-rpm-smd.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smem.txt
 create mode 100644 drivers/mfd/qcom-smd-rpm.c
 create mode 100644 drivers/regulator/qcom_smd-regulator.c
 create mode 100644 drivers/soc/qcom/smd.c
 create mode 100644 drivers/soc/qcom/smem.c
 create mode 100644 include/dt-bindings/mfd/qcom-smd-rpm.h
 create mode 100644 include/linux/mfd/qcom-smd-rpm.h
 create mode 100644 include/linux/soc/qcom/smd.h
 create mode 100644 include/linux/soc/qcom/smem.h

-- 
1.9.3 (Apple Git-50)
