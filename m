From: ohaugan@codeaurora.org (Olav Haugan)
Date: Sun,  3 Aug 2014 17:47:42 -0700
Subject: [PATCH v1 0/2] arm-smmu fixes for CBn_TCR and S2CR/SMR programming
Message-ID: <1407113264-23426-1-git-send-email-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are a couple fixes for the arm smmu driver. The first one deals with
ensuring that we program CBn_TCR correctly when we are programming a stage-1
context bank.
The second patch ensures that the S2CR and SMR registers are programmed
correctly for either stream id matching or stream id indexing. When stream
id matching is not supported by the hardware the SMR registers does not
exists. However, even if they are UNK/SBZP we prefer not to write to more
registers than needed.

Olav Haugan (2):
  iommu/arm-smmu: Fix programming of SMMU_CBn_TCR for stage 1
  iommu/arm-smmu: Correctly program S2CR and SMR registers

 drivers/iommu/arm-smmu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
