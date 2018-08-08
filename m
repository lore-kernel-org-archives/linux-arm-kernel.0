From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Wed,  8 Aug 2018 16:46:59 -0600
Subject: [v3 PATCH 0/2] arm64: dts: Add sdm845 GPU/GMU and SMMU
Message-ID: <20180808224701.7527-1-jcrouse@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for the sdm845 GPU/GMU (graphics management unit) and the companion
arm-smmu-v2 compatible SMMU.

This builds on the following dependencies -
https://patchwork.kernel.org/patch/10286369/ - bindings for qcom,level
https://patchwork.kernel.org/patch/10281599/ - qcom,smmu-v2 bindings

And requires these two changes for the driver:

https://patchwork.freedesktop.org/patch/243512/ - use new PDC sections
https://patchwork.freedesktop.org/patch/243513/ - use qcom,gmu instead of gmu

I think we are still waiting for the dependencies to merge but this should
at least be usable for anybody with a target that wants to get the GPU up
and happy.

[v3 - Split GMU PDC region into two GPU specific sections, fix indentation,
  really use qcom,gmu for the phandle name]
[v2 - changed qcom,arc-level to qcom,level following discussion with Viresh;
change gmu phandle to qcom,gmu per Rob]

Jordan Crouse (2):
  dt-bindings: Document qcom,adreno-gmu
  arm64: dts: sdm845: Add gpu and gmu device nodes

 .../devicetree/bindings/display/msm/gmu.txt   |  54 ++++++++
 .../devicetree/bindings/display/msm/gpu.txt   |  10 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 121 ++++++++++++++++++
 3 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt

-- 
2.18.0
