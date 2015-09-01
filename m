From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 31 Aug 2015 18:39:51 -0700
Subject: [PATCH 0/3] qcom smd big endian support
Message-ID: <1441071594-15941-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches does some tidying in the beginning to prepare
for adding big endian CPU support to the smd code. It builds on a
previous patch to add big endian support to smem.

Stephen Boyd (3):
  soc: qcom: smd: Represent channel layout in structures
  soc: qcom: smd: Use __iowrite32_copy() instead of open-coding it
  soc: qcom: smd: Handle big endian CPUs

 drivers/soc/qcom/smd.c | 221 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 136 insertions(+), 85 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
