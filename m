From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Nov 2015 15:31:15 -0800
Subject: [PATCH v2 0/5] Remove the need for qcom,{msm-id,board-id,pmic-id}
Message-ID: <1448062280-15406-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset documents a compatible string format that encodes
all the information that was being encoded in qcom specific DT
properties in downstream msm kernels. The goal being to come
up with a format that will allow us to express the information
we want to express without requiring the use of vendor specific
properties. An updated dtbTool will be released after these new
bindings are accepted so that users can work with non-updateable
bootloaders.

This is an attempt to resolve a discussion around March of this year[1]
where the arm-soc maintainers suggested we express this information
through the board's compatible string.

Changes from v1:
 * Remove unused elements (mb, panel, boot device)
 * Remove PMICs from board compatible
 * Add patches to allow us to parse PMIC compatibles with aliases

[1] http://lkml.kernel.org/g/1425503602-24916-1-git-send-email-galak at codeaurora.org

Stephen Boyd (5):
  devicetree: bindings: Document qcom board compatible format
  arm64: dts: qcom: Make msm8916-mtp compatible string compliant
  arm: dts: qcom: Update ifc6540 compat for qcom boot format
  arm64: dts: qcom: Alias pm8916 on msm8916 devices
  arm: dts: qcom: Add aliases for PMICs

 Documentation/devicetree/bindings/arm/qcom.txt | 51 ++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts |  2 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts     |  3 +-
 arch/arm/boot/dts/qcom-apq8084-mtp.dts         |  1 +
 arch/arm/boot/dts/qcom-pm8841.dtsi             |  8 ++--
 arch/arm/boot/dts/qcom-pm8941.dtsi             |  8 ++--
 arch/arm/boot/dts/qcom-pma8084.dtsi            |  8 ++--
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts       |  2 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi      |  1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi           |  6 +--
 11 files changed, 74 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
