From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Tue, 14 Aug 2018 15:57:37 +0530
Subject: [PATCH v2 0/3] Enable smmu support on sdm845
Message-ID: <20180814102740.30222-1-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables apps-smmu (arm,mmu-500) and gpu-smmu (qcom,smmu-v2)
on sdm845. gpu-smmu needs one power domain from gpu clock controller
whose driver was sent by Amit [1].

Changes since v1:
 - Addressed Rob's review comments by adding a SoC specific compatible.
   Have added a new dt-bindings patch for this.
 - Updated node name to 'iommu'.
 - Addressed Doug's review comment about removing status property from
   smmu's nodes, as smmu is either present on the soc or not. Enabling
   it is not a board-level decision.

[1] https://lore.kernel.org/patchwork/patch/973839/

Vivek Gautam (3):
  dt-bindings: arm-smmu: Add binding doc for Qcom smmu-500
  dts: arm64/sdm845: Add node for arm,mmu-500
  dts: arm64/sdm845: Add node for qcom,smmu-v2

 .../devicetree/bindings/iommu/arm,smmu.txt         |  5 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 95 ++++++++++++++++++++++
 2 files changed, 100 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
