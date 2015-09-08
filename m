From: agross@codeaurora.org (Andy Gross)
Date: Tue,  8 Sep 2015 16:35:19 -0500
Subject: [PATCH 00/11] Add RPM/SMD Support for QCOM platforms
Message-ID: <1441748131-26490-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set cleans up the documentation that is currently in place for the
SMD, SMD-RPM, and SMD-RPM regulators.  In addition, this patch set adds support
for the PM8916 found on MSM8916 platforms and the PMA8084 found on APQ8084
platforms.

All of the relevant DTS information is fleshed out for the regulators and their
dependencies for all of the platforms which support SMD-RPM regulators.

Andy Gross (11):
  soc: qcom: documentation: Update SMD/RPM Docs
  soc: qcom: smd-rpm: Add existing platform support
  arm64: dts: qcom: Add MSM8916 SMEM nodes
  arm64: dts: qcom: Add RPM/SMD support on MSM8916
  arm64: dts: Add PM8916 support on MSM8916
  regulator: qcom-smd: Add PM8916 support
  arm: dts: Add APQ8084 SMEM nodes
  arm: dts: Add RPM/SMD support on APQ8084
  arm: dts: Add support for PMA8084 on APQ8084
  regulator: qcom-smd: Add support for PMA8084
  arm: dts: Add RPM SMD regulator support on MSM8974

 .../devicetree/bindings/soc/qcom,smd-rpm.txt       |  117 --------------
 .../bindings/soc/qcom/qcom,smd-rpm-regulator.txt   |  156 +++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.txt  |   57 +++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  103 +++++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   75 +++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   84 +++++++++++
 drivers/regulator/qcom_smd-regulator.c             |  159 ++++++++++++++++++++
 drivers/soc/qcom/smd-rpm.c                         |    2 +
 8 files changed, 636 insertions(+), 117 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom,smd-rpm.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
