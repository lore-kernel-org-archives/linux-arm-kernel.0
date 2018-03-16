From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 16 Mar 2018 12:51:50 -0600
Subject: [v2 PATCH 0/2] arm64: dts: Add sdm845 GPU/GMU and SMMU
Message-ID: <20180316185152.32020-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resend because I forgot to CC everybody on the patches)

Add DT nodes for the sdm845 GPU/GMU (graphics management unit) and the companion
arm-smmu-v2 compatible SMMU.

This builds on the following dependencies -
https://patchwork.kernel.org/patch/10286369/ - bindings for qcom,level
https://patchwork.kernel.org/patch/10281599/ - qcom,smmu-v2 bindings

Please refer to https://patchwork.freedesktop.org/series/37428/ for the driver
code.

[v2 - changed qcom,arc-level to qcom,level following discussion with Viresh;
change gmu phandle to qcom,gmu per Rob]

Jordan Crouse (2):
  dt-bindings: Document qcom,adreno-gmu
  arm64: dts: sdm845: Add gpu and gmu device nodes

 .../devicetree/bindings/display/msm/gmu.txt        |  54 ++++++++++
 .../devicetree/bindings/display/msm/gpu.txt        |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 119 +++++++++++++++++++++
 3 files changed, 181 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.16.1
