From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:43 -0700
Subject: [PATCH v2 0/8] SMEM/SMD/SMD_RPM big endian support + tidying
Message-ID: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This supersedes the 3 "series" of patches to move smem to big endian,
smd to big endian, and make qcom_smem_get() return a pointer.

I've moved the qcom_smem_get() returning a pointer part to the beginning
of the series so it can be applied earlier if desired. I imagine the
first 7 patches can go through arm-soc, and the last patch Mark can pick
up anytime. All patches tested on apq8074 dragonboard.

I've already written the patches to add __ioread32_copy(), but I'm
holding them until -rc1 drops because I'd rather not involve even
more people in this series just yet.

Stephen Boyd (8):
  soc: qcom: Make qcom_smem_get() return a pointer
  soc: qcom: smem: Handle big endian CPUs
  soc: qcom: smd: Represent channel layout in structures
  soc: qcom: smd: Use __iowrite32_copy() instead of open-coding it
  soc: qcom: smd: Remove use of VLAIS
  soc: qcom: smd: Handle big endian CPUs
  soc: qcom: smd_rpm: Handle big endian CPUs
  regulator: qcom_smd: Handle big endian CPUs

 drivers/regulator/qcom_smd-regulator.c |  28 ++--
 drivers/soc/qcom/smd-rpm.c             |  68 ++++----
 drivers/soc/qcom/smd.c                 | 259 +++++++++++++++++------------
 drivers/soc/qcom/smem.c                | 293 +++++++++++++++++++--------------
 include/linux/soc/qcom/smem.h          |   2 +-
 5 files changed, 374 insertions(+), 276 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
