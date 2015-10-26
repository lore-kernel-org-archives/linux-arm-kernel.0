From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 26 Oct 2015 14:25:09 -0700
Subject: [PATCH 0/3] Remove the need for qcom,{msm-id,board-id,pmic-id}
Message-ID: <1445894712-14350-1-git-send-email-sboyd@codeaurora.org>
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

[1] http://lkml.kernel.org/g/1425503602-24916-1-git-send-email-galak at codeaurora.org

Stephen Boyd (3):
  devicetree: bindings: Document qcom board compatible format
  arm64: dts: qcom: Make msm8916-mtp compatible string compliant
  arm: dts: qcom: Update ifc6540 compat for qcom boot format

 Documentation/devicetree/bindings/arm/qcom.txt | 86 ++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts     |  2 +-
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts       |  2 +-
 3 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
